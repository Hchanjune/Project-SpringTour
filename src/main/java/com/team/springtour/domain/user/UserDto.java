package com.team.springtour.domain.user;

import java.time.LocalDate;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserDto {

	private String id;
	private String password;
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate;
	private String address;
	private String email;
	private String grade;
	private LocalDateTime inserted;
	
}
