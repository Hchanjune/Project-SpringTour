package com.team.springtour.mapper.serviceCenter;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.serviceCenter.FreqDto;

public interface FreqMapper {

	
	
	FreqDto selectFreqPost();

	List<FreqDto> listFreqPage(@Param("from")int from, @Param("row")int row);

	int countFreqPostPage();

	List<FreqDto> selectFreqSearchAll(@Param("type")String type, 
												@Param("Keyword")String Keyword, 
												@Param("from")int from, 
												@Param("row")int row);

	int insertFreqList(FreqDto freq);

	int countSearchedFreqPage(@Param("type")String type, @Param("keyword")String searchKeyword);

	FreqDto selectFreqPostByIndexId(int freqIndexId);

	int updateFreqPost(FreqDto freqPost);

	int deleteFreqPost(int freqIndexId);

	
	
}
