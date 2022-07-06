<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<link rel="stylesheet" type="text/css" href="../../resources/css/style.css">

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
							<h1>후기 목록</h1>
							<c:if test="${not empty message }">
								<div class="alert alert-primary">${message }</div>
							</c:if>

							<!-- table.table>thead>tr>th*3^^tbody -->
							<table class="table">
								<thead>
									<tr>
										<th>ID</th>
										<th>제목</th>
										<th>작성자</th>
										<th>패키지명</th>
										<th><i class="fa-solid fa-calendar"></i></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${reviewList }" var="review">
										<tr>
											<td>${review.indexId }</td>
											<td><c:url value="/tourPackage/Review/reviewGet" var="reviewGetUrl">
													<c:param name="indexId" value="${review.indexId }">
													</c:param>
												</c:url> 
											<a href="${reviewGetUrl }"> <c:out
														value="${review.title }" />
											</a></td>
											<td><c:out value="${review.writer}"></c:out></td>
											<td>${review.packageName}</td>
											<td>${review.prettyInserted}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="col justify-content-right" align="right">
								<sec:authorize access="isAuthenticated()">
									<button type="button" class="btn btn-primary btn-lg">
										<a href="${appRoot}/tourPackage/Review/reviewInsert">글쓰기</a>
									</button>
								</sec:authorize>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Footer -->
		<div class="row">
			<div class="col-12">
				<tag:footer/>
			</div>
		</div>

	</div>
</body>
</html>