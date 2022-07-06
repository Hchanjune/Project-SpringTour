<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:url value="/user/myPage" var="userInfoSideLink" />
<c:url value="/user/dmReceiveList" var="receivedMessagesSideLink" />
<c:url value="/user/dmSendList" var="sendMessagesSideLink" />
<c:url value="/reservation/reservationList" var="reservationListSideLink" />
<c:url value="/user/writePrivateEnquiry" var="writePrivateEnquirySideLink" />
<c:url value="/user/userPrivateEnquiryList" var="userPrivateEnquiryListSideLink" />

<%@ attribute name="current"%>
<div class="navbar_menu">
	<h3>
		마이페이지
	</h3>
	<a class="nav-link ${current == 'mypage' ? 'left_nav_active' : '' }" href="${userInfoSideLink }">회원 정보</a> 
	<a class="nav-link ${current == 'receivedMessage' ? 'left_nav_active' : '' }" href="${receivedMessagesSideLink }">받은 메시지함</a> 
	<a class="nav-link ${current == 'sendMessage' ? 'left_nav_active' : '' }" href="${sendMessagesSideLink }">보낸 메시지함</a> 
	<a class="nav-link ${current == 'reservationList' ? 'left_nav_active' : '' }" href="${reservationListSideLink }">예약 목록 조회</a> 
	<a class="nav-link ${current == 'writePrivateEnquiry' ? 'left_nav_active' : '' }" href="${writePrivateEnquirySideLink }">1:1 문의</a> 
	<a class="nav-link ${current == 'userPrivateEnquiryList' ? 'left_nav_active' : '' }" href="${userPrivateEnquiryListSideLink }">나의 문의 목록</a>
</div>

<!-- left_nav_active -->

<%-- ${current == 'reservationList' ? 'left_nav_active' : '' } --%>