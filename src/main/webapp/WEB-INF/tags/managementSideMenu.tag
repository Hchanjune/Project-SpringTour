<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:url value="/user/userList" var="userListSideLink"/>
<c:url value="/tourPackage/insert" var="tourPackageInsertSideLink"/>
<c:url value="/flight/info2" var="flightInfoInsertSideLink"/>
<c:url value="/user/adminPrivateEnquiryList" var="adminPrivateEnquiryListSideLink"/>


<div class="container">
	<div class="row">
		<div class="col">
			<nav class="nav flex-column" style="posotion: relative; left: 0px; margin-top: 0px; bottom: inherit;">
				<a class="nav-link" href="${userListSideLink }">회원 관리</a>
				<a class="nav-link" href="${receivedMessagesSideLink }">메일 발송</a>
				<a class="nav-link" href="${tourPackageInsertSideLink }">여행상품 추가</a>
				<a class="nav-link" href="${flightInfoInsertSideLink }">항공편 추가</a>
				<a class="nav-link" href="${adminPrivateEnquiryListSideLink }">1:1 문의 목록</a>
			</nav>
		</div>
	</div>
</div>