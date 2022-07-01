package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class FreqDto {

	private int freqIndexId;
	private String writer;
	private String title;
	private String body;
	private LocalDateTime inserted;
	
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
