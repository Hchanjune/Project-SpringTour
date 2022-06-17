package com.team.springtour.controller.tourPackage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
//		System.out.println(list);
		model.addAttribute("tourList",list);
	
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
