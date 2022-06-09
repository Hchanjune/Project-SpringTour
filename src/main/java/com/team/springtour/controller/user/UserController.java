package com.team.springtour.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@GetMapping("register")
	public void signIn() {
		
	}
	
	@PostMapping("register")
	public String siginIn(UserDto user, RedirectAttributes rttr) {
		
		boolean success = userService.registerUser(user);
		String resultMessage;
		
		if (success) {
			resultMessage = "Success";
		}else {
			resultMessage = "fail";
		}
		
		rttr.addFlashAttribute("resultMessage", resultMessage);

		return "redirect:/main/home";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
