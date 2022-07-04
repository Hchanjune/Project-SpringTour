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

<title>Insert title here</title>
<script>
	$(document).ready(function(){

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
			<div class="col-2 navbar-left d-none d-md-block">
				<tag:managementSideMenu current="userList"/>
			</div>
			<!-- Main -->
			<div class="col-10">
				<h3>회원 목록</h3>
				<table class="table board_list">
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>생년월일</th>
							<th>이메일</th>
							<th>회원 등급</th>
							<th>인증상태</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach items="${userList }" var="user">
							<tr>
								<td>${user.id }</td>
								<td>
									<form action="${appRoot }/user/myPage" id="userListLinkForm" method="get">
										<input type="hidden" name="userId" value="${user.id }" />
										<input class="btn" type="submit" value="${user.name }" />
									</form>
								</td>
								<td>${user.birthDate }</td>
								<td>${user.email }</td>
								<td>${user.grade }</td>
								<td>${user.authKey }</td>
							</tr>
						</c:forEach>
					</tbody>
				
				</table>
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