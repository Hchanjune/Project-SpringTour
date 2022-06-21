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
import com.team.springtour.domain.serviceCenter.QnADto;
import com.team.springtour.domain.serviceCenter.ServiceCenterDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.service.serviceCenter.QnAService;
import com.team.springtour.service.tourPackage.TourPackageService;

@Controller
@RequestMapping("serviceCenter")
public class QnAController {

	@Autowired
	private QnAService service;
	
	@Autowired
	private TourPackageService tourPackageService;

	
	@GetMapping("qnaList")
	public String qnaPost(@RequestParam(name = "page", defaultValue = "1")int qnaPage, 
						Model model) {
		int rowPerPage = 5;
		
		List<QnADto> list = service.listQnaPage(qnaPage, rowPerPage);
		int totalRecords = service.countQnaPage();
		int end = (totalRecords - 1) / rowPerPage + 1;
		
		
		PostPageDto qnaPostPage = new PostPageDto();
		qnaPostPage.setCurrent(qnaPage);
		qnaPostPage.setEnd(end);
		
		model.addAttribute("qnaPost", list);
		model.addAttribute("pageInfo", qnaPostPage);
		
		return "/serviceCenter/qnaList";
	}
	
	 @PostMapping("qnaList")
	 public void qnaPostSearch(@RequestParam(name ="keyword")String keyword, @RequestParam("type")String type,
			 					@RequestParam(name = "page", defaultValue = "1")int qnaPage,
			 					Model model) {
	
			int rowPerPage = 3;

			List<QnADto> searchQnaPost = service.searchQnaPost(type, keyword, qnaPage, rowPerPage);
			System.out.println(qnaPage);
			
			

			int totalRecords = service.countSearchedQnaPostPage(type,keyword);
			int end = (totalRecords - 1) / rowPerPage + 1;

			PostPageDto qnaPostPage = new PostPageDto();
			qnaPostPage.setCurrent(qnaPage);
			qnaPostPage.setEnd(end);

			System.out.println(qnaPostPage);

			model.addAttribute("qnaPost", searchQnaPost);
			model.addAttribute("pageInfo", qnaPostPage);

		 
	 }
	
	
	@GetMapping("qna/insert")
	public void insert(Model model) {
		
		List<TourPackageDto> tourList = tourPackageService.TourList();
		model.addAttribute("tourList", tourList);
		
	}
	 
	@PostMapping("qna/insert")
	public String insert2(QnADto qna, Principal principal,
							MultipartFile[] file,
							RedirectAttributes rttr) {
		
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			qna.setFileName(fileList);
		}
		

		System.out.println(principal.getName());
		System.out.println(qna);
		qna.setWriter(principal.getName());
		boolean success = service.insertQnA(qna,file);
		
		if (success) {
			rttr.addFlashAttribute("message", "새글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새글이 등록되지 않았습니다.");
		}
		
		
		return "redirect:/serviceCenter/qnaList";
	}
	
	
	
	@GetMapping("qna/qnaPage")
	public void qnaPage(int indexId, Principal principal, Model model) {
		QnADto qna = service.getQnaPostByIndexId(indexId);
		model.addAttribute("qnaPost", qna);
		
	}
	
	@PostMapping("qna/modify")
	public String qnaModify (QnADto qnaPost,
								 @RequestParam(name= "removeFileList", required = false) ArrayList<String> removeFileList,
								 MultipartFile[] addFileList,
						         Principal principal,
						         RedirectAttributes rttr) {
		QnADto oldQnaPost = service.getQnaPostByIndexId(qnaPost.getIndexId());
		//System.out.println(oldQnaPost);
		System.out.println(addFileList);
		System.out.println(removeFileList);
		if (oldQnaPost.getWriter().equals(principal.getName())) {
			
			boolean success = service.updateQnaPost(qnaPost, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			}else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
		}else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("indexId", qnaPost.getIndexId());
		

		return "redirect:/serviceCenter/qnaList"; 
	}
	
	@PostMapping("qna/remove")
	public String qnaRemove(QnADto qnaPost, Principal principal, RedirectAttributes rttr ) {
		
		QnADto oldQnaPost = service.getQnaPostByIndexId(qnaPost.getIndexId());

		if (oldQnaPost.getWriter().equals(principal.getName())) {

			boolean success = service.deletePost(qnaPost.getIndexId());

			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 삭제되지 않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			rttr.addAttribute("indexId", qnaPost.getIndexId());
			return "redirect:serviceCenter/qna/qnaPage";
		}

		return "redirect:/serviceCenter/qnaList";
	}
	

}










