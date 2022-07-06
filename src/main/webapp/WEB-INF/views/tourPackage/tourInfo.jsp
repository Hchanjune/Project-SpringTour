<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<html>
<head>

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
	
<script>
	$(document).ready(function() {
		$("#edit-button1").click(function() {
			$("#input2").removeAttr("readonly");
			$("#input3").removeAttr("readonly");
			$("#input4").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
			$("#addFileInputContainer1").removeClass("d-none");
			$(".removeFileCheckbox").removeClass("d-none");
		});

		$("#delete-submit1").click(function(e) {
			e.preventDefault();

			if (confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/tourPackage/remove";
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
									<sec:authorize access="hasRole('ADMIN')">
										<button id="edit-button1" class="btn btn-secondary">
											<i class="fa-solid fa-pen-to-square"></i>
										</button>
									</sec:authorize>

								</h1>

								<c:if test="${not empty message }">
									<div class="alert alert-primary">${message }</div>
								</c:if>
								
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

								<form id="form1" action="${appRoot }/tourPackage/modify"
									method="post" enctype="multipart/form-data">

									<div>
										<label for="input1" class="form-label">패키지명</label> <input
											id="input1" class="form-control" type="text"
											name="packageName" value="${tourPackage.packageName}"
											readonly />
									</div>

									<div>

										<label class="form-label" for="input2">가격</label> <input
											class="form-control" type="text" name="price" required
											id="input2" value="${tourPackage.price }" readonly />
									</div>


									<div>

										<label class="form-label" for="input3">국가</label> <input
											class="form-control" type="text" name="country" required
											id="input3" value="${tourPackage.country }" readonly />
									</div>

									<div>

										<label class="form-label" for="input4">도시</label> <input
											class="form-control" type="text" name="city" required
											id="input4" value="${tourPackage.city }" readonly />
									</div>

									<div id="addFileInputContainer1" class="d-none">
										파일 추가: <input type="file" accept="image/*" multiple="multiple"
											name="addFileList" />
									</div>

									<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
									<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
								</form>
							</div>
							<div class="text-center">
								<div class="d-none">
									<form id="reservationFormLink" action="${appRoot }/reservation/reserve" method="post">
										<input type="text" name="packageName" value="${tourPackage.packageName}" />
									</form>
									
								</div>
									<br />
									<sec:authorize access="isAuthenticated()">
										<button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#reservationConfirmModal">예약하기</button>
										<div class="modal fade" id="reservationConfirmModal" tabindex="-1" aria-labelledby="reservationConfirmModalLabel" aria-hidden="true">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="reservationConfirmModalLabel">예약하기</h5>
														<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														${tourPackage.packageName } 상품을 정말 예약하시겠습니까?
													</div>
													<div class="modal-footer">
														<button id="reserveButton" class="btn btn-warning" form="reservationFormLink" type="submit">예약하기</button>
														<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
													</div>
												</div>
											</div>
										</div>
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