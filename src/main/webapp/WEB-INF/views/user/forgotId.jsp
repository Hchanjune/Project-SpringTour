<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>아이디 찾기</title>
<script>
	$(document).ready(function(){	
		$("#findIdButton").click(function(){
			$(this).hide();
			$("#findIdEmailInput").attr("readonly", "");
			$("#findIdMessage").css("color", "blue");
			$("#findIdMessage").text("메일이 발송되었습니다.");
		});
	});
	
</script>
</head>
<body>
	<div class="container justify-content-center">
		<br />
		<h3>아이디 찾기</h3>
		<br />
		<p>가입하실때 등록하신 이메일을 입력하여 주세요.</p>
		<form action="${appRoot }/user/forgotId" method="post">
			<input type="email" name="email" id="findIdEmailInput" placeholder="example@spring.com"/>
			<button type="submit" id="findIdButton">찾기</button>
		</form>
		<br />
		<p>가입하신 이메일로 아이디가 발송됩니다.</p>
		<p id="findIdMessage"></p>
		<div style="text-align:center;">
			<button onclick="self.close();"> 닫기 </button>
		</div>
	</div>	
</body>
</html>