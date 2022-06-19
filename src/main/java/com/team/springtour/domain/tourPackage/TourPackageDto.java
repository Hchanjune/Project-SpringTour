package com.team.springtour.domain.tourPackage;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TourPackageDto {
	
	private String packageName;
	private String price;
	private int bookable;
	private String country;
	private String city;
	private String flightDepartTicket;
	private String flightReturnTicket;
	private List<String> fileName;
	private boolean hasFile;
	
}
