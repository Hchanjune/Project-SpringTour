package com.team.springtour.mapper.tourPackage;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;

public interface TourPackageMapper {

	

	int insertTourPackage(TourPackageDto tourPackage);

	TourPackageDto getTourPackageByPackageName(String packageName);

	List<TourPackageDto> selectTourPackageAll();

	List<String> selectAuthByUserId(String userId);

	List<FlightDto> selectFlightAll();



	void insertFile(@Param("tourPackageName")String tourPackageName, @Param("fileName")String filename);

	List<String> selectFileNameByPackage(String packageName);

	int updateTourPackage(TourPackageDto dto);

	void deleteFileByPackageIdAndFileName(@Param("packageName")String packageName, @Param("fileName")String fileName);

	int deleteTourPackage(String packageName);

	void deleteFileByTourPackageName(String packageName);


	
}
