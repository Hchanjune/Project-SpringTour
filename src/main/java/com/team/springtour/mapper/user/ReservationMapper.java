package com.team.springtour.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.team.springtour.domain.user.ReservationDto;

public interface ReservationMapper {

	int insertReservationByUserId(@Param("packageName")String packageName, 
									@Param("userId")String userId, 
									@Param("reservationId")String reservationId);

	List<String> selectReservationIdAll();

	List<ReservationDto> selectReservationListByUserId(String userId);

	int deleteReservationByReservationId(String reservationId);

}
