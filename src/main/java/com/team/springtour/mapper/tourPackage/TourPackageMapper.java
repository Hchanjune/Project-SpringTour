package com.team.springtour.mapper.tourPackage;

import java.util.List;

import com.team.springtour.domain.tourPackage.TourPackageDto;

public interface TourPackageMapper {

	List<TourPackageDto> selectTourPackageAll();
	
}
