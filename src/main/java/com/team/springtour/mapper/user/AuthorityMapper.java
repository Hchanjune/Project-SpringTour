package com.team.springtour.mapper.user;

import java.util.List;

public interface AuthorityMapper {

	List<String> selectRoleByUserId(String userId);

}
