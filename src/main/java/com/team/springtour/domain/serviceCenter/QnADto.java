package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;

import lombok.Data;
@Data
public class QnADto {
	
	private int indexId;
	private String country;
	private String title;
	private String body;
	private String userId;
	private LocalDateTime inserted;
	private String answer;
	
}
