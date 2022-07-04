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
<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

<title>Insert title here</title>
<script>
	$(document).ready(function(){
		$("#forgotIdPopUpButton").click(function(){
			window.open("${appRoot}/user/forgotId", 'forgotIdPopUp', 'width=500, height=500, left=200, top=100, menubar=no, status=no, toolbar=no');
		});
		
		$("#forgotPwPopUpButton").click(function(){
			window.open("${appRoot}/user/forgotPw", 'forgotPwPopUp', 'width=500, height=500, left=200, top=100, menubar=no, status=no, toolbar=no');
		});
	});

</script>
</head>
<body>

	<tag:navBar></tag:navBar>
	<div class="container">
		<h1>로그인</h1>
		<div>
			<form action="${appRoot }/login" method="post">
				<div class="col-md-3">
					아이디 : <input class="form-control" type="text" name="username" />
				</div>
				<div class="col-md-3">
					비밀번호 : <input class="form-control" type="password" name="password"/>
				</div>
				<input type="checkbox" name="remember-me"/> 로그인 상태 유지<br />
				<input class="btn btn-success" form="loginPageRegisterForm" type="submit" value="회원가입" />
				<input class="btn btn-primary" type="submit" value="로그인" />
			</form>
			<div class="col">
				<div class="row">	
					<div class="col">
						<button class="btn btn-secondary" id="forgotIdPopUpButton">아이디 찾기</button>
						<button class="btn btn-secondary" id="forgotPwPopUpButton">비밀번호 찾기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="d-none">
	<form action="${appRoot }/user/register" id="loginPageRegisterForm"></form>
</div>	

</body>
</html>