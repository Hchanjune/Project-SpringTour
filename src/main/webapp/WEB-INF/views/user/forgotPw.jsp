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
<title>비밀번호 찾기</title>
<script>
	$(document).ready(function(){	
		$("#findPwButton").click(function(){
			$(this).hide();
			$("#findPwEmailInput").attr("readonly", "");
			$("#findIdMessage").css("color", "blue");
			$("#findIdMessage").text("메일을 발송중입니다 잠시만 기다려주세요.");	
		});
		
		$("#checkEmailaddressInDBbutton-fotgotPw").click(function(e){
			e.preventDefault();
			$(this).attr("disabled", "");
			const data = {
					id : $("#findPwForm").find("[name=id]").val(),
					email : $("#findPwForm").find("[name=email]").val()
				}
			$.ajax({
				url : "${appRoot}/user/checkFindPw",
				method : "get",
				data : data,
				success : function(data){
					switch (data) {
						case "true":
							$("#findPwButton").removeAttr("disabled");
							$("#checkEmailaddressInDBbutton-fotgotPw").attr("disabled", "");
							$("#checkEmailAndIdMessage").text(" ");
							break;
						case "false":
							$("#findPwButton").attr("disabled", "");
							$("#checkEmailAndIdMessage").css("color", "red");
							$("#checkEmailAndIdMessage").text("가입 정보가 일치하지 않습니다.");
							break;
					}
				},
				error : function(){
					$("#checkEmailAndIdMessage").text("확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function(){
					/* $("#checkEmailaddressInDBbutton-fotgotPw").removeAttr("disabled"); */
				}
			});	
		});
		
		$("#findPwIdInput").keyup(function(){
			$("#checkEmailaddressInDBbutton-fotgotPw").removeAttr("disabled");
			$("#findPwButton").attr("disabled", "");
		});
		
		$("#findPwEmailInput").keyup(function(){
			$("#checkEmailaddressInDBbutton-fotgotPw").removeAttr("disabled");
			$("#findPwButton").attr("disabled", "");
		});
		
	});
</script>
</head>
<body>
	<div class="container justify-content-center">
		<br />
		<h3>비밀번호 찾기</h3>
		<br />
		<p>가입하실때 등록하신 아이디와 이메일을 입력하여 주세요.</p>
		<form id="findPwForm" action="${appRoot }/user/forgotPw" method="post">
			<label for="findPwIdInput">아이디</label>
			<input class="form-control" type="text" name="id" id="findPwIdInput" placeholder="아이디를 입력해주세요." />
			<label for="findPwEmailInput">이메일</label>
			<input class="form-control" type="email" name="email" id="findPwEmailInput" placeholder="example@spring.com"/>
			<button class="btn btn-primary" id="checkEmailaddressInDBbutton-fotgotPw">조회</button>
			<button class="btn btn-success" type="submit" id="findPwButton" disabled>재설정 메일 발송</button>
		</form>
		<br />
		<p>가입하신 이메일로 비밀번호 재설정 메일이 발송됩니다.</p>
		<p id="checkEmailAndIdMessage"></p>
		<p id="findPwMessage"></p>
		<div style="text-align:center;">
			<button class="btn btn-secondary" onclick="self.close();"> 닫기 </button>
		</div>
	</div>	
</body>
</html>