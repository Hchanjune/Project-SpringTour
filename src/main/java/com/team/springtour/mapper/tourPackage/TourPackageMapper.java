package com.team.springtour.mapper.tourPackage;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;

public interface TourPackageMapper {

	

	int insertTourPackage(TourPackageDto tourPackage);

	TourPackageDto getTourPackageByPackageName(String packageName);

	List<TourPackageDto> selectTourPackageAll();

	List<String> selectAuthByUserId(String userId);

	List<FlightDto> selectFlightAll();



	void insertFile(@RequestParam("packageName")String packageName, @RequestParam("fileName")String filename);

	List<String> selectFileNameByBoard(String packageName);

	int updateTourPackage(TourPackageDto dto);

	void deleteFileByBoardIdAndFileName(@RequestParam("tourPackgeName")String packageName, @RequestParam("fileName")String fileName);

	int deleteTourPackage(String packageName);

	void deleteFileByBoardId(String packageName);


	
}
