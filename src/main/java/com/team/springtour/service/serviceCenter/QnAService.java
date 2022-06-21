package com.team.springtour.service.serviceCenter;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.mapper.serviceCenter.QnAMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class QnAService {

	@Autowired
	private QnAMapper mapper;
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	public List<QnADto> listQnA() {
		return mapper.selectQnAList();
	}

	
	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}
	
	@PreDestroy
	public void destroy() {
		this.s3.close();
	}
	
	@Transactional
	public boolean insertQnA(QnADto qna, MultipartFile[] files) {
		
		int cnt = mapper.insertQnA(qna);
		
		addFiles(qna.getIndexId(), files);
		
		return cnt == 1;
	}
	
	private void addFiles(int indexId, MultipartFile[] files) {
		//파일 등록
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					mapper.insertQnaFile(indexId, file.getOriginalFilename());
					saveFileAwsS3(indexId, file); // s3에 업로드			
				}
			}
		}
	}
	
	private void saveFileAwsS3(int indexId, MultipartFile file) {
		String key = "ServiceCenter/" + indexId + "/" + file.getOriginalFilename();
		
		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName)
				.key(key)
				.build();
		
		RequestBody requestBody;
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		
	}

	private void saveFile(int indexId, MultipartFile file) {
		// 디렉토리 만들기		
		String pathStr = "C:/imgtmp/notice/" + indexId + "/";
		File path = new File(pathStr);
		path.mkdirs();
		
		// 작성할 파일
		File des = new File(pathStr + file.getOriginalFilename());
		
		try {
			// 파일 저장
			file.transferTo(des);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
	}
	


	/*	public QnADto qnaPageByIndexId(int indexId) {
			QnADto post = mapper.selectQnaByIndexId(indexId);
			return post;
		}*/

	public List<QnADto> listQnaPage(int qnaPage, int rowPerPage) {
		
		int from = (qnaPage-1) * rowPerPage;
		
		return mapper.listQnaPage(from, rowPerPage);
	}
	

	public int countQnaPage() {
		return mapper.countQnaPage();
	}

	
	public QnADto getQnaPostByIndexId(int indexId) {
		QnADto qnaList = mapper.selectQnaPostByIndexId(indexId);
		List<String> fileNames = mapper.selectFileNameByQnaList(indexId);
		
		qnaList.setFileName(fileNames);
		
		return qnaList;
	}
	
	
	public List<QnADto> searchQnaPost(String type, String keyword, int qnaPage, int rowPerPage) {
		String searchKeyword = "%" + keyword + "%";
		
		int from = (qnaPage-1) * rowPerPage;
		
		return mapper.selectSearchQnaAll(type,searchKeyword, from, rowPerPage);
	}

	public int countSearchedQnaPostPage(String type, String keyword) {
		String searchKeyword = "%" + keyword + "%";
		return mapper.countSearchQnaPage(type, searchKeyword);
	}

	@Transactional
	public boolean updateQnaPost(QnADto qnaPost, ArrayList<String> removeFileList, MultipartFile[] addFileList) {
		if(removeFileList != null) {
			for(String fileName : removeFileList) {
				deleteFromAwsS3(qnaPost.getIndexId(), fileName);
				mapper.deleteFileByQnaIdAndFileName(qnaPost.getIndexId(), fileName);
			}
		}
		
		if(addFileList != null) {
			addFiles(qnaPost.getIndexId(), addFileList);
		}
		int cnt = mapper.updateQnaPost(qnaPost);
		return cnt == 1;
	}

	@Transactional
	public boolean deletePost(int indexId) {
		
		List<String> fileList = mapper.selectFileNameByQnaList(indexId);
		removeFiles(indexId, fileList);
		return mapper.deleteQnaPost(indexId) == 1;
	}
	
	
	private void removeFiles (int indexId, List<String> fileList) {
		
		for (String fileName : fileList) {
			deleteFromAwsS3(indexId, fileName);
		}
		mapper.deleteFileByQnaId(indexId);
	}

	private void deleteFromAwsS3(int indexId, String fileName) {
		String key = "serviceCenter/" + indexId + "/" + fileName;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
	}
	
}
