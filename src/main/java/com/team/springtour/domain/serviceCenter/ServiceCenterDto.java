package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;

import lombok.Data;
@Data
public class ServiceCenterDto {

	private int indexId;
	private String writer;
	private String title;
	private String body;
	private LocalDateTime inserted;
	
}
