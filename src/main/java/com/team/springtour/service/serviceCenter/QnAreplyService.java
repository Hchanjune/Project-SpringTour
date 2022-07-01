package com.team.springtour.service.serviceCenter;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.serviceCenter.QnAreplyDto;
import com.team.springtour.mapper.serviceCenter.QnAreplyMapper;

@Service
public class QnAreplyService {
	
	@Autowired
	private QnAreplyMapper mapper;


	public boolean insertQnaReply(QnAreplyDto dto) {
		//		dto.setInserted(LocalDateTime.now());
		return mapper.insertQnaReply(dto) == 1;
	}

	public List<QnAreplyDto> getReplyByqQnaIndexId(int replyIndexId) {

		return mapper.selectAllQnaIndexId(replyIndexId, null);
	}

	public boolean updateQnaReply(QnAreplyDto dto, Principal principal) {

		QnAreplyDto old = mapper.selectQnaReplyByIndexId(dto.getReplyIndexId());

		if (old.getQnaContent().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을때만 수정
			return mapper.updateQnaReply(dto) == 1;

		} else {
			// 그렇지 않으면 return false;
			return false;
		}
	}

	public boolean deleteQnaReply(int replyIndexId, Principal principal) {

		QnAreplyDto old = mapper.selectQnaReplyByIndexId(replyIndexId);

		if (old.getQnaContent().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을때만 삭제
			return mapper.deleteQnaReply(replyIndexId) == 1;
		} else {

			return false;
		}
	}

	public List<QnAreplyDto> getReplyWithOwnByQnaIndexId(int replyIndexId, String qnaContent) {

		return mapper.selectAllQnaIndexId(replyIndexId, qnaContent);
	}

	
}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


