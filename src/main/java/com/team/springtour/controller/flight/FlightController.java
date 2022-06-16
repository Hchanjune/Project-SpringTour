package com.team.springtour.controller.flight;


public class FlightController {


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FlightController {

	@RequestMapping(value = "flight/reserve")
	public String flight(Model model) 	{

		
		return "flight";
	}

}
