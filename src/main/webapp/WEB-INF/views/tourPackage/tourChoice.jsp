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

<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

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
			<div class="col-0"></div>
			<!-- Main -->
			<div class="col-12">
				<div class="container">
					<div class="row">
						<div class="col">											
							<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" style="width:740px; height:530px;">
  								<div class="carousel-indicators">
    								<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    								<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
    								<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
  								</div>
  						<div class="carousel-inner">
    						<div class="carousel-item active">
      							<img src="../resources/img/hanoi.jpg" class="d-block w-100" alt="...">
      							<div class="carousel-caption d-none d-md-block">
        							<h5>2022 하반기 골프</h5>
       								<p>코로나 끝! 이젠 골프치러 다양한 혜택으로 가봐요!</p>
      							</div>
    						</div>
    					<div class="carousel-item">
      						<img src="../resources/img/Tokyo.jpg" class="d-block w-100" alt="...">
      							<div class="carousel-caption d-none d-md-block">
       								 <h5>2022 훈훈한 노후여행</h5>
       								 <p>코로나 끝나고 부모님과 함께 가는 따뜻한 여행!</p>
      							</div>
    					</div>
   					 <div class="carousel-item">
      					<img src="../resources/img/hawai.jpg" class="d-block w-100" alt="...">
      						<div class="carousel-caption d-none d-md-block">
        						   <h5>2022 S/S 웨딩&허니문</h5>
       								<p>한번 뿐인 허니문, 혜택 가득 찬스!</p>
       								<p>꼭 달콤한 추억으로 간직할 수 있도록</p>
     						</div>
    				</div>
 			 </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev" >
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
						
						
							<h1></h1>
							<h1>여행 패키지</h1>
							<c:if test="${not empty message }">
								<div class="alert alert-primary">${message }</div>
							</c:if>

							<!-- table.table>thead>tr>th*3^^tbody -->
							<table class="table board_list">
								<thead>
									<tr>
										<th>패키지명</th>
										<th>가격</th>
										<th>국가</th>
										<th>도시</th>									
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
									<button type="button" class="btn btn-primary btn-lg">
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
			<div class="col-12">
				<tag:footer/>
			</div>
		</div>

	</div>



</body>
</html>