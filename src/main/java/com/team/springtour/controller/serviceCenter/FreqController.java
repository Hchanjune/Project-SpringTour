package com.team.springtour.controller.serviceCenter;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.serviceCenter.FreqDto;
import com.team.springtour.domain.serviceCenter.PostPageDto;
import com.team.springtour.service.serviceCenter.FreqService;

@Controller
@RequestMapping("serviceCenter")
public class FreqController {

	
	@Autowired
	private FreqService service;
	
	
		
		@GetMapping("freq")
		public String freqPostPage(@RequestParam(name = "page", defaultValue = "1")int page, 
								Model model) {
			System.out.println("확인");
			int rowPerPage = 5;
			
			List<FreqDto> freqPost = service.listFreqPage(page, rowPerPage);
			
			int totalRecords = service.countFreqPostPage();
			int end = (totalRecords - 1) / rowPerPage + 1;
			
			
			PostPageDto freqPostPage = new PostPageDto();
			freqPostPage.setCurrent(page);
			freqPostPage.setEnd(end);
			
			System.out.println(freqPostPage);
			
			model.addAttribute("Page", freqPost);
			model.addAttribute("pageInfo", freqPostPage);
			
			return "/serviceCenter/freq";
		}
		
		
		
		 @GetMapping(value="freq", params = {"keyword", "type"})
			 public void freqPostSearch(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type,
					 					@RequestParam(name = "page", defaultValue = "1")int page,
					 					Model model) {
			
					int rowPerPage = 5;
		
					List<FreqDto> freqSearchPost = service.freqSearchPost(type, keyword, page, rowPerPage);
					System.out.println(page);
		
		
					int totalRecords = service.countSearchedFreqPage(type,keyword);
					int end = (totalRecords - 1) / rowPerPage + 1;
		
					PostPageDto freqPostPage = new PostPageDto();
					freqPostPage.setCurrent(page);
					freqPostPage.setEnd(end);
		
					System.out.println(freqPostPage);
		
					model.addAttribute("Page", freqSearchPost);
					model.addAttribute("pageInfo", freqPostPage);
				 
			 }
		 
		
			@PostMapping("freqPost")
			public String getFreqPost(Principal principal,  Model model) {
				FreqDto freq = service.getFreqPost();
				model.addAttribute("freqPost", freq);
				
				return "/serviceCenter/freq";
			}
			
			
			
			// 자주묻는질문 글쓰기 등록(ONLY ADMIN)
			@GetMapping("freqInsert")
			public void freqInsert(Model model) {
				
			}
			
			@PostMapping("freqInsert")
			public String freqInsert(FreqDto freq,
									Principal principal,
									RedirectAttributes rttr) { 
				boolean success = service.insertFreq(freq);
				if (success) {
					rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
				} else {
					rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
				}
				
				return "redirect:/serviceCenter/freq";
			
			}
			

		
			
			@PostMapping("freqmd")
			public String freqModify (FreqDto freqPost,
								         Principal principal,
								         RedirectAttributes rttr) {
				FreqDto oldFreqPost = service.getFreqPostByIndexId(freqPost.getFreqIndexId());
				
				
				if (oldFreqPost.getWriter().equals(principal.getName())) {
					
					boolean success = service.updateFreqPost(freqPost);
					
					if (success) {
						rttr.addFlashAttribute("message", "글이 수정되었습니다.");
					}else {
						rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
					}
				}else {
					rttr.addFlashAttribute("message", "권한이 없습니다.");
				}
				
				rttr.addAttribute("freqIndexId", freqPost.getFreqIndexId());
				

				return "redirect:/serviceCenter/freqmd"; 
			}
			
			@PostMapping("freqRemove")
			public String freqRemove(FreqDto freqPost, Principal principal, RedirectAttributes rttr ) {
				
				FreqDto oldFreqPost = service.getFreqPostByIndexId(freqPost.getFreqIndexId());

				if (oldFreqPost.getWriter().equals(principal.getName())) {

					boolean success = service.deleteFreqPost(freqPost.getFreqIndexId());

					if (success) {
						rttr.addFlashAttribute("message", "글이 삭제되었습니다.");
					} else {
						rttr.addFlashAttribute("message", "글이 삭제되지 않았습니다.");
					}
				} else {
					rttr.addFlashAttribute("message", "권한이 없습니다.");
					rttr.addAttribute("freqIndexId", freqPost.getFreqIndexId());
					return "redirect:serviceCenter/freqmd";
				}

				return "redirect:/serviceCenter/freq";
			}
			

}
