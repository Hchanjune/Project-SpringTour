<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


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
	
	
	<tag:login/>
	<tag:navBar/>
	

	<div class="container">
		<div class="row">
			<div class="col-4">
				<nav class="nav flex-column">
				
							<a class="nav-link disabled">고객센터</a>
							<a class="nav-link" href="${appRoot }/serviceCenter/notice">공지사항</a>
							<a class="nav-link" href="${appRoot }/serviceCenter/qua/qnaList">묻고답하기</a>
							<a class="nav-link" href="${appRoot }/serviceCenter/freq">자주묻는질문</a>
			
				</nav>
			</div>
			
			<div class="col-8">
				<h1>묻고답하기</h1> <br />

				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>나라</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>답변</th>
						</tr>
					</thead>
					<c:forEach items="${qnaPost }" var="list">
						<tr>
							<td>${list.indexId }</td>
							<td>${list.country }</td>
							<td>

								<c:url value="${appRoot }/qna/get" var="link">
									<c:param name="indexId" value="${list.indexId }"></c:param>
								</c:url>
								<a href="${link }"> ${list.title } </a>

							</td>
							<td>${list.userId }</td>
							<td>${list.inserted }</td>
							<td>${list.answer }</td>
						</tr>
					</c:forEach>
				</table>


				<div class="col justify-content-right" align="right">
					<button>
						<a href="${appRoot}/qna/insert">문의하기</a>
					</button>
				</div>

			</div>
			
		</div>	
	</div>

	
	
</body>
</html>