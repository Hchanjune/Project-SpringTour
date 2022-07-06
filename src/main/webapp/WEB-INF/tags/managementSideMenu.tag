<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:url value="/user/userList" var="userListSideLink"/>
<c:url value="/user/adminSendMail" var="adminSendMailSideLink"/>
<c:url value="/tourPackage/insert" var="tourPackageInsertSideLink"/>
<c:url value="/flight/info2" var="flightInfoInsertSideLink"/>
<c:url value="/user/adminPrivateEnquiryList" var="adminPrivateEnquiryListSideLink"/>


<%@ attribute name="current"%>
<div class="navbar_menu">
	<h3>관리자 메뉴</h3>	
	<a class="nav-link ${current == 'userList' ? 'left_nav_active' : '' }" href="${userListSideLink }">회원 관리</a>
	<a class="nav-link ${current == 'sendMail' ? 'left_nav_active' : '' }" href="${adminSendMailSideLink }">메일 발송</a>
	<a class="nav-link ${current == 'insertPackage' ? 'left_nav_active' : '' }" href="${tourPackageInsertSideLink }">여행상품 추가</a>
	<a class="nav-link ${current == 'insertFlight' ? 'left_nav_active' : '' }" href="${flightInfoInsertSideLink }">항공편 추가</a>
	<a class="nav-link ${current == 'replyPrivateEnquiry' ? 'left_nav_active' : '' }" href="${adminPrivateEnquiryListSideLink }">1:1 문의 목록</a>
</div>