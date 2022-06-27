package com.team.springtour.service.tourPackage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.domain.tourPackage.ReviewDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.domain.user.UserDto;
import com.team.springtour.mapper.tourPackage.ReviewMapper;
import com.team.springtour.mapper.tourPackage.TourPackageMapper;

@Service
public class ReviewService {

	@Autowired
	private ReviewMapper mapper;
	
	
	public List<ReviewDto> ReviewList() {
		// TODO Auto-generated method stub
		 return mapper.selectReviewAll();
	}




	public boolean insertReview(ReviewDto dto) {
		
		int cnt = mapper.insertReview(dto);
				
		return cnt==1;
	}




	public List<TourPackageDto> TourList() {
		// TODO Auto-generated method stub
		return mapper.selectTourListAll();
	}




	public ReviewDto getReviewByIndexId(int indexId) {
		ReviewDto review = mapper.getReviewByIndexId(indexId);
		return review;
	}




	public List<ServiceCenterDto> ServiceList() {
		// TODO Auto-generated method stub
		return mapper.selectServiceListAll();
	}




	public List<UserDto> UserList() {
		// TODO Auto-generated method stub
		return mapper.selectUserListAll();
	}




	public ReviewDto getReviewById(int indexId) {
		ReviewDto board = mapper.selectReviewById(indexId);
		
		return board;
	}




	public boolean updateReview(ReviewDto dto) {
		int cnt = mapper.updateReview(dto);
		
		return cnt == 1;
	}




	public boolean deleteReview(int indexId) {
		// TODO Auto-generated method stub
		return mapper.deleteReview(indexId) == 1;
	}




	public boolean getAuthByUserId(String userId) {
		List<String> authList = mapper.selectAuthByUserId(userId);
		return authList.contains("ROLE_ADMIN");
	}




	
	
	
	
}
