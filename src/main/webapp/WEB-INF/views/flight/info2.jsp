<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

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

			<div class="row">
				<!-- Left -->
				<div class="col-2 navbar-left">
					<tag:managementSideMenu current="insertFlight"/>
				</div>

				<!-- Main -->
				<div class="col-10">
					
					<h1>스케줄 추가하기</h1>
					
					<form action="${appRoot }/flight/info2" method="post" id="insertReserve">
						비행기 번호 : <input type="text" name="planeNumber" ><br />
						출발날짜 : <input type="text" name="departureDate" ><br />
						도착날짜 : <input type="text" name="returnDate" ><br />
						출발공항 : <input type="text" name="departurePort" ><br />
						도착공항 : <input type="text" name="returnPort" ><br />
					<button type="submit">저장</button>
					</form>
				</div>
				
				<!-- Footer -->
				<div class="row">
					<div class="col-12">
						<tag:footer/>
					</div>
				</div>

			</div>

		</div>
		
	</div>
</body>
</html>