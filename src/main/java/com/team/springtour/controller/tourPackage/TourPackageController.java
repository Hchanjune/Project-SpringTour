package com.team.springtour.controller.tourPackage;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.service.tourPackage.TourPackageService;

@Controller
@RequestMapping("tourPackage")
public class TourPackageController {

	@Autowired
	private TourPackageService service;

	@GetMapping("tourChoice")
	public void choicePage(Model model, @RequestParam(name="keyword" , defaultValue="")String keyword, 
			 @RequestParam(name = "type", defaultValue = "") String type) {

		List<TourPackageDto> tourList = service.TourList(type,keyword);
		//System.out.println(list);
		model.addAttribute("tourList", tourList);
	}

	@GetMapping("insert")
	public void insert(Model model) {
		List<FlightDto> flightList = service.FlightList();
		model.addAttribute("flightList", flightList);
	}

	@PostMapping("insert")
	public String tourInsert(TourPackageDto dto, RedirectAttributes rttr, Principal principal,
			MultipartFile[] file) {

		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			dto.setFileName(fileList);
		}

	//	dto.setPackageName(principal.getName());
		boolean success = service.insertTourPackage(dto,file);
		if (success) {
			rttr.addFlashAttribute("message", "새 패키지가 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 패키지가 등록되지 않았습니다.");
		}

		return "redirect:/tourPackage/tourChoice";

	}

	@RequestMapping(value="tourInfo",method= {RequestMethod.POST,RequestMethod.GET})
	public void tourinfo(@RequestParam("packageName") String packageName, Model model) {

		TourPackageDto tourPackage = service.getTourPackageByPackageName(packageName);
		model.addAttribute("tourPackage", tourPackage);
//		return "/tourPackage/tourInfo";
	}
	
	private boolean authorityCheck(Principal principal) {
		return service.getAuthByUserId(principal.getName());
	}

	
	@PostMapping("modify")
	public String modify(TourPackageDto dto,
			@RequestParam(name="removeFileList",required=false)ArrayList<String>removeFileList,
			Principal principal, 
			MultipartFile[] addFileList,
			RedirectAttributes rttr) {
		
	//		System.out.println(addFileList[0].getOriginalFilename());
		if (authorityCheck(principal)) {
			
			boolean success = service.updateTourPackage(dto,addFileList,removeFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("packageName", dto.getPackageName());
		return "redirect:/tourPackage/tourInfo";
	}
	
	@PostMapping("remove")
	public String remove(TourPackageDto dto, Principal principal, RedirectAttributes rttr) {
		

		if (authorityCheck(principal)) {
			boolean success = service.deleteTourPackage(dto.getPackageName());
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			
			rttr.addAttribute("packageName", dto.getPackageName());
			
			return "redirect:/tourPackage/tourInfo";
		}
		
		return "redirect:/tourPackage/tourChoice";
	}


}
