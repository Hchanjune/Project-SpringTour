<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.team.springtour.domain.flight.FlightDto"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Welcome</title>
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


		<div class="row">
			<!-- Left -->
			<div class="col-1">
				<p>메뉴123123123123123123</p>
				<br />
				<p>메뉴</p>
				<br />
				<p>메뉴</p>
				<br />
				<p>메뉴</p>
				<br />
				<p>메뉴</p>
				<br />
			</div>

			<!-- Main -->
			<div class="col-11">

				<h1>스케줄 수정</h1>

				<form action="${appRoot }/flight/reserve3" method="post">
				
				<table>
					<thead>
						<tr>
							<th>비행기 번호</th>
							<th>출발날짜</th>
							<th>도착날짜</th>
							<th>출발공항</th>
							<th>도착공항</th>
							<th>삭제</th>
						</tr>
					</thead>

					<c:forEach items="${flightList }" var="Flight" >
						<tr>
							<td>${Flight.planeNumber }</td>
							<td>${Flight.departureDate }</td>
							<td>${Flight.returnDate }</td>
							<td>${Flight.departurePort }</td>
							<td>${Flight.returnPort }</td>
							<td><a href="flightList">삭제</td>
						</tr>
					</c:forEach>
				</table>
				
				<br> <br> <br> <br>
				
				<button type="submit">수정완료</button>
					

				</form>

			

				

			</div>

			<!-- Footer -->
			<div class="row">
				<div class="col-12"></div>
			</div>

		</div>

	</div>

</body>
</html>