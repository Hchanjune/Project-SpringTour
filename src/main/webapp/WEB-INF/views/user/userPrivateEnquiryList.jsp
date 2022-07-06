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

<title>SpringTour - 나의 1:1 문의</title>
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
				<tag:userSideMenu current="userPrivateEnquiryList"/>
			</div>
			
			
			<!-- Main -->
			<div class="col-10">
				<h3>나의 문의 목록</h3>
				<c:if test="${not empty resultMessage}">
					<div class="alert alert-primary">
						${resultMessage }
					</div>
				</c:if>
				<table class="table board_list">
					<thead>
						<tr>
							<td>문의번호</td>
							<td>제목</td>
							<td>카테고리</td>
							<td>문의시간</td>
							<td>답변여부</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${enquiryList }" var="enquiry">
							<tr>
								<td>${enquiry.indexId }</td>
								<td>
									<c:url value="/user/userReadPrivateEnquiry" var="enquirylink">
										<c:param name="indexId" value="${enquiry.indexId }"></c:param>
									</c:url>
									<a href="${enquirylink }">${enquiry.title }</a>
								</td>
								<td>${enquiry.category }</td>
								<td>${enquiry.inserted }</td>
								<c:choose>
					 				<c:when test="${enquiry.replyInfo == false}">
					 					<td style="color:green;">확인 중</td>
					 				</c:when>
					 				<c:when test="${enquiry.replyInfo == true}">
					 					<td style="color:blue;">답변 완료</td>
					 				</c:when>
					 			</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		
		<!-- Footer -->
		<div class="row">
			<div class="col-12">
				<tag:footer/>
			</div>
		</div>
		
	</div>
</body>
</html>