package com.team.springtour.service.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.team.springtour.domain.user.DirectMessageDto;
import com.team.springtour.domain.user.EnquiryCategoryDto;
import com.team.springtour.domain.user.PrivateEnquiryDto;
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
	@Autowired
	private DirectMessageService messageService;

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
	
	@Transactional
	public boolean confirmUser(String userId, String authKey) {
		UserDto user = userMapper.selectUserById(userId);
		if (user.getAuthKey().equals(authKey)) {
			return userMapper.updateUserAuthority(user.getId(), "ROLE_USER") == 1 && userMapper.updateUserAuthKey(user.getId()) == 1;
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

	public UserDto getUserById(String userId) {
		return userMapper.selectUserById(userId);
	}

	public boolean modifyUserInfo(UserDto user) {
		return userMapper.updateUserInfoByUserId(user) == 1;
	}

	public List<UserDto> getUserListAll() {
		return userMapper.selectUserListAll();
	}

	public void forgotIdService(String email) {
		String userId = userMapper.selectUserIdByEmail(email);
		String title = "[SpringTour] 요청하신 아이디 찾기 결과입니다.";
		String body = "<p>고객님의 아이디는" + userId + "입니다.</p>";
		mailService.sendMail(email, title, body);
	}

	public boolean idAndEmailCheck(String id, String email) {
		UserDto user = userMapper.selectUserById(id);
		if (user == null) {
			return false;
		}
		return user.getEmail().equals(email);
	}
	
	@Transactional
	public boolean confirmUserPwChangeKey(String userId, String pwChangeKey) {
		UserDto user = userMapper.selectUserById(userId);
		if (user.getPasswordChangeKey().equals(pwChangeKey)) {
			return userMapper.updateUserPasswordChangeKey(user.getId()) == 1;
		}else {
			return false;
		}
	}

	public void forgotPwService(String id, String email, HttpServletRequest request) {
		mailService.mailSendWithChangePasswordLink(email, id, request);
		
	}

	@Transactional
	public boolean modifyUserPasswordByUserId(String userId, String newPassword) {
		String updatedPassword = encodePassword(newPassword);	
		return userMapper.updateUserPasswordByUserId(userId, updatedPassword) == 1;
	}

	public List<EnquiryCategoryDto> getCategoryList() {
		return userMapper.selectEnquiryCategoryAll();
	}

	public List<PrivateEnquiryDto> getPrivateEnquiryByUserId(String userId) {
		return userMapper.selectPrivateEnquiryByUserId(userId);
	}

	public boolean insertPrivateEnquiry(PrivateEnquiryDto privateEnquiry) {
		return userMapper.insertPrivateEnquiry(privateEnquiry) == 1;
	}

	public PrivateEnquiryDto getPrivateEnquiryByIndexId(int indexId) {
		return userMapper.selectPrivateEnquiryByIndexId(indexId);
	}

	public List<PrivateEnquiryDto> getPrivateEnquiryAll() {
		return userMapper.selectPrivateEnquiryAll();
	}

	public boolean replyPrivateEnquiry(PrivateEnquiryDto privateEnquiry) {
		UserDto user = userMapper.selectUserById(privateEnquiry.getClientName());
		boolean success = userMapper.updatePrivateEnquiryByReply(privateEnquiry) == 1;
		if (success) {
			//Email
			String title = "[SpringTour] 1:1문의 답변이 등록되었습니다.";
			String body = "등록하신 1:1문의 글에 답변이 등록되었습니다.";
			mailService.sendMail(user.getEmail(), title, body);
			// DM
			DirectMessageDto message = new DirectMessageDto();
			message.setSender("관리자");
			message.setReceiver(user.getId());
			message.setTitle("1:1문의 답변이 등록되었습니다.");
			message.setBody("등록하신 답변은 MyPage -> 나의 문의 목록에서 확인 가능합니다.");
			messageService.sendMessage(message);
			return true;
		}else {
			return false;
		}
	}

}
