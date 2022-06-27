package com.team.springtour.service.flight;

import java.util.List; 

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.flight.FlightDto;
import com.team.springtour.domain.tourPackage.TourPackageDto;
import com.team.springtour.mapper.flight.FlightMapper;


@Service
public class FlightService {

	@Autowired
	private FlightMapper mapper;

	public List<FlightDto> getFlightAll() {
		return mapper.selectFlightListAll();
	}

	public List<FlightDto> getFlightFromTo(String depart, String arrive) {
		return mapper.selectFlightListFromTo(depart, arrive);
	}

	public boolean insertFlight(FlightDto Flight) {	
		int cnt=mapper.insertFlight(Flight);
		return cnt==1;
	}
	
}
