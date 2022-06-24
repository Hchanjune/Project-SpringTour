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
	public boolean insertQnA(QnADto qna) {
		
		int cnt = mapper.insertQnA(qna);

		return cnt == 1;
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
	public boolean updateQnaPost(QnADto qnaPost) {
	
		int cnt = mapper.updateQnaPost(qnaPost);
		return cnt == 1;
	}

	@Transactional
	public boolean deletePost(int indexId) {

		return mapper.deleteQnaPost(indexId) == 1;
	}
	

}
