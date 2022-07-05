<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

<title>SpringTour 회원가입</title>
</head>
<!-- enableRegister -->
<script>
	
	$(document).ready(function(){	
		let idAvailable = false;
		let pwAvailable = false;
		let emailAvailable = false;
		
		$("#idCheckButton").click(function(e){
			e.preventDefault();
			$(this).attr("disabled", "");
			const data = {
					id : $("#userRegisterForm").find("[name=id]").val()
				}
			$.ajax({
				url : "${appRoot}/user/check",
				method : "get",
				data : data,
				success : function(data){
					switch (data) {
						case "available":
							idAvailable = true;
							$("#idCheckMessage").css("color", "blue");
							$("#idCheckMessage").text("사용 가능한 아이디 입니다.");
							break;
						case "unavailable":
							idAvailable = false;
							$("#idCheckMessage").css("color", "red");
							$("#idCheckMessage").text("사용 불가능한 아이디 입니다.");
							break;
					}
				},
				error : function(){
					$("#idCheckMessage").text("아이디 중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function(){
					$("#idCheckButton").removeAttr("disabled");
					enableRegister();
				}
			});
		});
		
		$("#emailCheckButton").click(function(e){
			e.preventDefault();
			$(this).attr("disabled", "");
			const data = {
					email : $("#userRegisterForm").find("[name=email]").val()
				}
			$.ajax({
				url : "${appRoot}/user/check",
				method : "get",
				data : data,
				success : function(data){
					switch (data) {
						case "available":
							$("#emailCheckMessage").css("color", "blue");
							$("#emailCheckMessage").text("사용 가능한 메일주소 입니다.");
							emailAvailable = true;
							break;
						case "unavailable":
							$("#emailCheckMessage").css("color", "red");
							$("#emailCheckMessage").text("사용 불가능한 메일주소 입니다.");
							emailAvailable = false;
							break;
					}
				},
				error : function(){
					$("#emailCheckMessage").text("메일주소 중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function(){
					$("#emailCheckButton").removeAttr("disabled");
					enableRegister();
				}
			});
		});
		
		$("#inputUserPasswordCheck").keyup(function() {
			const inputUserPassword = $("#inputUserPassword").val();
			const inputUserPasswordCheck = $("#inputUserPasswordCheck").val();
			if (inputUserPassword == inputUserPasswordCheck) {
				$("#passwordCheckMessage").css("color", "blue");
				$("#passwordCheckMessage").text("비밀번호가 일치 합니다.");
				pwAvailable = true;
			} else {
				$("#passwordCheckMessage").css("color", "red");
				$("#passwordCheckMessage").text("비밀번호가 일치 하지 않습니다.");
				pwAvailable = false;
			}
			enableRegister();
		});
		
		const enableRegister = function() {
			if (idAvailable && pwAvailable && emailAvailable) {
				$("#registerButton").removeAttr("disabled");
			} else {
				$("#registerButton").attr("disabled", "");
			}
		}
		
		$("#registerButton").click(function(){
			$(this).hide();
			$("#registerMessageDiv").removeClass("d-none");
			$("#registerMessage").text("처리중입니다! 잠시만 기다려주세요");
		});
	});
</script>
<body>

	<tag:navBar/>
	<div class="container">
		<form id="userRegisterForm" class="row g-3" action="${appRoot }/user/register" method="post">
			<div class="col-md-3">
				<label for="inputUserId" class="form-label">아이디</label><br />
				<div class="input-group mb-3">
					<input type="text" name="id" class="form-control" id="inputUserId" placeholder="아이디를 입력해주세요" aria-describedby="idCheckButton" required>
					<button class="btn btn-outline-secondary" type="button" id="idCheckButton">중복 확인</button>
				</div>
				<p id="idCheckMessage"></p>
			</div>
			
			<div class="row g-3">
				<div class="col-md-4">
					<label for="inputUserPassword" class="form-label">비밀번호</label>
					<input type="password" name="password" class="form-control" id="inputUserPassword" required>
				</div>
				<div class="col-md-4">
					<label for="inputUserPasswordCheck" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-control" id="inputUserPasswordCheck" required>
				</div>
				<p id="passwordCheckMessage"></p>
			</div>
			
			<div class="row g-3">
				<div class="col-md-4">
					<label for="inputtUserName" class="form-label">이름</label>
					<input type="text" name="name" class="form-control" id="inputtUserName" placeholder="이름을 입력해주세요" required>
				</div>
				<div class="col-md-4">
					<label for="inputtUserBirthDate" class="form-label">생년월일</label>
					<input type="date" name="birthDate" class="form-control" id="inputtUserBirthDate" required>
				</div>
			</div>
			
			<div class="col-8">
				<label for="inputUserAddress" class="form-label">주소</label>
				<input type="text" name="address" class="form-control" id="inputUserAddress" placeholder="주소를 입력해주세요" required>
			</div>
			
			<div class="col-8">
				<label for="inputUserEmail" class="form-label">이메일</label>
				<div class="input-group mb-3">
					<input type="text" name="email" class="form-control" id="inputUserEmail" placeholder="example@springtour.com" aria-describedby="emailCheckButton" required>
					<button class="btn btn-outline-secondary" type="button" id="emailCheckButton">중복 확인</button>
				</div>
				<p>이메일 주소를 정확히 입력해주세요! 가입인증 메일이 발송됩니다.</p>
				<p id="emailCheckMessage"></p>
				<button id="registerButton" type="submit" class="btn btn-primary" disabled>회원 가입</button>
				<div id="registerMessageDiv" class="alert alert-primary d-none">
					<p id="registerMessage"></p>
				</div>
			</div>
			
			<div class="col-12">
				<tag:footer/>
			</div>
		</form>
	</div>
</body>
</html>