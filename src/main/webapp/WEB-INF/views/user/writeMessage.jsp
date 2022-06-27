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
<title>메시지 보내기</title>
</head>
<body>
	<div class="container">
		<h3>메시지 보내기</h3>
		<br />
		<c:if test="${not empty resultMessage }">
			<p>${resultMessage }</p>
		</c:if>
		<form action="${appRoot }/user/sendMessage" id="sendMessageForm" method="post">
			<input type="hidden" name="sender" value="${principal.username }" />
			<label for="inputSendMessageReceiver">받는이</label>
			<input class="form-control" type="text" name="receiver" id="inputSendMessageReceiver" value="${receiver }" placeholder="받으시는 분 아이디를 입력하여 주세요."/>
			<label for="inputSendMessageTitle">제목</label>
			<input class="form-control" type="text" name="title" id="inputSendMessageTitle" placeholder="제목을 입력하세요."/>
			<label for="inputSendMessageBody">내용</label>
			<textarea class="form-control" name="body" id="inputSendMessageBody" cols="30" rows="10" placeholder="내용을 입력하세요."></textarea>
		</form>
		<div>
			<button form="sendMessageForm" type="submit">보내기</button>
		</div>
	</div>
</body>
</html>