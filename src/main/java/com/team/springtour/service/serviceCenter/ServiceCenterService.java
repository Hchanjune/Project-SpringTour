package com.team.springtour.service.serviceCenter;

import java.util.List;

import org.apache.ibatis.annotations.Param;
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

	public List<ServiceCenterDto> listServiceCenterPage(int page, int rowPerPage) {
		
		int from = (page-1) * rowPerPage;
		
		return mapper.listServiceCenterPage(from, rowPerPage);
	}


	public int countPostPage() {
		return mapper.countPostPage();
	}

	public ServiceCenterDto getPostByIndexId(int indexId) {
		return mapper.selectPostByIndexId(indexId);
	}


	public boolean updatePost(ServiceCenterDto post) {
		int cnt = mapper.updatePost(post);
		return cnt == 1;
	}

	public boolean deletePost(int indexId) {
		return mapper.deletePost(indexId) == 1;
	}

	public List<ServiceCenterDto> searchPost(String type, String keyword) {
		return mapper.selectSearchAll(type, "%" + keyword + "%");
	}
	
}










