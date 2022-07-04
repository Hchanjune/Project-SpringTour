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
<title>SpringTour - 1:1문의 작성</title>
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
				<tag:userSideMenu current="writePrivateEnquiry"/>
			</div>
			<!-- Main -->
			<div class="col-10">
				<h3>1:1 문의 등록</h3>
				<p>문의해 주신 내용은 빠르게 확인하여 답변드리겠습니다!</p>
				<br />
				<form action="${appRoot }/user/insertPrivateEnquiry" class="form-control" method="post">
					<input type="hidden" name="clientName" value="${principal.username }" />
					<label for="">제목</label>
					<input type="text" class="form-control" name="title" placeholder="제목을 입력해주세요." required/>
					
					<label for="">질문 종류</label>
					<select id="userInfoUserGrade" name="category" class="form-control" size="1">
						<c:forEach items="${categoryList }" var="category">
							<option <c:if test="${category.categoryName eq '질문을 선택하여 주세요'}">selected</c:if> value="${category.categoryName }">${category.categoryName }</option>
						</c:forEach>
					</select>
					
					<label for="">본문</label>
					<textarea class="form-control" name="body" cols="30" rows="10" placeholder="이곳에 질문을 입력해 주세요" required></textarea>
					<div class="text-center">
						<input class="btn btn-primary justify-content-center" type="submit" class="form-control" value="1:1 질문 등록하기" />
					</div>
				</form>
				
				
				
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