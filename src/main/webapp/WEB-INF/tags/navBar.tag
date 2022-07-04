<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>



<c:url value="/main/home" var="homeLink" />
<c:url value="/user/register" var="registerLink" />
<c:url value="/serviceCenter/notice" var="noticeLink" />
<c:url value="/tourPackage/tourChoice" var="tourPackageLink" />
<c:url value="/flight/info" var="flightInfoLink" />
<c:url value="/tourPackage/Review/reviewList" var="packageReviewLink" />

<!-- NoticePages -->
<c:url value="/serviceCenter/notice" var="noticeLink" />
<c:url value="/serviceCenter/qnaList" var="qnaListLink" />
<c:url value="/serviceCenter/freq" var="freqListLink" />
<!-- MyPageLinks -->
<c:url value="/user/myPage" var="myPageLink" />
<c:url value="/user/dmReceiveList" var="dmReceiveListLink" />
<c:url value="/user/dmSendList" var="dmSendListLink" />

<c:url value="/user/writePrivateEnquiry" var="writePrivateEnquiryLink" />
<c:url value="/user/userPrivateEnquiryList"
	var="userPrivateEnquiryListLink" />
<!-- ManagementLinks -->
<c:url value="/user/userList" var="userListPageLink" />
<c:url value="/tourPackage/insert" var="tourPackageInsertLink" />
<c:url value="/flight/info2" var="flightInfoInsertLink" />
<c:url value="/user/adminPrivateEnquiryList" var="adminPrivateEnquiryListLink"/>


<nav class="navbar navbar-expand-sm bg-light" style="background-color: #e3f2fd;">
	<div class="container-fluid">
		<a class="navbar-brand" style="font-size:2.25rem" href="${homeLink }">Spring Tour</a>
		<button class="navbar-toggler" type="button"
			data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
			aria-controls="offcanvasNavbar">
			<i class="fa-solid fa-bars-staggered"></i>
		</button>
		<div class="offcanvas offcanvas-end" tabindex="-1"
			id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
			<div class="offcanvas-header">
				<h5 class="offcanvas-title" id="offcanvasNavbarLabel">SpringTour Menu</h5>
				<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
					aria-label="Close"></button>
			</div>
			<div class="offcanvas-body">
				<ul class="navbar-nav justify-content-left flex-grow-1 pe-3">

				<%-- 	<li class="nav-item">
						<a class="nav-link active" aria-current="page" href="${homeLink }">Home</a>
					</li> --%>


					<li class="nav-item">
						<a class="nav-link" href="${tourPackageLink }">TourPackage</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="${flightInfoLink }">FlightInfo</a>
					</li>

					<li class="nav-item">
						<a class="nav-link" href="${packageReviewLink }">PackageReviews</a>
					</li>
					
					
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="${noticeLink }"
							id="offcanvasNavbarDropdown" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> Notice </a>
						<ul class="dropdown-menu"
							aria-labelledby="offcanvasNavbarDropdown">
							<li>
								<a class="dropdown-item" href="${noticeLink }">공지사항</a>
							</li>
							<li>
								<hr class="dropdown-divider">
							</li>
							<li>
								<a class="dropdown-item" href="${qnaListLink }">묻고 답하기</a>
							</li>
							<li>
								<hr class="dropdown-divider">
							</li>
							<li>
								<a class="dropdown-item" href="${freqListLink }">자주 묻는 질문</a>
							</li>
						</ul>
					</li>

					<sec:authorize access="isAuthenticated()">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="${myPageLink }"
								id="offcanvasNavbarDropdown" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"> MyPage </a>
							<ul class="dropdown-menu"
								aria-labelledby="offcanvasNavbarDropdown">
								<li>
									<a class="dropdown-item" href="${myPageLink }">회원 정보</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${dmReceiveListLink }">받은 메시지함</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${dmSendListLink }">보낸 메시지함</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${dmSendListLink }">예약목록 조회</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${writePrivateEnquiryLink }">1:1 문의</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${userPrivateEnquiryListLink }">나의 문의 목록</a>
								</li>
							</ul>
						</li>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="${myPageLink }"
								id="offcanvasNavbarDropdown" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"> Management </a>
							<ul class="dropdown-menu"
								aria-labelledby="offcanvasNavbarDropdown">
								<li>
									<a class="dropdown-item" href="${userListPageLink }">회원 관리</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="#">메일 발송</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${tourPackageInsertLink }">여행 상품 추가</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${flightInfoInsertLink }">항공편 추가</a>
								</li>
								<li>
									<hr class="dropdown-divider">
								</li>
								<li>
									<a class="dropdown-item" href="${adminPrivateEnquiryListLink }">등록된 1:1 문의</a>
								</li>	
							</ul>
						</li>
					</sec:authorize>

				</ul>
				<form class="d-flex" role="search">
					<input class="form-control me-2" type="search" placeholder="Search"
						aria-label="Search">
					<button class="btn btn-outline" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
				</form>
			</div>
		</div>
	</div>
</nav>

