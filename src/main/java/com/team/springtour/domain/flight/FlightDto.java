package com.team.springtour.domain.flight;

import lombok.Data;

@Data
public class FlightDto {

	private String planeNumber;
	private String departureDate;
	private String returnDate;
	private String departurePort;
	private String retrunPort;
	
}
