package com.team.springtour.controller.flight;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.service.flight.FlightService;

@Controller
@RequestMapping("flight") // 컨트롤러 URL 매핑
public class FlightController {
	
	@Autowired
	FlightService flightService;

	
	@GetMapping("reserve")
	public String flight(Model model) {
		List<FlightDto> flightList = flightService.getFlightAll(); 
		model.addAttribute("flightList", flightList);
		return "/flight/reserve";
	}
	
	@PostMapping("reserve")
	public String flight(String depart, String arrive, Model model) {
		System.out.println(depart);
		System.out.println(arrive);
		List<FlightDto> flightList = flightService.getFlightFromTo(depart, arrive); 
		model.addAttribute("flightList", flightList);
		return "/flight/reserve";
		
	}
	
	
	@GetMapping("reserve2")
	public void reserve2() {
		
	}

	@PostMapping("reserve2")
	public String flight(FlightDto dto, Model model) {
		System.out.println(dto);
		flightService.insertFlight(dto);
		

		return "redirect:/flight/reserve";
	}
	
}

