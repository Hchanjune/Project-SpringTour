package com.team.springtour.mapper.tourPackage;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.tourPackage.ReviewReplyDto;



public interface ReviewReplyMapper {
	int insertReply(ReviewReplyDto dto);

	List<ReviewReplyDto> selectAllBoardId(@Param("reviewId")int reviewId, @Param("memberId")String memberId);

	int updateReply(ReviewReplyDto dto);

	int deleteReply(int replyId);

	void deleteByBoardId(int reviewId);

	ReviewReplyDto selectReplyById(int replyId);

	void deleteByMemberId(String memberId);
}
