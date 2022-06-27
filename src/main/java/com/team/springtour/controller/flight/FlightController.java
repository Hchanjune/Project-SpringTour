package com.team.springtour.controller.flight;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public void flight() {
		
	}

	@PostMapping("reserve2")
	public String flight(FlightDto dto, Model model) {
		System.out.println(dto);
		flightService.insertFlight(dto);
		return "/flight/reserve";
	}
	
	
	@GetMapping("reserve3")
	public String modifiy(Model model) {
		List<FlightDto> flightList = flightService.getFlightAll(); 
		model.addAttribute("flightList", flightList);
		return "/flight/reserve3";
	}
	
	@PostMapping("reserve3")
	public String modifiy(FlightDto dto, Model model) {
		
		return "/flight/reserve";
		
	}
	
	
}	


