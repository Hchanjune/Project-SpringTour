package com.team.springtour.domain.user;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class DirectMessageDto {
	private int indexId;
	private String title;
	private String body;
	private LocalDateTime inserted;
	private String sender;
	private String receiver;
	private int readInfo;
	
	public boolean isRead() {
		if (this.getReadInfo()==0) {
			return false;
		}else {
			return true;
		}
	}
	
}
