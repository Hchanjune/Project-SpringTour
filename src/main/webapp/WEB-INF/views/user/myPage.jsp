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
		$("#userInfoModifyButton").click(function(){
			$(this).hide();
			$("#userInfoModifyPasswordButton").hide();
			$("#userInfoWithdrawButton").hide();
			$("#userInfoUserBirthDate").removeAttr("readonly");
			$("#userInfoUserAddress").removeAttr("readonly");
			$("#userInfoModifySubmitButton").show();
			$("#userInfoModifyResetButton").show();
			$("#userInfoModifyPasswordButton").show();
		});
		
		$("#userInfoModifyByAdminButton").click(function(){
			$(this).hide();
			$("#userInfoModifyButton").hide()
			$("#userInfoModifyPasswordButton").hide();
			$("#userInfoWithdrawButton").hide();
			$("#userInfoUserGrade").removeAttr("disabled");
			$("#userInfoUserName").removeAttr("readonly");
			$("#userInfoUserBirthDate").removeAttr("readonly");
			$("#userInfoUserAddress").removeAttr("readonly");
			$("#userInfoUserEmail").removeAttr("readonly");
			$("#userInfoUserInserted").removeAttr("readonly");
			$("#userInfoModifySubmitButton").show();
			$("#userInfoModifyResetButton").show();
			$("#userInfoModifyPasswordButton").show();
		});
		
	});
</script>
<title>SprigTour - MyPage</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<tag:login/>
				<tag:navBar/>
			</div>
		</div>
		
		<div class="row">
			<div class="col-2 navbar-left d-none d-md-block">
			<c:choose>
				<c:when test="${not empty management}">
					<tag:managementSideMenu current="userList"/>
				</c:when>
				<c:otherwise>
					<tag:userSideMenu current="mypage"/>
				</c:otherwise>
			</c:choose>
			</div>
			<div class="col-10">
				<h3>회원 정보</h3>
						<form id="userInfoForm" class="row g-3" action="${appRoot }/user/modifyInfo" method="post">
						<div class="row g-3">
							<div class="col-md-4">
								<label for="userInfoUserId" class="form-label">아이디</label><br />
								<input type="text" name="id" readonly class="form-control" value="${user.id }" id="userInfoUserId" >
							</div>
							
							<div class="col-md-4">
								<label for="userInfoUserGrade" class="form-label">회원 등급</label><br />
								<%-- <input type="text" name="grade" readonly class="form-control" value="${user.grade }" id="userInfoUserGrade" > --%>
								<select disabled id="userInfoUserGrade" name="grade" id="userInfoUserGrade" class="form-control" size="1">
								  <option <c:if test="${user.grade eq 'Silver'}">selected</c:if> value="Silver">Silver</option>
								  <option <c:if test="${user.grade eq 'Gold'}">selected</c:if> value="Gold">Gold</option>
								  <option <c:if test="${user.grade eq 'VIP'}">selected</c:if> value="VIP">VIP</option>
								  <option <c:if test="${user.grade eq '관리자'}">selected</c:if> value="관리자">관리자</option>
								</select>
							
							</div>
						</div>
						
						<div class="row g-3">
							<div class="col-md-4">
								<label for="userInfoUserName" class="form-label">이름</label>
								<input type="text" name="name" readonly class="form-control" id="userInfoUserName" value="${user.name }">
							</div>
							<div class="col-md-4">
								<label for="userInfoUserBirthDate" class="form-label">생년월일</label>
								<input type="date" name="birthDate" readonly class="form-control" id="userInfoUserBirthDate" value="${user.birthDate }">
							</div>
						</div>
		
						
						<div class="col-8">
							<label for="userInfoUserAddress" class="form-label">주소</label>
							<input type="text" name="address" readonly name="address" class="form-control" id="userInfoUserAddress" placeholder="주소를 입력해주세요" value="${user.address }" required>
						</div>
						
						<div class="col-8">
							<label for="userInfoUserEmail" class="form-label">이메일</label>
							<div class="input-group mb-3">
								<input type="text" readonly name="email" class="form-control" id="userInfoUserEmail" value="${user.email }">
							</div>
						</div>
						
						<div class="col-8">
							<label for="userInfoUserInserted" class="form-label">가입일시</label>
							<div class="input-group mb-3">
								<input type="datetime-local" name="insertedTime" readonly class="form-control" id="userInfoUserInserted" value="${user.inserted }">
							</div>
						</div>
						
					</form>
						<c:if test="${principal.username == user.id }">
							<button class="btn btn-primary" id="userInfoModifyButton">회원정보 수정</button>
							<button class="btn btn-primary" id="userInfoModifyPasswordButton" type="submit" form="userInfoModifyPasswordForm"  style="display : none;">비밀번호 변경</button>
							<button class="btn btn-danger" id="userInfoWithdrawButton">회원 탈퇴</button>
						</c:if>
						
						<sec:authorize access="hasAnyRole('ADMIN','DEVELOPER')">
						<div>
							<button class="btn btn-warning float-right" id="userInfoModifyByAdminButton">관리자 권한으로 수정</button>						
						</div>
						</sec:authorize>
					</div>
					<div>
						<button class="btn btn-success" type="submit" form="userInfoForm" id="userInfoModifySubmitButton" style="display : none;">수정</button>
						<button class="btn btn-danger" type="submit" form="userInfoModifyResetForm" id="userInfoModifyResetButton" style="display : none;">취소</button>
					</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-12">
				<div class="d-none" >
					<form action="${appRoot }/user/myPage" id="userInfoModifyResetForm">
						<input type="hidden" name="userId" value="${user.id }" /> 
					</form>
				</div>	
				<div class="d-none" >
					<form action="${appRoot }/user/changePassword" id="userInfoModifyPasswordForm" method="post">
						<input type="hidden" name="userId" value="${user.id }" />
					</form>
				</div>	
				<tag:footer/>
			</div>
		</div>
	

</body>
</html>