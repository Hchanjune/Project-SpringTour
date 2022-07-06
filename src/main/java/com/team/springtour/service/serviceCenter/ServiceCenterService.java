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

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.mapper.serviceCenter.ServiceCenterMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class ServiceCenterService {

	@Autowired
	private ServiceCenterMapper mapper;
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	public List<ServiceCenterDto> noticeBoard() {
		return mapper.selectBoard();
	}
	

	public ServiceCenterDto getBoard(int indexId) {
		ServiceCenterDto notice = mapper.selectBoardByIndexId(indexId);
		return notice;
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
	public boolean insertBoard(ServiceCenterDto dto, MultipartFile[] files) {
		// 게시글 등록
		int cnt = mapper.insertBoard(dto);
	
		addFiles(dto.getIndexId(), files);
		
		return cnt == 1;
	}
	
	private void addFiles(int indexId, MultipartFile[] files) {
		//파일 등록
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					mapper.insertFile(indexId, file.getOriginalFilename());
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
	
	
	public List<ServiceCenterDto> listServiceCenterPage(int page, int rowPerPage) {
		
		int from = (page-1) * rowPerPage;
		
		return mapper.listServiceCenterPage(from, rowPerPage);
	}


	public int countPostPage() {
		return mapper.countPostPage();
	}
	
	

	public ServiceCenterDto getPostByIndexId(int indexId) {
		ServiceCenterDto notice = mapper.selectBoardByIndexId(indexId);
		List<String> fileNames = mapper.selectFileNameByNotice(indexId);
		
		notice.setFileName(fileNames);
		
		return notice;
		 
	}

	
	
	@Transactional
	public boolean updatePost(ServiceCenterDto post, ArrayList<String> removeFileList, MultipartFile[] addFileList) {
		
		if(removeFileList != null) {
			for(String fileName : removeFileList) {
				deleteFromAwsS3(post.getIndexId(), fileName);
				mapper.deleteFileByNoticeIdAndFileName(post.getIndexId(), fileName);
			}
		}
		
		if(addFileList != null) {
			addFiles(post.getIndexId(), addFileList);
		}
		int cnt = mapper.updatePost(post);
		return cnt == 1;
	}
	
	
	
	@Transactional
	public boolean deletePost(int indexId) {
		
		List<String> fileList = mapper.selectFileNameByNotice(indexId);
		removeFiles(indexId, fileList);
		return mapper.deletePost(indexId) == 1;
	}
	
	
	private void removeFiles (int indexId, List<String> fileList) {
		
		for (String fileName : fileList) {
			deleteFromAwsS3(indexId, fileName);
		}
		mapper.deleteFileByNoticeId(indexId);
	}

	private void deleteFromAwsS3(int indexId, String fileName) {
		String key = "serviceCenter/" + indexId + "/" + fileName;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
	}

	
	public List<ServiceCenterDto> searchPost(String type, String keyword, int page, int rowPerPage) {
		String Keyword = "%" + keyword + "%";
		
		int from = (page-1) * rowPerPage;
		
		return mapper.selectSearchAll(type, Keyword, from, rowPerPage);
	}


	public int countSearchedPostPage(String type, String keyword) {
		String Keyword = "%" + keyword + "%";
		
		return mapper.countSearchedPostPage(type, Keyword);
	}

	
	
	
	
	
	
	// freq - 자주묻는 질문 -----------------------------------------------------------------------------------------------

	/*	public ServiceCenterDto getFreqPost() {
			ServiceCenterDto freq = mapper.selectFreqPost();
			return freq;
		}
	
	
		public List<ServiceCenterDto> listFreqPage(int page, int rowPerPage) {
			
			int from = (page-1) * rowPerPage;
			
			return mapper.listFreqPage(from, rowPerPage);
		}
	
	
		public List<ServiceCenterDto> freqSearchPost(String type, String keyword, int page, int rowPerPage) {
				String Keyword = "%" + keyword + "%";
				
			int from = (page-1) * rowPerPage;
				
			return mapper.selectFreqSearchAll(type, Keyword, from, rowPerPage);
		}
	
	
		public int countFreqPostPage() {
			return mapper.countFreqPostPage();
		}
	
	
	
		public boolean insertFreq(ServiceCenterDto freq) {
			
	    //int cnt = mapper.insertFreqList(freq);
			int cnt = mapper.insertBoard(freq);
			
			return cnt == 1;
		}*/

}










