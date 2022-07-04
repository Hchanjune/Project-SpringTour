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

<link rel="stylesheet" type="text/css" href="../resources/css/style.css">

<title>Insert title here</title>
</head>
<body>

	<tag:login/>
	<tag:navBar/>
	

	<div class="container-fluid">
		<div class="row">
			<div class="col-2 navbar-left">
				<div class="navbar_menu">
					<h3>
						고객센터
						<a class="nav-link disabled"></a>
					</h3>
					<a class="nav-link left_nav_active" href="${appRoot }/serviceCenter/notice">공지사항</a>
					<a class="nav-link" href="${appRoot }/serviceCenter/qnaList">묻고답하기</a>
					<a class="nav-link" href="${appRoot }/serviceCenter/freq">자주묻는질문</a>
				</div>
			</div>

			<div class="col-10">
				<div class="contents">
					<h1>공지사항</h1>
					<div class="nav justify-content-end">

						<form action="${appRoot }/serviceCenter/notice" class="d-flex"
							method="get">
							<div class="input-group">
								<!-- select.form-select>option*3 -->
								<select name="type" id="" class="form-select"
									style="flex: 0 0 100px;">
									<option value="all"
										${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
									<option value="title" ${param.type=='title' ? 'selected' : '' }>제목</option>
									<option value="body" ${param.type=='body' ? 'selected' : '' }>본문</option>
								</select>

								<input type="search" class="form-control" name="keyword" />
								<button class="btn btn-outline-success">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</form>
					</div>
			

					<table class="table board_list" >
						<thead class="col justify-content-center">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>
						<c:forEach items="${page }" var="post">
							<tr class="col justify-content-center" >
								<td>${post.indexId }</td>
								<td class="title">
	
									<c:url value="/serviceCenter/notice/get" var="link">
										<c:param name="indexId" value="${post.indexId }"></c:param>
									</c:url>
									<a href="${link }"> ${post.title } </a>
	
								</td>
								<td>${post.prettyInserted }</td>
							</tr>
						</c:forEach>
	
					</table>



					<sec:authorize access="hasRole('ADMIN')">
						<sec:authentication property="principal" var="principal" />
						<div class="col justify-content-right" align="right">
							<button class="btn btn-primary" style="background: #E6FFFF;">
								<a href="${appRoot}/serviceCenter/notice/insert">글쓰기</a>
							</button>
						</div>
					</sec:authorize>

					<tag:noticepagination path="notice" />
				</div>

			</div>
		</div>
	</div>
	<!-- <footer style="height: 25px; background-color:black;"></footer>  -->
</body>
</html>