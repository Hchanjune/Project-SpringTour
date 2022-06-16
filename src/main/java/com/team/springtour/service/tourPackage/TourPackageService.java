package com.team.springtour.service.tourPackage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
