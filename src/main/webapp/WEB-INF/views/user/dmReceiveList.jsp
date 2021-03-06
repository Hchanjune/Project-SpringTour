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

<title>SpringTour : 받은 메세지 목록</title>
<script>
$(document).ready(function(){
	$(".messageTitle").click(function(e){
		e.preventDefault();
		let index = $(this).attr("data-index");
		let url = '${appRoot}/user/readMessage';
	    let form = $("#form"+index); 
	    let title = '받은메시지';
	    window.open(url, title, 'width=800, height=550, left=200, top=100, menubar=no, status=no, toolbar=no');
	
	    form.attr('action', url);
	    form.attr('target', title);
	    form.attr('method', 'post');
	
	    form.append('<input type="hidden" name="messageId" value="'+index+'">');
	    form.submit();
	    $("#readInfo"+index).text("읽음");
	});	
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
			<div class="col-2 navbar-left  d-none d-md-block">
				<tag:userSideMenu current="receivedMessage"/>
			</div>
			<!-- Main -->
			<div class="col-10">
				<div>
					<h3>받은 메시지 목록</h3>
					<div class="row">
						<tag:writeMessage/>
					</div>
					<table class="table board_list">
					 	<thead>
					 		<tr>
					 			<td>보낸사람</td>
					 			<td>제목</td>
					 			<td>받은시간</td>
					 			<td>기독여부</td>
					 		</tr>
					 	</thead>
					 	<tbody>
					 		<c:forEach items="${messageList }" var="messageList" varStatus="index">
					 			<tr>
					 				<td>${messageList.sender }</td>
					 				<td>
					 					<form id="form${messageList.indexId }"></form>
					 					<a href="#" class="messageTitle" data-index="${messageList.indexId }">${messageList.title }</a>
					 				</td>
					 				<td>${messageList.inserted }</td>
					 				<c:choose>
					 					<c:when test="${messageList.readInfo == 0}">
					 						<td id="readInfo${messageList.indexId }">읽지 않음</td>
					 					</c:when>
					 					<c:when test="${messageList.readInfo == 1}">
					 						<td>읽음</td>
					 					</c:when>
					 				</c:choose>
					 			</tr>
					 		</c:forEach>
					 	</tbody>
					</table>
				</div>
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