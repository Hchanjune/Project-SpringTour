package com.team.springtour.controller.user;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.user.DirectMessageDto;
import com.team.springtour.service.user.DirectMessageService;

@Controller
@RequestMapping("user")
public class DirectMessageController {
	
	@Autowired
	DirectMessageService messageService;
	
	@GetMapping("dmSendList")
	public void dmListSenderPage(Principal principal, Model model) {
		String userId = principal.getName();
		List<DirectMessageDto> messageList = messageService.getDmListBySender(userId);
		model.addAttribute("messageList", messageList);
	}
	
	@GetMapping("dmReceiveList")
	public void dmListReceiverPage(Principal principal, Model model) {
		String userId = principal.getName();
		List<DirectMessageDto> messageList = messageService.getDmListByReceiver(userId);
		model.addAttribute("messageList", messageList);
	}
	
	@GetMapping("writeMessage")
	public void writeMessagePopUp(Principal principal) {
		
	}
	@PostMapping("sendMessage")
	public String sendMessage(DirectMessageDto message, RedirectAttributes rttr) {
		boolean success = messageService.sendMessage(message);
		String resultMessage;
		if (success) {
			resultMessage = "성공적으로 메시지를 전송하였습니다.";
		}else {
			resultMessage = "메시지 전송에 실패하였습니다.";
		}
		rttr.addFlashAttribute("resultMessage", resultMessage);
		return "redirect:/user/writeMessage";
	}
	
	@GetMapping("messageCount")
	@ResponseBody
	public int getMessageCount(String userId) {
		int messageCount = messageService.countMessageByUserId(userId);
		return messageCount;
	}
	
	@PostMapping("readMessage")
	public ModelAndView readMessagePage(int messageId) {
		DirectMessageDto message = messageService.getMessageByIndexId(messageId);
		ModelAndView mav = new ModelAndView();
		/*mav.setViewName("user/readMessage");*/
		mav.addObject("message", message);
		return mav;
	}
	
	

}
