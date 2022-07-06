package com.team.springtour.controller.user;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.springtour.domain.user.ReservationDto;
import com.team.springtour.service.user.ReservationService;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	@Autowired
	ReservationService reservationService;
	
	@PostMapping("reserve")
	public String reserve(String packageName, Principal principal, RedirectAttributes rttr) {
		boolean success = reservationService.reserveTourPackageByUserId(packageName, principal.getName());
		String resultMessage;
		if (success) {
			resultMessage = "예약이 완료되었습니다.";
		}else {
			resultMessage = "예기치 못한 오류가 발생하였습니다.";
		}
		rttr.addFlashAttribute("resultMessage",resultMessage);
		return "redirect:/reservation/reservationList";
	}
	
	@GetMapping("reservationList")
	public String reservationList(Model model, Principal principal) {
		List<ReservationDto> reservationList = reservationService.getReservationListByUserId(principal.getName());
		model.addAttribute("reservationList", reservationList);
		return "/reservation/reservationList";
	}
	
	@GetMapping("reservationInfo")
	public String reservationInfo() {
		return null;
	}
	
	@PostMapping("cancel")
	public String reservationCancel(String reservationId, RedirectAttributes rttr) {
		boolean success = reservationService.cancelReservationByReservationId(reservationId);
		String resultMessage;
		if (success) {
			resultMessage = "예약이 취소되었습니다.";
		}else {
			resultMessage = "예기치 못한 오류가 발생하였습니다.";
		}
		rttr.addFlashAttribute("resultMessage",resultMessage);
		return "redirect:/reservation/reservationList";
	}
	
}
