package com.team.springtour.mapper.serviceCenter;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.serviceCenter.QnAreplyDto;

public interface QnAreplyMapper {

	int insertQnaReply(QnAreplyDto reply);

	List<QnAreplyDto> selectAllQnaIndexId(@Param("writerId")int writerId, @Param("qnaContent")String qnaContent);

	QnAreplyDto selectQnaReplyByIndexId(int qnaIndexId);

	int updateQnaReply(QnAreplyDto dto);
	
	void deleteByWriterId(int writerId);

	int deleteQnaReply(int qnaIndexId);
	
	void deleteByQnaContent(String qnaContent);




}
