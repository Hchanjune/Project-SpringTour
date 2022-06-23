package com.team.springtour.mapper.tourPackage;

import java.util.List;

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.domain.tourPackage.ReviewDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.domain.user.UserDto;

public interface ReviewMapper {

	List<ReviewDto> selectReviewAll();

	int insertReview(ReviewDto dto);

	List<TourPackageDto> selectTourListAll();

	ReviewDto getReviewByIndexId(int indexId);

	List<ServiceCenterDto> selectServiceListAll();

	List<UserDto> selectUserListAll();

	ReviewDto selectReviewById(int indexId);

	int updateReview(ReviewDto dto);

	int deleteReview(int indexId);

	List<String> selectAuthByUserId(String userId);


	
	
	
}
