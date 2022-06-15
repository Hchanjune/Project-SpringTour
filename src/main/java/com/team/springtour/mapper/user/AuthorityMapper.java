package com.team.springtour.mapper.user;

import com.team.springtour.domain.user.AuthorityDto;

public interface AuthorityMapper {

	AuthorityDto selectRoleByUserId(String userId);

}
