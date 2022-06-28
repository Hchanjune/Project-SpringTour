package com.team.springtour.mapper.serviceCenter;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.serviceCenter.QnAreplyDto;

public interface QnAreplyMapper {


	List<QnAreplyDto> listQnaPost();

	int insertQnaReply(QnAreplyDto dto);
	
	List<QnAreplyDto> selectAllQnaIndexId(@Param("replyIndexId")int replyIndexId, @Param("qnaContent")String qnaContent);
	
	QnAreplyDto selectQnaReplyByIndexId(int replyIndexId);

	List<QnAreplyDto> listQnaPage(@Param("from")int from, @Param("row")int row);

	int countQnaPage();

    int updateQnaReply(QnAreplyDto dto);
		
	void deleteByWriterId(int replyIndexId);
	
	int deleteQnaReply(int replyIndexId);
			
	void deleteByQnaContent(String qnaContent);
	



}
