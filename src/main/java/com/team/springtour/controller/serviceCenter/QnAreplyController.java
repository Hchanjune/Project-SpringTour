package com.team.springtour.controller.serviceCenter;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.serviceCenter.PostPageDto;
import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.domain.serviceCenter.QnAreplyDto;
import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.service.serviceCenter.QnAreplyService;

@Controller
@RequestMapping("qnaReply")
public class QnAreplyController {

	@Autowired
	private QnAreplyService service;

	@PostMapping(path = "qnaInsert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(QnAreplyDto dto, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {

			String qnaContent = principal.getName();
			dto.setQnaContent(qnaContent);

			boolean success = service.insertQnaReply(dto);

			if (success) {
				return ResponseEntity.ok("새 글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
	}

	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody QnAreplyDto reply, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.updateQnaReply(reply, principal);

			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			return ResponseEntity.status(500).body("");
		}
	}

	@DeleteMapping(path = "delete/{replyIndexId}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("replyIndexId") int replyIndexId, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {

			boolean success = service.deleteQnaReply(replyIndexId, principal);

			if (success) {
				return ResponseEntity.ok("댓글을 삭제 하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
		}
	}

	@ResponseBody
	@GetMapping("qnalist")

	public List<QnAreplyDto> list(int replyIndexId, Principal principal) {

		if (principal == null) {
			return service.getReplyByqQnaIndexId(replyIndexId);

		} else {
			return service.getReplyWithOwnByQnaIndexId(replyIndexId, principal.getName());
		}
	}

	@GetMapping("qnaReplyList")
	public String qnaReplyPost(@RequestParam(name = "page", defaultValue = "1") int qnaPage,
			Model model) {

		int rowPerPage = 5;

		List<QnAreplyDto> list = service.listQnaPage(qnaPage, rowPerPage);

		int totalRecords = service.countQnaPage();
		int end = (totalRecords - 1) / rowPerPage + 1;

		PostPageDto qnaPostPage = new PostPageDto();
		qnaPostPage.setCurrent(qnaPage);
		qnaPostPage.setEnd(end);

		model.addAttribute("qnaPost", list);
		model.addAttribute("pageInfo", qnaPostPage);

		return "/serviceCenter/qnaList";
	}

	/*	@PostMapping("qnaInsert")
		public String insertQna(QnAreplyDto dto,
				Principal principal,
				RedirectAttributes rttr) {
			dto.setWriter(principal.getName());
			boolean success = service.insertQnaReply(dto);
	
			if (success) {
				rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
			}
	
			return "redirect:/serviceCenter/qna/qnaPage";
	
		}*/

}
