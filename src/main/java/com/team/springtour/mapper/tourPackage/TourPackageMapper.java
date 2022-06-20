package com.team.springtour.mapper.tourPackage;

import java.util.List;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;

public interface TourPackageMapper {

	

	int insertBoard(TourPackageDto tourPackage);

	TourPackageDto getTourPackageByPackageName(String packageName);

	List<TourPackageDto> selectTourPackageAll();

	List<String> selectAuthByUserId(String userId);

	List<FlightDto> selectFlightAll();
	
}
