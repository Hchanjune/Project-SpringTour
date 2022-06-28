package com.team.springtour.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.user.EnquiryCategoryDto;
import com.team.springtour.domain.user.PrivateEnquiryDto;
import com.team.springtour.domain.user.UserDto;

public interface UserMapper {

	int insertUser(UserDto user);

	int insertAuthority(String userId);

	int countUserId(String id);

	int countUserEmail(String email);

	void insertUserAuthKey(@Param("userId")String userId, @Param("authKey")String key);

	UserDto selectUserById(String userId);

	int updateUserAuthority(@Param("userId")String userId, @Param("auth")String auth);

	int updateUserInfoByUserId(UserDto user);

	List<UserDto> selectUserListAll();

	int updateUserAuthKey(String userId);

	String selectUserIdByEmail(String email);

	void insertUserPasswordChangeKey(@Param("userId")String userId, @Param("pwChangeKey")String key);

	int updateUserPasswordChangeKey(String userId);

	int updateUserPasswordByUserId(@Param("userId")String userId, @Param("newPassword")String updatedPassword);

	List<EnquiryCategoryDto> selectEnquiryCategoryAll();

	List<PrivateEnquiryDto> selectPrivateEnquiryByUserId(String userId);

	int insertPrivateEnquiry(PrivateEnquiryDto privateEnquiry);

	PrivateEnquiryDto selectPrivateEnquiryByIndexId(int indexId);

	List<PrivateEnquiryDto> selectPrivateEnquiryAll();

	int updatePrivateEnquiryByReply(PrivateEnquiryDto privateEnquiry);

}
