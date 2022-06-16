package com.team.springtour.service.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.springtour.domain.user.UserDto;
import com.team.springtour.mapper.user.AuthorityMapper;
import com.team.springtour.mapper.user.UserMapper;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	@Autowired
	AuthorityMapper authMapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private MailService mailService;

	@Transactional
	public boolean registerUser(UserDto user, HttpServletRequest request) {
		
		user.setPassword(encodePassword(user.getPassword()));
		
		int registerUser = userMapper.insertUser(user);
		int registerAuthority = userMapper.insertAuthority(user.getId());
		if (registerUser == 1 && registerAuthority == 1) {
			mailService.mailSendWithUserKey(user.getEmail(), user.getId(), request);
			return true;
		}else {
			return false;
		}	
	}
	
	private String encodePassword(String password) {
		return passwordEncoder.encode(password);
	}

	public boolean checkUserId(String id) {
		return userMapper.countUserId(id) > 0;
	}

	public boolean checkUserEmail(String email) {
		return userMapper.countUserEmail(email) > 0;
	}

	public boolean confirmUser(String userId, String authKey) {
		UserDto user = userMapper.selectUserById(userId);
		
		System.out.println(user.getAuthKey());
		System.out.println(authKey);
		
		if (user.getAuthKey().equals(authKey)) {
			return userMapper.updateUserAuthority(user.getId(), "ROLE_USER") == 1;
		}else {
			return false;
		}
	}

	public boolean checkUserLoginAuthority(String userId) {
		List<String> authList = authMapper.selectRoleByUserId(userId);
		if (authList.contains("ROLE_USER") || authList.contains("ROLE_ADMIN")) {
			return true;
		}else {
			return false;
		}	
	}

	public void resendRegisterMail(String userId, HttpServletRequest request) {
		UserDto user = userMapper.selectUserById(userId);
		mailService.mailSendWithUserKey(user.getEmail(), user.getId(), request);
	}

}
