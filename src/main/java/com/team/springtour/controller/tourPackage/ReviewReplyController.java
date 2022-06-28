package com.team.springtour.controller.tourPackage;

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

import com.team.springtour.domain.tourPackage.ReviewReplyDto;
import com.team.springtour.service.tourPackage.ReviewReplyService;

@Controller
@RequestMapping("reviewReply")
public class ReviewReplyController {
	@Autowired
	private ReviewReplyService service;

	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insert(ReviewReplyDto dto, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			String memberId = principal.getName();
			dto.setMemberId(memberId);

			boolean success = service.insertReply(dto);

			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}

	}

	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody ReviewReplyDto dto, Principal principal) {

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.updateReply(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
			
		}
		
	}

	//	@PostMapping("delete")
	//	public String delete(ReplyDto dto, RedirectAttributes rttr) {
	//		boolean success = service.deleteReply(dto);
	//		
	//		if (success) {
	//			rttr.addFlashAttribute("message", "댓글이 삭제되었습니다.");
	//		}
	//		
	//		rttr.addAttribute("id", dto.getBoardId());
	//		return "redirect:/board/get";
	//	}

	@DeleteMapping(path = "delete/{replyId}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("replyId") int replyId, Principal principal) {
		

		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = service.deleteReply(replyId, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제 하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
			
		}
	}

	@GetMapping("list")

	public List<ReviewReplyDto> list(int reviewId, Principal principal) {
		System.out.println("reveiw reply list@!@!@");
		if(principal==null) {
		return service.getReplyByBoardId(reviewId);
		} else {
			return service.getReplyByWithOwnBoardId(reviewId,principal.getName());
		}
		
		}
	
}
