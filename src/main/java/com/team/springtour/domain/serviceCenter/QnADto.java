package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;
@Data
public class QnADto {
	
	private int indexId;
	private String packageName;
	private String title;
	private String body;
	private String writer;
	private LocalDateTime inserted;
	private String answer;
	private List<String> fileName;
	
	
}
