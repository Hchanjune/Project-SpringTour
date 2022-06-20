<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>    
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


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
				let actionAttr = "${appRoot}/serviceCenter/remove";
				form1.attr("action", actionAttr);
				
				form1.submit();
			}
			
		});




</script>

<title>Insert title here</title>
</head>
<body>


	<tag:login/>
	<tag:navBar/>
	

	<div class="container">
		<div class="row">
			<div class="col">
				
				<div class="mt-3">	
					<sec:authorize access="hasRole('ADMIN')">
						<sec:authentication property="principal" var="principal" />
						<c:if test="${principal.username == post.writer }">
							<button id="edit-button1" class="btn btn-secondary">
								<i class="fa-solid fa-user-pen"></i>
							</button>
						</c:if>
					</sec:authorize>
				</div>
				

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form action="${appRoot }/serviceCenter/modify" method="post">
					<input type="hidden" name="indexId" value="${post.indexId }" />
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" type="text" name="title" value="${post.title }" id="input1"
							readonly />
					</div>

					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" name="body" id="textarea1"
							cols="30" rows="10" readonly>${post.body }</textarea>
					</div>


					<button id="modify-submit1" class="btn btn-secondary d-none">수정</button>

					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>


				</form>

				<!-- <div class="col justify-content-right" align="right"> -->

				<div class="mt-3">
					<form action="${appRoot }/serviceCenter/notice" method="get">
						<button class="btn btn-primary">목록보기</button>
					</form>
				</div>

			</div>
		</div>
	</div>
	
	
</body>
</html>