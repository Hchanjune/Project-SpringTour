<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">
		<!-- Header -->
		<div class="row">
			<div class="col-12">
				<tag:login />
				<tag:navBar />
			</div>
		</div>
		<!-- Body -->
		<div class="row">
			<!-- Left -->
			<div class="col-1"></div>
			<!-- Main -->
			<div class="col-11">
				<div class="container">
					<div class="row">
						<div class="col">
							<h1>패키지 목록</h1>
							<c:if test="${not empty message }">
								<div class="alert alert-primary">${message }</div>
							</c:if>

							<!-- table.table>thead>tr>th*3^^tbody -->
							<table class="table">
								<thead>
									<tr>
										<th>패키지명</th>
										<th>가격</th>
										<th>국가</th>
										<th>도시</th>
										<th><i class="fa-solid fa-calendar"></i></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${tourList }" var="tour">
										<tr>

											<td><c:url value="/tourPackage/tourInfo" var="tourInfoUrl">
													<c:param name="packageName" value="${tour.packageName }">
													</c:param>

												</c:url> 
													<a href="${tourInfoUrl }"> 
														<c:out value="${tour.packageName }" />
													</a>
											</td>
												<td>${tour.price }</td>
												<td>${tour.country}</td>
												<td>${tour.city}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<sec:authorize access="hasRole('ADMIN')">
								<div class="col justify-content-right" align="right">
									<button>
										<a href="${appRoot}/tourPackage/insert">글쓰기</a>
									</button>
								</div>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Footer -->
		<div class="row">
			<div class="col-12"></div>
		</div>

	</div>



</body>
</html>