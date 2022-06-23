<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script>
	$(document).ready(function() {
		$("#edit-button1").click(function() {
			$("#input1").removeAttr("readonly");
			$("#textarea1").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
		});

		$("#delete-submit1").click(function(e) {
			e.preventDefault();

			if (confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/tourPackage/Review/remove";
				form1.attr("action", actionAttr);
				form1.submit();
			}
		});
	});
</script>
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
				<div class="col-11">
					<div class="container">
						<div class="row">
							<div class="col">
								<h1>
									패키지

									<sec:authorize access="isAuthenticated()">

										<button id="edit-button1" class="btn btn-secondary">
											<i class="fa-solid fa-pen-to-square"></i>
										</button>
									</sec:authorize>

								</h1>

								<c:if test="${not empty message }">
									<div class="alert alert-primary">${message }</div>
								</c:if>

								<form id="form1" action="${appRoot }/tourPackage/tourInfo"
									method="post" enctype="multipart/form-data">



									<div>
										<label for="input3" class="form-label">패키지명</label> <input
											id="input 3" class="form-control" type="text"
											name="packageName" value="${tourPackage.packageName}" readonly />
									</div>

									<c:forEach items="${tourPackage.fileName }" var="file">
										<%
											String file = (String) pageContext.getAttribute("file");
										String encodedFileName = java.net.URLEncoder.encode(file, "utf-8");
										pageContext.setAttribute("encodedFileName", encodedFileName);
										%>
										<div class="row">
											<div class="col-1">
												<div class="d-none removeFileCheckbox">
													삭제 <br /> <input type="checkbox" name="removeFileList"
														value="${file }" />
												</div>
											</div>
											<div class="col-11">
												<div>
													<img class="img-fluid"
														src="${imageUrl }/tourPackage/${tourPackage.packageName }/${encodedFileName }"
														alt="" />
												</div>
											</div>
										</div>
									</c:forEach>
									<div id="addFileInputContainer1" class="d-none">
										파일 추가: <input type="file" accept="image/*" multiple="multiple"
											name="addFileList" />
									</div>



									<div>
										<label for="input3" class="form-label">가격</label> <input
											id="input 3" class="form-control" type="text" name="price"
											value="${tourPackage.price}" readonly />
									</div>


									<div>
										<label for="input3" class="form-label">나라</label> <input
											id="input 3" class="form-control" type="text" name="country"
											value="${tourPackage.country}" readonly />
									</div>

									<div>
										<label for="input3" class="form-label">도시</label> <input
											id="input 3" class="form-control" type="text" name="city"
											value="${tourPackage.city}" readonly />
									</div>

									<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
									<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
								</form>





							</div>
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