package com.team.springtour.mapper.serviceCenter;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;

public interface ServiceCenterMapper {

	List<ServiceCenterDto> selectBoard();

	ServiceCenterDto selectBoardByIndexId(int indexId);
	
	int insertBoard(ServiceCenterDto dto);
	
	
	List<ServiceCenterDto> listServiceCenterPage
	(@Param("from")int from, @Param("row")int row);

	int countPostPage();

	ServiceCenterDto selectPostByIndexId(int indexId);

	int updatePost(ServiceCenterDto post);

	int deletePost(int indexId);

	List<ServiceCenterDto> selectSearchAll(@Param("type")String type, 
											@Param("keyword")String searchKeyword, 
											@Param("from") int from, 
											@Param("row")int row);

	void insertFile(@Param("noticeIndexId")int noticeIndexId, @Param("fileName")String fileName);

	List<String> selectFileNameByNotice(int noticeIndexId);

	void deleteFileByNoticeId(int indexId);

	void deleteFileByNoticeIdAndFileName(@Param("indexId")int indexId, @Param("fileName")String fileName);

	int countSearchedPostPage(@Param("type")String type, @Param("keyword")String searchKeyword);

	
	
	
	// freq-자주묻는질문 -----------------------------------------------------------------------------------------------
	
	/*	ServiceCenterDto selectFreqPost();
	
		List<ServiceCenterDto> listFreqPage(@Param("from")int from, @Param("row")int row);
	
		int countFreqPostPage();
	
		List<ServiceCenterDto> selectFreqSearchAll(@Param("type")String type, 
													@Param("Keyword")String Keyword, 
													@Param("from")int from, 
													@Param("row")int row);
	
		int insertFreqList(ServiceCenterDto freq);*/




	
}
