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
<title>${message.sender }님의 메시지</title>
</head>
<body>
	<div class="container">
		<h3>${message.sender }님이 보낸 메시지</h3>
		<br />
			<label for="receivedMessageTitle">제목</label>
			<input class="form-control" type="text" name="title" value="${message.title }" id="receivedMessageTitle" readonly/>
			<label for="receivedMessageBody">내용</label>
			<textarea class="form-control" name="body" cols="30" rows="10" id="receivedMessageBody" readonly>${message.body }</textarea>
		<div>
			<form action="${appRoot }/user/replyMessage" id="replyMessageForm" method="post">
				<input type="hidden" name="sender" value="${message.sender }" />
				<button form="replyMessageForm" type="submit">답장쓰기</button>
			</form>
		</div>
	</div>
</body>
</html>