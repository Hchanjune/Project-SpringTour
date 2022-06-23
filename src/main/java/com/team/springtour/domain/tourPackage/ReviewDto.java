package com.team.springtour.domain.tourPackage;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReviewDto {
	
	private int indexId;
	private String title;
	private String writer;
	private LocalDateTime inserted;
	private String packageName;
	private String body;
	
	public String getPrettyInserted() {
		// 24시간 이내면 시간만
		// 이전이면 년-월-일
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(inserted)) {
			return inserted.toLocalTime().toString();
		} else {
			return inserted.toLocalDate().toString();
		}
	}
		
}
