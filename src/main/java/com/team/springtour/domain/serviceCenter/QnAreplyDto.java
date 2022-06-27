package com.team.springtour.domain.serviceCenter;

import java.time.LocalDateTime;

import lombok.Data;

@Data

public class QnAreplyDto {

	private int replyIndexId;
	private String qnaContent;
	private LocalDateTime inserted;
	
	
}
