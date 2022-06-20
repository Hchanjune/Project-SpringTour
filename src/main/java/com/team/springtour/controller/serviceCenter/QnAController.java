package com.team.springtour.controller.serviceCenter;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.service.serviceCenter.QnAService;

@Controller
@RequestMapping("qna")
public class QnAController {

	@Autowired
	private QnAService service;

	
	@RequestMapping("qnaList")
	public void qnaPost(QnADto qna, Model model) {
		List<QnADto> list = service.listQnA(qna);
		model.addAttribute("qnaPost", list);
	
	}
	
	
	
	@GetMapping("qna/insert")
	public void insert() {
	}
	 
	@PostMapping("qna/insert")
	public String insert2(QnADto qna, RedirectAttributes rttr) {
		
		boolean success = service.insertQnA(qna);
		
		if (success) {
			rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
		}
		
		return "redirect:/serviceCenter/qna/qnaList";
	}
	
	
	
	@GetMapping("qna/get")
	public void gets(int indexId, Model model) {
		QnADto qna = service.getQnAByIndexId(indexId);
		model.addAttribute("qnaPost", qna);
	}
}
