package com.team.springtour.controller.user;

import java.security.Principal;

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
	
	@PostMapping("myPage")
	public void myPage(String userId, Principal principal, Model model) {
		UserDto user = userService.getUserById(userId);
		model.addAttribute("user", user);
	}

}
