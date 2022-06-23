<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
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
			<form action="${appRoot }/tourPackage/insert" method="post"
				enctype="multipart/form-data">
				<div class="mb-3">
					<label for="formGroupExampleInput" class="form-label">패키지명</label>
					<input type="text" class="form-control" id="formGroupExampleInput"
						name="packageName" placeholder="Example input placeholder">
				</div>

				<div class="mb-3">
					<label for="formGroupExampleInput2" class="form-label">가격</label> <input
						type="text" class="form-control" id="formGroupExampleInput2"
						name="price" placeholder="Another input placeholder">
				</div>

				<div class="mb-3">
					<label for="formGroupExampleInput2" class="form-label">가능/불가능</label>
					<input type="text" class="form-control" id="formGroupExampleInput2"
						name="bookable" placeholder="Another input placeholder">
				</div>

				<div class="mb-3">
					<label for="formGroupExampleInput2" class="form-label">나라</label> <input
						type="text" class="form-control" id="formGroupExampleInput2"
						name="country" placeholder="Another input placeholder">
				</div>

				<div class="mb-3">
					<label for="formGroupExampleInput2" class="form-label">도시</label> <input
						type="text" class="form-control" id="formGroupExampleInput2"
						name="city" placeholder="Another input placeholder">
				</div>

				<div class="col-auto">
					<label class="form-label" for="autoSizingSelect">출국예약번호</label> <select
						class="form-select" id="autoSizingSelect"
						name="flightDepartTicket">
						<option selected>선택</option>
						<c:forEach items="${flightList}" var="Departplane">
							<option><c:out value="${Departplane.planeNumber }"></c:out></option>
						</c:forEach>
					</select>
				</div>

				<div class="col-auto">
					<label class="form-label" for="autoSizingSelect">입국예약번호</label> <select
						class="form-select" id="autoSizingSelect"
						name="flightReturnTicket">
						<option selected>선택</option>
						<c:forEach items="${flightList}" var="Returnplane">
							<option><c:out value="${Returnplane.planeNumber }"></c:out></option>
						</c:forEach>
					</select>
				</div>
				<div>
					파일 
					<input multiple="multiple" type="file" name="file"	accept="image/*" />
				</div>

				<button class="btn btn-primary">작성</button>
			</form>
			<!-- Footer -->
			<div class="row">
				<div class="col-12"></div>
			</div>

		</div>
</body>
</body>
</html>