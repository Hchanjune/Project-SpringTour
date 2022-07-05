<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<sec:authentication property="principal" var="principal" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/style.css">
<script>
	$(document).ready(function(){
		$("#sendMailConfirmButton").click(function(){
			$(this).hide();
			$("#sendEmailParagraph").text("메일을 발송중입니다. 잠시만 기다려주세요...");
			$("#sendEmailParagraph").css("color", "blue");
		});
	});
</script>
<title>SpringTour - 메일 발송</title>
</head>
<body>
	<div class="container-fluid">
		
		<!-- Header -->
		<div class="row">
			<div class="col-12">
				<tag:login/>
				<tag:navBar/>
			</div>
		</div>
		
		<!-- Body -->
		<div class="row">
			
			<!-- Left -->
			<div class="col-2 navbar-left  d-none d-md-block">
				<tag:managementSideMenu current="sendMail"/>
			</div>
			
			
			<!-- Main -->
			<div class="col-10">
				<h3>메일 발송</h3>
				<c:if test="${not empty resultMessage}">
					<div class="alert alert-primary">
						${resultMessage }
					</div>
				</c:if>
				<form id="writeEmailForm" class="form-control" action="${appRoot }/user/sendMail" method="post">
					<label for="writeEmail_emailAddress">받는사람 이메일</label>
					<input id="writeEmail_emailAddress" type="email" name="email" class="form-control" placeholder="example@springtour.com" required/>
					<label for="writeEmail_title">제목</label>
					<input id="writeEmail_title" type="text" name="title" class="form-control" placeholder="이곳에 제목을 입력하세요." required/>
					<label for="writeEmail_body">본문</label>
					<textarea class="form-control" name="body" id="writeEmail_body" cols="30" rows="10" placeholder="내용을 입력하세요." required>안녕하세요 SpringTour 입니다!</textarea>
					<div class="text-center">
						<input form="writeEmailForm" id="sendMailConfirmButton" class="btn btn-success" type="submit" value="발송" />
						<p id="sendEmailParagraph"></p>
					</div>
				</form>
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