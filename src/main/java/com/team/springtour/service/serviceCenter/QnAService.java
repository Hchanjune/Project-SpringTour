package com.team.springtour.service.serviceCenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.mapper.serviceCenter.QnAMapper;

@Service
public class QnAService {

	@Autowired
	private QnAMapper mapper;
	
	public List<QnADto> listQnA(QnADto qna) {
		return mapper.selectQnAList(qna);
	}

	public boolean insertQnA(QnADto qna) {
		int cnt = mapper.insertQnA(qna);
		return cnt == 1;
	}

	public QnADto getQnAByIndexId(int indexId) {
		QnADto post = mapper.selectQnAByIndexId(indexId);
		
		return post;
	}

	
}
