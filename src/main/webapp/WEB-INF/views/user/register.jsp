<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>

	<tag:navBar/>
	<div class="container">
		<form class="row g-3" action="${appRoot }/user/register" method="post">
			<div class="row  g-3">
				<div class="col-md-4">
					<label for="inputUserId" class="form-label">아이디</label>
					<input type="text" name="id" class="form-control" id="inputUserId" placeholder="아이디를 입력해주세요" required>
				</div>
			</div>
			
			<div class="row g-3">
				<div class="col-md-6">
					<label for="inputUserPassword" class="form-label">비밀번호</label>
					<input type="password" name="password" class="form-control" id="inputUserPassword" required>
				</div>
				<div class="col-md-6">
					<label for="inputUserPasswordCheck" class="form-label">비밀번호 확인</label>
					<input type="password" class="form-control" id="inputUserPasswordCheck" required>
				</div>
			</div>
			
			<div class="row g-3">
				<div class="col-md-6">
					<label for="inputtUserName" class="form-label">이름</label>
					<input type="text" name="name" class="form-control" id="inputtUserName" required>
				</div>
				<div class="col-md-6">
					<label for="inputtUserBirthDate" class="form-label">생년월일</label>
					<input type="date" name="birthDate" class="form-control" id="inputtUserBirthDate" required>
				</div>
			</div>
			
			<div class="col-12">
				<label for="inputUserAddress" class="form-label">주소</label>
				<input type="text" name="address" class="form-control" id="inputUserAddress" placeholder="주소를 입력해주세요" required>
			</div>
			
			<div class="col-12">
				<label for="inputUserEmail" class="form-label">이메일</label>
				<input type="text" name="email" class="form-control" id="inputUserEmail" placeholder="주소를 정확히 입력해주세요! 가입인증 메일이 발송됩니다" required>
			</div>
			
			<div class="col-12">
				<button type="submit" class="btn btn-primary">회원 가입</button>
			</div>
		</form>
	</div>
</body>
</html>