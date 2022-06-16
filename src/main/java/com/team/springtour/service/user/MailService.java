package com.team.springtour.service.user;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.team.springtour.mapper.user.UserMapper;

@Service
public class MailService {
	@Autowired
	JavaMailSender mailSender;
	@Autowired
	UserMapper userMapper;

	/*start of Generating Random Key For Email Confirm*/
	private boolean lowerCheck;
	private int size;

	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

	public String generateRandomKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}
	/*end of Generating Random Key For Email Confirm*/

	// Sending Confirm Mail
	public void mailSendWithUserKey(String email, String userId, HttpServletRequest request) {
		String key = generateRandomKey(false, 20);
		userMapper.insertUserAuthKey(userId, key);
		MimeMessage mail = mailSender.createMimeMessage();
		String html = 
				"<h2>SpringTour에 가입해 주셔서 정말 감사합니다!</h2><br><br>"
				+ "<h3>" + userId + "님 반갑습니다!</h3>" + "<p>인증하기 버튼을 누르시면 인증이 완료됩니다. : "
				+ "<a href='http://localhost:8080" + request.getContextPath() + "/user/confirm?userId=" + userId + "&authKey=" + key + "'>인증하기</a></p>"
				+ "</br></br></br>(이 요청을 보내신적이 없으시거나, 잘 못 수신된 메일일 경우 무시하여 주세요.)";
		try {
			mail.setSubject("[본인인증] SpringTour 가입인증 메일 입니다", "utf-8");
			mail.setText(html, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
	public void sendMail(String email, String title, String body) {
		MimeMessage mail = mailSender.createMimeMessage();
		try {
			mail.setSubject(title, "utf-8");
			mail.setText(body, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	

}
