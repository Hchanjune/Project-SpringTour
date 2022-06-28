package com.team.springtour.domain.user;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class PrivateEnquiryDto {
	private int indexId;
	private String clientName;
	private String title;
	private String category;
	private String body;
	private LocalDateTime inserted;
	private boolean replyInfo;
	private String reply;
}
