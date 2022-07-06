package com.team.springtour.domain.user;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class ReservationDto {
	private String reservationId;
	private String packageName;
	private String clientName;
	private LocalDateTime inserted;
	private boolean retractable;
}
