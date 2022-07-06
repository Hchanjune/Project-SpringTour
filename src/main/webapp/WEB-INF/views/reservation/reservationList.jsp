<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<sec:authentication property="principal" var="principal" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

<script>

</script>
<title>SprigTour - 예약목록 조회</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<tag:login/>
				<tag:navBar/>
			</div>
		</div>
		
		<div class="row">
			<div class="col-2 navbar-left d-none d-md-block">
				<tag:userSideMenu current="reservationList"/>
			</div>
			<div class="col-10">
				<h3>예약 목록 조회</h3>
				<c:if test="${not empty resultMessage}">
					<div class="alert alert-primary">
						${resultMessage }
					</div>
				</c:if>
				<table class="table">
					<thead>
						<tr>
							<th>예약번호</th>
							<th>여행상품명</th>
							<th>예약자ID</th>
							<th>예약일시</th>
							<th>취소가능여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reservationList }" var="reservation">
							<tr>
								<td>${reservation.reservationId }</td>
								<td>${reservation.packageName }</td>
								<td>${reservation.clientName }</td>
								<td>${reservation.inserted }</td>
								<td>
									<c:choose>
										<c:when test="${reservation.retractable == true}">
											<form id="reservationCancelForm" action="${appRoot }/reservation/cancel" method="post">
												<input type="hidden" name="reservationId" value="${reservation.reservationId }" />
											</form>
											<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#reservationCancelModal">취소가능</button>
											<div class="modal fade" id="reservationCancelModal" tabindex="-1" aria-labelledby="reservationCancelModalLabel" aria-hidden="true">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="reservationCancelModalLabel">예약취소</h5>
															<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<div class="modal-body">
															예약을 정말 취소 하시겠습니까?
														</div>
														<div class="modal-footer">
															<button id="reserveButton" class="btn btn-warning" form="reservationCancelForm" type="submit">취소하기</button>
															<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
														</div>
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise> 
											<button class="btn btn-secondary" disabled>기간만료</button>
										</c:otherwise>
									</c:choose>
									
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="text-center">
					<c:if test="${empty reservationList }">
						<p>아직 예약내역이 없습니다.</p>
						<a class="btn btn-success" href="${appRoot }/tourPackage/tourChoice">여행상품 보러가기</a>
					</c:if>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-12">
				<tag:footer/>
			</div>
		</div>
	</div>

</body>
</html>