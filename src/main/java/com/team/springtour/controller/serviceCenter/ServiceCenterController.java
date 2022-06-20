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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.serviceCenter.PostPageDto;
import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.service.serviceCenter.ServiceCenterService;

@Controller
@RequestMapping("serviceCenter")
public class ServiceCenterController {
	
	@Autowired
	private ServiceCenterService service;
	
	
	/*	@RequestMapping("search")
		public void search(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type, Model model) {
			List<ServiceCenterDto> search = service.postService(type, keyword);
			model.addAttribute("postList", search);
		}*/

	// pagination
	@GetMapping("notice")
	public String postPage(@RequestParam(name = "page", defaultValue = "1")int page, 
			               
							Model model) {
		
		int rowPerPage = 5;
		
		List<ServiceCenterDto> post = service.listServiceCenterPage(page, rowPerPage);
		
		int totalRecords = service.countPostPage();
		int end = (totalRecords - 1) / rowPerPage + 1;
		
		
		PostPageDto postPage = new PostPageDto();
		postPage.setCurrent(page);
		postPage.setEnd(end);
		
		System.out.println(postPage);
		
		model.addAttribute("page", post);
		model.addAttribute("pageInfo", postPage);
		
		return "/serviceCenter/notice";
	}
	
	 @RequestMapping("search")
	 public String postSearch(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type,
			                 Model model) {
		 List<ServiceCenterDto> searchPost = service.searchPost(type, keyword);
		 model.addAttribute("post", searchPost);
		 
		 return "/serviceCenter/notice";
	 }


	
	// 공지사항 글쓰기 등록(ONLY ADMIN)
	@GetMapping("notice/insert")
	public void insert() {
	
	}
	
	@PostMapping("notice/insert")
	public String insertNotice(ServiceCenterDto dto, 
								MultipartFile[] file,
								Principal principal, 
								RedirectAttributes rttr) { 
		
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			dto.setFileName(fileList);
		}
		
		dto.setWriter(principal.getName());
		boolean success = service.insertBoard(dto);
		
		if (success) {
			rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
		}
		
		return "redirect:/serviceCenter/notice";
	}
	
	
	
	@GetMapping("notice/get")
	public void getPost(int indexId, Principal principal,  Model model) {
		ServiceCenterDto serviceCenter = service.getPostByIndexId(indexId);
		System.out.println(serviceCenter);
		model.addAttribute("post", serviceCenter);
		
	}
	
	
	// ADMIN만 수정가능
	@PostMapping("modify")
	public String modifyService (ServiceCenterDto post,
						         Principal principal,
						         RedirectAttributes rttr) {
		ServiceCenterDto oldPost = service.getPostByIndexId(post.getIndexId());
		System.out.println(oldPost);
		
		if (oldPost.getWriter().equals(principal.getName())) {
			
			boolean success = service.updatePost(post);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			}else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
		}else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("indexId", post.getIndexId());
		
		return "redirect:serviceCenter/notice/insert"; 
	}

	@PostMapping("remove")
	public String remove(ServiceCenterDto post, Principal principal, RedirectAttributes rttr ) {
		
		ServiceCenterDto oldPost = service.getPostByIndexId(post.getIndexId());

		if (oldPost.getWriter().equals(principal.getName())) {

			boolean success = service.deletePost(post.getIndexId());

			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 삭제되지 않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			rttr.addAttribute("indexId", post.getIndexId());
			return "redirect:serviceCenter/notice/get";
		}

		return "redirect:/serviceCenter/notice";
	}
	
	

}
 















