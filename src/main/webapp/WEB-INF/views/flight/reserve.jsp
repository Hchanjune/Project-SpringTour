<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "sec" uri = "http://www.springframework.org/security/tags"%>
<%@ taglib prefix = "tag" tagdir = "/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>

<body>
	<tag:navBar></tag:navBar>
	</br> </br>
	<div id="container">
		<div class="divaa">
			<h1 align="center">항공권예매</h1>
			
			</br> </br> </br>
			
			<label >출발지 선택 </label> 
			<select class="selectOptions" id="Depart">
				<option>출발지 선택</option>
				<optgroup label="국내">
					<option value="INC" style="width: 100%">인천 국제공항</option>
				</optgroup>
				<optgroup label="해외">
					<option value="HAN" style="width: 100%">노이바이 국제공항</option>
					<option value="HNL" style="width: 100%">호놀룰루 국제공항</option>
					<option value="HND" style="width: 100%">도쿄 국제공항</option>
				</optgroup>
			</select> 
			
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			<label align="center">도착지 선택 </label> 
			<select class="selectOptions" id="Arrive">
				<option>도착지 선택</option>
				<optgroup label="국내">
					<option value="INC" style="width: 100%">인천 국제공항</option>
				</optgroup>
				<optgroup label="해외">
					<option value="HAN" style="width: 100%">노이바이 국제공항</option>
					<option value="HNL" style="width: 100%">호놀룰루 국제공항</option>
					<option value="HND" style="width: 100%">도쿄 국제공항</option>
				</optgroup>
			</select>
		</div>

	</div>

	</br> </br> 
	
	<div class="btnSubmit" align="center" style="text-align: center;">
		<input type="button" class="booksubmit" id="reservationsubmit" value="비행기 조회">
	</div>


</body>
</html>