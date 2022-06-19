package com.team.springtour.service.tourPackage;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.mapper.tourPackage.TourPackageMapper;

@Service
public class TourPackageService {

	@Autowired
	private TourPackageMapper mapper;
	
	
	public List<TourPackageDto> TourList() {
		// TODO Auto-generated method stub
		return mapper.selectTourPackageAll();
	}

	
	public boolean insertTourPackage(TourPackageDto tourPackage, MultipartFile[] file) {
		
		
		int cnt=mapper.insertBoard(tourPackage);
		
		// 파일 등록
//		addFiles(board.getId(), files);
		return cnt==1;
	}

	
	//패키지명추가하기
	public TourPackageDto getTourPackageByPackageName(String packageName) {
		
		TourPackageDto tourPackage = mapper.getTourPackageByPackageName(packageName);
	//	List<String> fileNames = mapper.selectFileNameByBoard(id);
	//	board.setFileName(fileNames);
		
		return tourPackage;
	}

	//패키지 업데이트하기
	public boolean updateTourPackage(ArrayList<String> removeFileList, MultipartFile[] addFileList) {
		// TODO Auto-generated method stub
		return false;
	}


	public boolean deleteTourPackage() {
		// TODO Auto-generated method stub
		return false;
	}


	

}
