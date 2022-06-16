<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>SprigTour - MyPage</title>
</head>
<body>
<tag:login/>
<tag:navBar/>
	<div class="container">
		<form id="userRegisterForm" class="row g-3" action="${appRoot }/user/register" method="post">
			<div class="row g-3">
				<div class="col-md-3">
					<label for="userInfoUserId" class="form-label">아이디</label><br />
					<input type="text" readonly class="form-control" value="${user.id }" id="userInfoUserId" >
				</div>
			</div>
			
			<div class="row g-3">
				<div class="col-md-4">
					<label for="userInfoUserName" class="form-label">이름</label>
					<input type="text" readonly class="form-control" id="userInfoUserName" value="${user.name }">
				</div>
				<div class="col-md-4">
					<label for="userInfoUserBirthDate" class="form-label">생년월일</label>
					<input type="date" readonly class="form-control" id="userInfoUserBirthDate" value="${user.birthDate }">
				</div>
			</div>
			
			<div class="col-8">
				<label for="userInfoUserAddress" class="form-label">주소</label>
				<input type="text" readonly name="address" class="form-control" id="userInfoUserAddress" placeholder="주소를 입력해주세요" value="${user.address }" required>
			</div>
			
			<div class="col-8">
				<label for="userInfoUserEmail" class="form-label">이메일</label>
				<div class="input-group mb-3">
					<input type="text" readonly name="email" class="form-control" id="userInfoUserEmail" value="${user.email }">
				</div>
			</div>
			
		</form>
	</div>

</body>
</html>