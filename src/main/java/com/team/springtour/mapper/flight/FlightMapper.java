package com.team.springtour.mapper.flight;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.flight.FlightDto;

public interface FlightMapper {

	

	List<FlightDto> Flight(FlightDto post);

	List<FlightDto> selectFlightListAll();

	List<FlightDto> selectFlightListFromTo(@Param("depart")String depart, @Param("arrive")String arrive);
	
	int insertFlight(FlightDto dto);
	
	
	
}
