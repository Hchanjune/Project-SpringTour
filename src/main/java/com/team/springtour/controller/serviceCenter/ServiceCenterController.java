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
import com.team.springtour.domain.tourPackage.TourPackageDto;
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
	
	 @GetMapping(value = "notice", params = {"keyword", "type"})
	 public void postSearch(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type,
			 					@RequestParam(name = "page", defaultValue = "1")int page,
			 					Model model) {
	
			int rowPerPage = 5;

			List<ServiceCenterDto> searchPost = service.searchPost(type, keyword, page, rowPerPage);
			System.out.println(page);
			
			

			int totalRecords = service.countSearchedPostPage(type,keyword);
			int end = (totalRecords - 1) / rowPerPage + 1;

			PostPageDto postPage = new PostPageDto();
			postPage.setCurrent(page);
			postPage.setEnd(end);

			System.out.println(postPage);

			model.addAttribute("page", searchPost);
			model.addAttribute("pageInfo", postPage);

		 
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
		boolean success = service.insertBoard(dto, file);
		
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
		//System.out.println(serviceCenter);
		model.addAttribute("post", serviceCenter);
		
	}
	
	
	// ADMIN만 수정가능
	@PostMapping("modify")
	public String modifyService (ServiceCenterDto post,
								 @RequestParam(name= "removeFileList", required = false) ArrayList<String> removeFileList,
								 MultipartFile[] addFileList,
						         Principal principal,
						         RedirectAttributes rttr) {
		ServiceCenterDto oldPost = service.getPostByIndexId(post.getIndexId());
		//System.out.println(oldPost);
		System.out.println(addFileList);
		System.out.println(removeFileList);
		if (oldPost.getWriter().equals(principal.getName())) {
			
			boolean success = service.updatePost(post, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			}else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
		}else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("indexId", post.getIndexId());
		

		return "redirect:/serviceCenter/notice"; 
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
	
	
	
	
	
	
	
	// freq - 자주묻는질문 ----------------------------------------------------------------------------------
	
	
	@GetMapping("freq")
	public String freqPostPage(@RequestParam(name = "page", defaultValue = "1")int page, 
							Model model) {
		
		int rowPerPage = 5;
		
		List<ServiceCenterDto> freqPost = service.listFreqPage(page, rowPerPage);
		
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
	
	
	
	 @PostMapping("freq")
		 public void freqPostSearch(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type,
				 					@RequestParam(name = "page", defaultValue = "1")int page,
				 					Model model) {
		
				int rowPerPage = 5;
	
				List<ServiceCenterDto> freqSearchPost = service.freqSearchPost(type, keyword, page, rowPerPage);
				System.out.println(page);
	
	
				int totalRecords = service.countSearchedPostPage(type,keyword);
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
			ServiceCenterDto freq = service.getFreqPost();
			//System.out.println(serviceCenter);
			model.addAttribute("freqPost", freq);
			
			return "/serviceCenter/freq";
		}
		
		
	 
		// 자주묻는질문 글쓰기 등록(ONLY ADMIN)
		@GetMapping("freqInsert")
		public void freqInsert(Model model) {

		}
		
		@PostMapping("freqInsert")
		public String freqInsert(ServiceCenterDto freq, String title,
								Principal principal, 
								Model model) { 
			freq.setWriter(principal.getName());
		
			boolean list = service.insertFreq(freq);
			
			model.addAttribute("freqList", list);
			return "redirect:/serviceCenter/freq";
		
		}
	
}
 















