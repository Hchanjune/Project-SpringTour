package com.team.springtour.service.tourPackage;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.tourPackage.ReviewReplyDto;
import com.team.springtour.mapper.tourPackage.ReviewMapper;
import com.team.springtour.mapper.tourPackage.ReviewReplyMapper;



@Service
public class ReviewReplyService {
	
	
	
	@Autowired
	private ReviewReplyMapper mapper;
	
	public boolean insertReply(ReviewReplyDto dto) {
//		dto.setInserted(LocalDateTime.now());
		return mapper.insertReply(dto) == 1;
	}

	public List<ReviewReplyDto> getReplyByBoardId(int reviewId) {
		// TODO Auto-generated method stub
		return mapper.selectAllBoardId(reviewId,null);
	}

	public boolean updateReply(ReviewReplyDto dto) {
		// TODO Auto-generated method stub
		return mapper.updateReply(dto) == 1;
	}

	public boolean deleteReply(int replyId, Principal principal) {
		ReviewReplyDto old = mapper.selectReplyById(replyId);
		
		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 수정
			return mapper.deleteReply(replyId) == 1;
		} else {
			// 그렇지 않으면 return false;
			return false;
		}
		
		
		
		
	}

	public boolean updateReply(ReviewReplyDto dto, Principal principal) {
		ReviewReplyDto old = mapper.selectReplyById(dto.getReplyId());
		
		if (old.getMemberId().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 수정
			return mapper.updateReply(dto) == 1;
		} else {
			// 그렇지 않으면 return false;
			return false;
		}
	}

	public List<ReviewReplyDto> getReplyByWithOwnBoardId(int reviewId, String memberId) {
	
		return mapper.selectAllBoardId(reviewId, memberId);
	}

	

}
