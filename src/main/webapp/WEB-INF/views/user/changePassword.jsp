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
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		let changePwAvailable = false;
		
		$("#changePasswordInput").keyup(function() {
			const inputChangeUserPassword1 = $("#changePasswordInput").val();
			const inputChangeUserPasswordCheck1 = $("#checkChangePasswordInput").val();
			if (inputChangeUserPassword1 == inputChangeUserPasswordCheck1) {
				$("#passwordChangeCheckMessage").css("color", "blue");
				$("#passwordChangeCheckMessage").text("비밀번호가 일치 합니다.");
				changePwAvailable = true;
			} else {
				$("#passwordChangeCheckMessage").css("color", "red");
				$("#passwordChangeCheckMessage").text("비밀번호가 일치 하지 않습니다.");
				changePwAvailable = false;
			}
			enableChangePassword();
		});
		
		$("#checkChangePasswordInput").keyup(function() {
			const inputChangeUserPassword2 = $("#changePasswordInput").val();
			const inputChangeUserPasswordCheck2 = $("#checkChangePasswordInput").val();
			if (inputChangeUserPassword2 == inputChangeUserPasswordCheck2) {
				$("#passwordChangeCheckMessage").css("color", "blue");
				$("#passwordChangeCheckMessage").text("비밀번호가 일치 합니다.");
				changePwAvailable = true;
			} else {
				$("#passwordChangeCheckMessage").css("color", "red");
				$("#passwordChangeCheckMessage").text("비밀번호가 일치 하지 않습니다.");
				changePwAvailable = false;
			}
			enableChangePassword();
		});
		
		const enableChangePassword = function() {
			if (changePwAvailable) {
				$("#changePasswordRegisterButton").removeAttr("disabled");
			} else {
				$("#changePasswordRegisterButton").attr("disabled", "");
			}
		}
	});
</script>
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
			<div class="col-1">
				<tag:userSideMenu/>
			</div>
			<!-- Main -->
			<div class="col-11">
				<c:if test="${not empty resultMessage}">
					<div class="alert alert-primary">
						${resultMessage }
					</div>
				</c:if>
				<c:if test="${not empty userId}">
					<div>
						<p>${userId }님의 비밀번호 변경</p>
						<form action="${appRoot }/user/modifyPassword" method="post">
							<input type="hidden" name="userId" value="${userId }" />
							<label for="changePasswordInput" class="form-label">변경하실 비밀번호</label>
							<input type="password" name="newPassword" id="changePasswordInput" /><br />
							<label for="inputUserPassword" class="form-label">변경하실 비밀번호 확인</label>
							<input type="password" id="checkChangePasswordInput" /><br />
							<input type="submit" value="비밀번호 변경" id="changePasswordRegisterButton" disabled />
						</form>
						<p id="passwordChangeCheckMessage"></p>
					</div>
				</c:if>
			</div>
		</div>
		<!-- Footer -->
		<div class="row">
			<div class="col-12">
			
			</div>
		</div>
		
	</div>
</body>
</html>