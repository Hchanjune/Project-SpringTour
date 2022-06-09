package com.team.springtour.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.springtour.domain.user.UserDto;
import com.team.springtour.mapper.user.UserMapper;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Transactional
	public boolean registerUser(UserDto user) {
		
		user.setPassword(encodePassword(user.getPassword()));
		
		int registerUser = userMapper.insertUser(user);
		int registerAuthority = userMapper.insertAuthority(user.getId());
		
		return registerUser == 1 && registerAuthority == 1;
	}
	
	private String encodePassword(String password) {
		return passwordEncoder.encode(password);
	}

}
