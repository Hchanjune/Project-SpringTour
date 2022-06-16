package com.team.springtour.controller.serviceCenter;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.service.serviceCenter.ServiceCenterService;

@Controller
@RequestMapping("serviceCenter")
public class ServiceCenterController {
	
	@Autowired
	private ServiceCenterService service;
	
	
	@RequestMapping("notice/notice")
	public void noticeBoard(Model model) {
		List<ServiceCenterDto> list = service.noticeBoard();
		
		model.addAttribute("boardNotice", list);
		
	}
	
	
	
	// 공지사항 글 등록
	@GetMapping("notice/insert")
	public void insert() {
	
	}
	
	@PostMapping("notice/insert")
	public String insertNotice(ServiceCenterDto dto, RedirectAttributes rttr, Principal principal ) {
		
		dto.setWriter(principal.getName());
		boolean success = service.insertBoard(dto);
		
		if (success) {
			rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
		}
		
		return "redirect:/serviceCenter/notice/notice";
	}
	
	@GetMapping("get")
	public void getBoard(int indexId, Model model) {
		ServiceCenterDto dto = service.getBoard(indexId);
		model.addAttribute("board", dto);
		
		
		
	}

}
 