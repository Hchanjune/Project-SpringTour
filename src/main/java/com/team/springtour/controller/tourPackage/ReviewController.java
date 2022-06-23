package com.team.springtour.controller.tourPackage;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.team.springtour.domain.tourPackage.ReviewDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.domain.user.UserDto;
import com.team.springtour.service.tourPackage.ReviewService;

@Controller
@RequestMapping("tourPackage")
public class ReviewController {

	
	@Autowired
	private ReviewService service;
	
	@GetMapping("/Review/reviewList")
	public void insertReview(Model model) {
		
		List<ReviewDto> reviewList = service.ReviewList();
		model.addAttribute("reviewList",reviewList);
			
	}
	
	@GetMapping("/Review/reviewInsert")
	public void insert(Model model) {
		List<TourPackageDto> tourList = service.TourList();
		model.addAttribute("tourList",tourList);
		
		List<UserDto> userList = service.UserList();
		model.addAttribute("userList",userList);
		
	}

	@PostMapping("/Review/reviewInsert")
	public String tourInsert(ReviewDto dto, RedirectAttributes rttr, Principal principal) {


//		System.out.println(dto);
		
		
		dto.setWriter(principal.getName());
		boolean success = service.insertReview(dto);
		if (success) {
			rttr.addFlashAttribute("message", "새 리뷰가 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 리뷰가 등록되지 않았습니다.");
		}

		return "redirect:/tourPackage/Review/reviewList";

	}
	
	@GetMapping("/Review/reviewGet")
	public void get(Model model,int indexId) {
	
		ReviewDto dto= service.getReviewByIndexId(indexId);
		model.addAttribute("review",dto);
		
	}
	
	private boolean authorityCheck( Principal principal) {
		return service.getAuthByUserId(principal.getName());
	}
	
	
	
	@PostMapping("/Review/modify")
	public String modify(ReviewDto dto,
			Principal principal, 	
			RedirectAttributes rttr) {
		
		ReviewDto oldReview = service.getReviewById(dto.getIndexId());
		
		
		if (oldReview.getWriter().equals(principal.getName()) || authorityCheck(principal)) {
			boolean success = service.updateReview(dto);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("indexId", dto.getIndexId());
		return "redirect:/tourPackage/Review/reviewGet";
	}
	
	@PostMapping("/Review/remove")
	public String remove(ReviewDto dto, Principal principal, RedirectAttributes rttr) {
		
		// 게시물 정보 얻고
		ReviewDto oldReview = service.getReviewById(dto.getIndexId());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
		if (oldReview.getWriter().equals(principal.getName())||authorityCheck(principal)) {
			boolean success = service.deleteReview(dto.getIndexId());
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			
			rttr.addAttribute("indexId", dto.getIndexId());
			return "redirect:/tourPackage/Review/reviewGet";
		}
		
		return "redirect:/tourPackage/Review/reviewList";
	}
	
	
	
}
