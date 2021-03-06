package com.team.springtour.controller.serviceCenter;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team.springtour.domain.serviceCenter.QnAreplyDto;
import com.team.springtour.service.serviceCenter.QnAreplyService;

@Controller
@RequestMapping("qnaReply")
public class QnAreplyController {

	
	@Autowired
	private QnAreplyService service;

	
	@PostMapping(path = "qna/insert", produces = "text/plain;charset=UTF-8")
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
	public ResponseEntity<String> modify(@RequestBody QnAreplyDto dto, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.updateQnaReply(dto, principal);

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

	
	@GetMapping("qnaPage")

	public List<QnAreplyDto> qnaList(int replyIndexId, Principal principal) {
		

		if (principal == null) {

			return service.getReplyByqQnaIndexId(replyIndexId);

		} else {
			return service.getReplyWithOwnByQnaIndexId(replyIndexId, principal.getName());
		}
	}
	


}
