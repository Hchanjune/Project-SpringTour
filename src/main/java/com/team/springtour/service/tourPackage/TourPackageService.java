package com.team.springtour.service.tourPackage;

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

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.mapper.tourPackage.TourPackageMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class TourPackageService {

	@Autowired
	private TourPackageMapper mapper;

	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}

	@PreDestroy
	public void destroy() {
		this.s3.close();
	}

	private S3Client s3;

	@Value("${aws.s3.bucketName}")
	private String bucketName;

	public List<TourPackageDto> TourList(String type, String keyword) {
		// TODO Auto-generated method stub
		return mapper.selectTourPackageAll();
	}

	@Transactional
	public boolean insertTourPackage(TourPackageDto tourPackage, MultipartFile[] files) {

		int cnt = mapper.insertTourPackage(tourPackage);

		// 파일 등록
		addFiles(tourPackage.getPackageName(), files);
		return cnt == 1;
	}

	private void addFiles(String packageName, MultipartFile[] files) {
		if (files != null) {
			for (MultipartFile file : files) {

				if (file.getSize() > 0) {
					mapper.insertFile(packageName, file.getOriginalFilename());
					//		saveFile(board.getId(),file);
					saveFileAwsS3(packageName, file); // s3에 업로드

				}
			}
		}

	}

	private void saveFileAwsS3(String packageName, MultipartFile file) {
		String key = "tourPackage/" + packageName + "/" + file.getOriginalFilename();

		PutObjectRequest putObjectRequest = PutObjectRequest.builder().acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName).key(key).build();
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

	private void saveFile(String packageName, MultipartFile file) {

		//디렉토리 만들기
		String pathStr = "C:/imgtmp/tourPackage/" + packageName + "/";
		File path = new File(pathStr);
		path.mkdirs();

		//작성할 파일
		File des = new File(pathStr + file.getOriginalFilename());

		try {
			file.transferTo(des);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
	



	//패키지명추가하기
	public TourPackageDto getTourPackageByPackageName(String packageName) {

		TourPackageDto tourPackage = mapper.getTourPackageByPackageName(packageName);
		List<String> fileNames = mapper.selectFileNameByPackage(packageName);
		tourPackage.setFileName(fileNames);

		return tourPackage;
	}
	
	

	@Transactional
	public boolean updateTourPackage(TourPackageDto dto, MultipartFile[] addFileList, List<String> removeFileList) {

		if (removeFileList != null) {

			for (String fileName : removeFileList) {
				deleteFromAwsS3(dto.getPackageName(), fileName);
				mapper.deleteFileByPackageIdAndFileName(dto.getPackageName(), fileName);
			}

		}

		if (addFileList != null) {
			// File 테이블에 추가된 파일 insert

			// s3에 upload
			addFiles(dto.getPackageName(), addFileList);
		}

		// Board 테이블 update
		int cnt = mapper.updateTourPackage(dto);

		return cnt == 1;
	}
	//패키지 업데이트하기

	private void deleteFromAwsS3(String packageName, String fileName) {
		String key = "tourPackage/" + packageName + "/" + fileName;
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();

		s3.deleteObject(deleteObjectRequest);

	}

	@Transactional
	public boolean deleteTourPackage(String packageName) {
		List<String> fileList = mapper.selectFileNameByPackage(packageName);

		// s3에서 지우기
		removeFiles(packageName, fileList);

		return mapper.deleteTourPackage(packageName) == 1;
	}

	private void removeFiles(String packageName, List<String> fileList) {
		for (String fileName : fileList) {
			deleteFromAwsS3(packageName, fileName);
		}

		// 파일 테이블 삭제
		mapper.deleteFileByTourPackageName(packageName);

	}

	public boolean getAuthByUserId(String userId) {
		List<String> authList = mapper.selectAuthByUserId(userId);
		return authList.contains("ROLE_ADMIN");
	}

	public List<FlightDto> FlightList() {
		// TODO Auto-generated method stub
		return mapper.selectFlightAll();
	}


}
