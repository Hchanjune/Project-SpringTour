package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;
@Data
public class ServiceCenterDto {

	private int indexId;
	private String writer;
	private String title;
	private String body;
	private LocalDateTime inserted;
	private List<String> fileName;
	private int noticeIndexId;
	private boolean hasFile;
	
}
