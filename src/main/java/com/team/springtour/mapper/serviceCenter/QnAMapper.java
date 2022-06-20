package com.team.springtour.mapper.serviceCenter;

import java.util.List;

import com.team.springtour.domain.serviceCenter.QnADto;

public interface QnAMapper {

	List<QnADto> selectQnAList(QnADto qna);

	int insertQnA(QnADto qna);

	QnADto selectQnAByIndexId(int indexId);

}
