<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:url value="/user/myPage" var="userInfoSideLink"/>
<c:url value="/user/dmReceiveList" var="receivedMessagesSideLink"/>
<c:url value="/user/dmSendList" var="sendMessagesSideLink"/>

<c:url value="/user/writePrivateEnquiry" var="writePrivateEnquirySideLink"/>
<c:url value="/user/userPrivateEnquiryList" var="userPrivateEnquiryListSideLink"/>


<div class="container">
	<div class="row">
		<div class="col navbar-left">
			<nav class="nav flex-column" style="posotion: relative; left: 0px; margin-top: 0px; bottom: inherit;">
				<a class="nav-link" href="${userInfoSideLink }">회원 정보</a>
				<a class="nav-link" href="${receivedMessagesSideLink }">받은 메시지함</a>
				<a class="nav-link" href="${sendMessagesSideLink }">보낸 메시지함</a>
				<a class="nav-link" href="${appRoot }">예약 목록 조회</a>
				<a class="nav-link" href="${writePrivateEnquirySideLink }">1:1 문의</a>
				<a class="nav-link" href="${userPrivateEnquiryListSideLink }">나의 문의 목록</a>
			</nav>
		</div>
	</div>
</div>