package com.team.springtour.controller.user;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.user.UserDto;
import com.team.springtour.service.user.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	@Autowired
	UserService userService;



	@GetMapping("login")
	public void loginPage() {
	
	}
	
	@GetMapping("loginAuthority")
	public String loginAuthority(Principal principal) {
		boolean success = userService.checkUserLoginAuthority(principal.getName());
		if (success) {
			return "redirect:/main/home";
		}else {
			return "redirect:/main/home";
			//return "redirect:/logout";
		}	
	}
	
	@GetMapping("register")
	public void signIn() {
		
	}
	
	@PostMapping("register")
	public String siginIn(UserDto user, RedirectAttributes rttr, HttpServletRequest request) {
		boolean success = userService.registerUser(user, request);
		String resultMessage;
		if (success) {
			resultMessage = user.getEmail() + "로 인증메일이 발송 되었습니다";
		}else {
			resultMessage = "회원가입에 실패하였습니다. 다시 시도해 주세요";
		}
		rttr.addFlashAttribute("resultMessage", resultMessage);
		return "redirect:/main/home";
	}
	
	@PostMapping("resend")
	public String resendRegisterMail(String userId, HttpServletRequest request) {
		userService.resendRegisterMail(userId, request);
		return "redirect:/logout";
	}
	
	@GetMapping(path="check", params = "id")
	@ResponseBody
	public String idCheck(String id) {
		boolean exists = userService.checkUserId(id);
		if (exists) {
			return "unavailable";
		}
		else {
			return "available";
		}
	}
	
	@GetMapping(path="check", params = "email")
	@ResponseBody
	public String emailCheck(String email) {
		boolean exists = userService.checkUserEmail(email);
		if (exists) {
			return "unavailable";
		}
		else {
			return "available";
		}
	}
	
	@GetMapping("confirm")
	public String confirmUser(String userId, String authKey, RedirectAttributes rttr) {
		boolean success = userService.confirmUser(userId, authKey);
		String resultMessage;
		if (success) {
			resultMessage = "인증이 완료 되었습니다! 다시 로그인해 주세요.";
		}else {
			resultMessage = "인증과정에서 오류가 발생하였습니다.";
		}
		rttr.addFlashAttribute("resultMessage", resultMessage);
		return "redirect:/main/home";
	}
	
	@GetMapping("myPage")
	public String myPage(Principal principal, Model model) {
		UserDto user = userService.getUserById(principal.getName());
		model.addAttribute("user", user);
		return "/user/myPage";
	}
	
	private boolean authorityCheck(String id, Principal principal, HttpServletRequest request) {
		return request.isUserInRole("ROLE_ADMIN") || (principal.getName().equals(id));
	}
	
	@PostMapping("modifyInfo")
	public String modifyUserInfo(UserDto user, String insertedTime, Principal principal, Model model, RedirectAttributes rttr, HttpServletRequest request) {
		
		boolean success = false;
		if (authorityCheck(user.getId(), principal, request)) {
			LocalDateTime inserted = LocalDateTime.parse(insertedTime, DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss") );
			user.setInserted(inserted);
			success = userService.modifyUserInfo(user);
		}
		if (success) {
			model.addAttribute("user", user);
			model.addAttribute("insertedTime", user.getInserted().toString());
			return "/user/myPage";
		}else{
			String resultMessage;
			resultMessage = "회원 정보 수정 과정에서 오류가 발생하였습니다.";
			rttr.addFlashAttribute("resultMessage", resultMessage);
			return "redirect:/main/home";
		}
		
	}
	
	@GetMapping("userList")
	public void userListPage(Model model) {
		List<UserDto> userList = userService.getUserListAll();
		model.addAttribute("userList", userList);
	}
	
	@GetMapping("forgotId")
	public void forgotIdPage() {
		
	}
	
	@PostMapping("forgotId")
	public void forgotIdService(String email) {
		userService.forgotIdService(email);
	}
	
	@GetMapping("forgotPw")
	public void forgotPwPage() {
		
	}
	
	@PostMapping("forgotPw")
	public void forgotPwService(String id, String email, HttpServletRequest request) {
		userService.forgotPwService(id, email, request);
	}
	
	@GetMapping("checkFindPw")
	@ResponseBody
	public String idAndEmailCheck(String id, String email) {
		boolean matches = userService.idAndEmailCheck(id, email);
		if (matches) {
			return "true";
		}else {
			return "false";
		}
	}
	
	@GetMapping("pwChange")
	public String pwChangePage(String userId, String pwChangeKey, RedirectAttributes rttr) {
		boolean success = userService.confirmUserPwChangeKey(userId, pwChangeKey);
		String resultMessage;
		if (success) {
			resultMessage = "인증이 완료 되었습니다! 비밀번호를 변경하여 주세요.";
			rttr.addFlashAttribute("userId", userId);
		}else {
			resultMessage = "만료된 링크입니다.";
		}
		rttr.addFlashAttribute("resultMessage", resultMessage);
		
		return "redirect:/user/changePassword";
	}
	
	@GetMapping("changePassword")
	public void pwChangePage() {
		
	}
	
	@PostMapping("changePassword")
	public void pwChangePage(String userId, Model model) {
		model.addAttribute("userId", userId);
	}
	
	@PostMapping("modifyPassword")
	public String modifyPassword(String userId, String newPassword, RedirectAttributes rttr) {
		boolean success = userService.modifyUserPasswordByUserId(userId, newPassword);
		String resultMessage;
		if (success) {
			resultMessage = "비밀번호가 성공적으로 변경 되었습니다.";
		}else {
			resultMessage = "비밀번호 변경 중 오류가 발생하였습니다.";
		}
		rttr.addFlashAttribute("resultMessage", resultMessage);
		return "redirect:/main/home";
	}
}
