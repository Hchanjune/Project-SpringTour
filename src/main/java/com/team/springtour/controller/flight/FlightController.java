package com.team.springtour.controller.flight;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.service.flight.FlightService;

@Controller
@RequestMapping("flight") // 컨트롤러 URL 매핑
public class FlightController {
	
	@Autowired
	FlightService flightService;

	
	@GetMapping("info")
	public String flight(Model model) {
		List<FlightDto> flightList = flightService.getFlightAll(); 
		model.addAttribute("flightList", flightList);
		
		return "/flight/info";
	}
	
	@PostMapping("info")
	public String flight(String depart, String arrive, Model model) {
		System.out.println(depart);
		System.out.println(arrive);
		List<FlightDto> flightList = flightService.getFlightFromTo(depart, arrive); 
		model.addAttribute("flightList", flightList);
		
		return "/flight/info";
	}
	
	
	@GetMapping("info2")
	public void flight() {
		
	}

	@PostMapping("info2")
	public String flight(FlightDto dto, Model model) {
		System.out.println(dto);
		flightService.insertFlight(dto);
		
		return "/flight/info";
	}
	
	
	@GetMapping("info3")
	public String delete(Model model) {
		List<FlightDto> flightList = flightService.getFlightAll(); 
		model.addAttribute("flightList", flightList);
		
		return "/flight/info3";
	}
	
	@PostMapping("info3")
	public String delete(String[] valueArr, Model model) throws Exception {		
		flightService.delete(valueArr);
		
		return "/flight/info";
	}
    
   
	
}	


