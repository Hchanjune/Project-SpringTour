package com.team.springtour.mapper.serviceCenter;

import java.util.List;

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;

public interface ServiceCenterMapper {

	List<ServiceCenterDto> selectBoard();

	ServiceCenterDto selectBoardByIndexId(int indexId);
	
	int insertBoard(ServiceCenterDto dto);


	

	
}
