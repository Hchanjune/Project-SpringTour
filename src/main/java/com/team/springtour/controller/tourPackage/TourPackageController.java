package com.team.springtour.controller.tourPackage;

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

import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.service.tourPackage.TourPackageService;

@Controller
@RequestMapping("tourPackage")
public class TourPackageController {

	@Autowired
	private TourPackageService service;

	@GetMapping("tourChoice")
	public void choicePage(Model model) {

		List<TourPackageDto> list = service.TourList();
		//System.out.println(list);
		model.addAttribute("tourList", list);
	}

	@GetMapping("insert")
	public void insert() {

	}

	@PostMapping("insert")
	public String tourInsert(TourPackageDto tourPackage, RedirectAttributes rttr, Principal principal,
			MultipartFile[] file) {

		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			tourPackage.setFileName(fileList);
		}

		boolean success = service.insertTourPackage(tourPackage, file);

		if (success) {
			rttr.addFlashAttribute("message", "새 패키지가 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 패키지가 등록되지 않았습니다.");
		}

		return "redirect:/tourPackage/tourChoice";

	}

	@GetMapping("tourInfo")
	public String tourinfo(@RequestParam("packageName") String packageName, Model model) {

		TourPackageDto tourPackage = service.getTourPackageByPackageName(packageName);
		model.addAttribute("tourPackage",tourPackage);
		return "/tourPackage/tourInfo";
	}

	@PostMapping("modify")
	public String tourModify(@RequestParam(name = "removeFileList", required = false) ArrayList<String> removeFileList,
			Principal principal, MultipartFile[] addFileList, RedirectAttributes rttr) {

		boolean success = service.updateTourPackage(removeFileList, addFileList);

		if (success) {
			rttr.addFlashAttribute("message", "글이 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
		}

		return "redirect:/tourPackage/tourInfo";
	}

	@PostMapping("remove")
	public String remove(RedirectAttributes rttr) {

		boolean success = service.deleteTourPackage();

		if (success) {
			rttr.addFlashAttribute("message", "패키지가 삭제 되었습니다.");

		} else {
			rttr.addFlashAttribute("message", "패키지가 삭제 되지않았습니다.");
		}

		return "redirect:/tourPackage/tourChoice";
	}

	
	
	// getmapping 값이 view의 jsp와 같으면 void를 사용한다
	@GetMapping("honeymoonTour")
	public void honeymoon() {
			
	}

	@GetMapping("golfTour")
	public void golf() {

	}

	@GetMapping("silverTour")
	public void silver() {

	}

}
