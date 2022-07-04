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
<link rel="stylesheet" type="text/css" href="../../resources/css/style.css">

<title>Insert title here</title>
</head>
<body>
	<sec:authentication property="principal" var="principal" />
	<tag:login/>
	<tag:navBar/>
				

	<div class="container">
		<div class="row">
			<div class="col">

				<h1>글 작성</h1>
				
				<form action="${appRoot }/serviceCenter/qna/insert" method="post" enctype="multipart/form-data">
					<input type="hidden" name="writer" value="principal.username" />
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" type="text" name="title" required  />
					</div>
					<div>
						<label for="insertQnaPackageName">패키지 명</label>
						<select class="form-select" name="packageName" id="insertQnaPackageName">
							<option selected>패키지 선택</option>
							<c:forEach items="${tourList }" var="tourPackage">
								<option><c:out value="${tourPackage.packageName }"></c:out></option>
							</c:forEach>
						</select>
					</div>
					
					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" name="body"  cols="30" rows="10"></textarea>
					</div>
					
					<!-- <div>
						<label for="fileInput1" class="form-label">
							파일
						</label>
						<input class="form-control mb-3" multiple="multiple" type="file" name="file" accept="image/*"/>
					</div> -->
					
					<button class="btn btn-primary">작성</button>
				
				</form>
			</div>
		</div>
	</div>
	

</body>
</html>