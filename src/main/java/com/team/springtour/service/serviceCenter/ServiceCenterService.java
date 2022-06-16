package com.team.springtour.service.serviceCenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.mapper.serviceCenter.ServiceCenterMapper;

@Service
public class ServiceCenterService {

	@Autowired
	private ServiceCenterMapper mapper;
	
	public List<ServiceCenterDto> noticeBoard() {
		return mapper.selectBoard();
	}

	public ServiceCenterDto getBoard(int indexId) {
		ServiceCenterDto notice = mapper.selectBoardByIndexId(indexId);
		return notice;
	}

	public boolean insertBoard(ServiceCenterDto dto) {
		int cnt = mapper.insertBoard(dto);
		return cnt == 1;
	}
	
}
