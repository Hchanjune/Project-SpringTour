package com.team.springtour.service.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team.springtour.domain.user.ReservationDto;
import com.team.springtour.mapper.user.ReservationMapper;

@Service
public class ReservationService {
	@Autowired
	ReservationMapper reservationMapper;

	public boolean reserveTourPackageByUserId(String packageName, String userId) {
		String reservationId = generateReservationId();
		return reservationMapper.insertReservationByUserId(packageName, userId, reservationId) == 1;
	}
	
	private String generateReservationId() {
		List<String> reservationIdList = reservationMapper.selectReservationIdAll();
		String reservationId = getRandomStr(6);
		while(reservationIdList.contains(reservationId)) {
			reservationId = getRandomStr(6);
		}
		return reservationId;
	}
	
	public String getRandomStr(int size) {
		if(size > 0) {
			char[] tmp = new char[size];
			for(int i=0; i<tmp.length; i++) {
				int div = (int) Math.floor( Math.random() * 2 );
				
				if(div == 0) { // 0이면 숫자로
					tmp[i] = (char) (Math.random() * 10 + '0') ;
				}else { //1이면 알파벳
					tmp[i] = (char) (Math.random() * 26 + 'A') ;
				}
			}
			return new String(tmp);
		}
		return "ERROR : Size is required."; 
	}

	public List<ReservationDto> getReservationListByUserId(String userId) {
		return reservationMapper.selectReservationListByUserId(userId);
	}

	public boolean cancelReservationByReservationId(String reservationId) {
		return reservationMapper.deleteReservationByReservationId(reservationId) == 1;
	}
	
}
