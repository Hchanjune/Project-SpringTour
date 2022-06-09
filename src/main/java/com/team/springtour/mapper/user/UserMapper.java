package com.team.springtour.mapper.user;

import com.team.springtour.domain.user.UserDto;

public interface UserMapper {

	int insertUser(UserDto user);

	int insertAuthority(String userId);

}
