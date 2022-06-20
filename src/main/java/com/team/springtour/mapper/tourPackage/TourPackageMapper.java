package com.team.springtour.mapper.tourPackage;

import java.util.List;

import com.team.springtour.domain.tourPackage.TourPackageDto;

public interface TourPackageMapper {

	int insertBoard(TourPackageDto tourPackage);

	TourPackageDto getTourPackageByPackageName(String packageName);

	List<TourPackageDto> selectTourPackageAll();
	
}
