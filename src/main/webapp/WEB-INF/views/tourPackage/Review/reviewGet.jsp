<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../../resources/css/style.css">	
	
<script>
$(document).ready(function() {
	$("#edit-button1").click(function() {
		$("#input1").removeAttr("readonly");
		$("#textarea1").removeAttr("readonly");
		$("#modify-submit1").removeClass("d-none");
		$("#delete-submit1").removeClass("d-none");
	});
	
	$("#delete-submit1").click(function(e) {
		e.preventDefault();
		
		if (confirm("삭제하시겠습니까?")) {
			let form1 = $("#form1");
			let actionAttr = "${appRoot}/tourPackage/Review/remove";
			form1.attr("action", actionAttr);				
			form1.submit();
		}			
	});
	
	// 페이지 로딩 후 reply list 가져오는 ajax 요청
	const listReply = function(){
		
		const data = {reviewId : ${review.indexId}};
		$.ajax({
			url : "${appRoot}/reviewReply/list",
			type : "get",
			data : data,
			success : function(list){
				console.log(list);
				
				const replyListElement = $("#replyList1");
				replyListElement.empty();
				
				$("#numOfReply1").text(list.length);
				for(let i = 0; i < list.length; i++) {
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`				
							<div id="replyDisplayContainer\${list[i].replyId }">
								<div class="fw-bold">								
									<span class="badge bg-light text-dark">
									<i class="fa-solid fa-comment"></i> 
									\${list[i].writerName}
								</span>
									 
									<i class="fa-solid fa-user"></i>
									\${list[i].writerGrade}
									
									<span id="modifyButtonWrapper\${list[i].replyId }">
									</span>							 	
											
									
																				
								</div>
							 	<span id="replyContent\${list[i].replyId}"</span>							 	
							</div>
							
							<div id="replyEditFormContainer\${list[i].replyId }" 
								style="display: none;">
								<form action="${appRoot }/reviewReply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="reviewId" value="${review.indexId }" />
										<input type="hidden" name="replyId" value="\${list[i].replyId }" />
										<input class="form-control" value="\${list[i].content }" type="text" name="content" required /> 
										<button data-reply-id="\${list[i].replyId}" 
											class="reply-modify-submit btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
					`);
										
					replyListElement.append(replyElement);	
					$("#replyContent"+list[i].replyId).text(list[i].content);
										
					//own이 true일 때만 수정,삭제 버튼 보이기
					if(list[i].own){
						
						$("#modifyButtonWrapper" + list[i].replyId).html(`
							 	<span class="reply-edit-toggle-button badge bg-info text-dark" 
							 		id="replyEditToggleButton\${list[i].replyId }" 
							 		data-reply-id="\${list[i].replyId }">
							 		<i class="fa-solid fa-pen-to-square"></i>
						 		</span>
							 	<span class="reply-delete-button badge bg-danger" 
							 		data-reply-id="\${list[i].replyId }">
							 		<i class="fa-solid fa-trash-can"></i>
							 	</span>					
						`);
					}
					
				} //end of for
					
				$(".reply-modify-submit").click(function (e){
					e.preventDefault();
					
					const id = $(this).attr("data-reply-id");
					const formElem = $("#replyEditFormContainer" + id).find("form");
					//const data = formElem.serialize();
					
					const data = {
							reviewId : formElem.find("[name=reviewId]").val(),
							replyId : formElem.find("[name=replyId]").val(),
							content : formElem.find("[name=content]").val()
					};
					
					$.ajax({
						url : "${appRoot}/reviewReply/modify",
						type : "put",
						data : JSON.stringify(data),
						contentType : "application/json",
						success : function(data){
							console.log("수정 성공");
							$("#replyMessage1").show().text(data).fadeOut(3000);
							
							// 댓글 refresh
							listReply();
						},
						error : function(){
							console.log("수정 실패");
						},
						complete : function(){
							console.log("수정 종료");
						}
					})
				});
				// reply-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고,
				// 수정 form 보여주기
				$(".reply-edit-toggle-button").click(function() {
					console.log("버튼클릭");
					const replyId = $(this).attr("data-reply-id");
					const displayDivId = "#replyDisplayContainer" + replyId;
					const editFormId = "#replyEditFormContainer" + replyId;
					
					console.log(replyId);
					console.log(displayDivId);
					console.log(editFormId);
					
					$(displayDivId).hide();
					$(editFormId).show();
				});
				
				
				// 삭제 버튼 클릭 이벤트 메소드 등록
				// reply-delete-button 클릭시
				$(".reply-delete-button").click(function() {
					const replyId = $(this).attr("data-reply-id");
					const message = "댓글을 삭제하시겠습니까?";
					
					if (confirm(message)) {
					//	$("#replyDeleteInput1").val(replyId);
					//	$("#replyDeleteForm1").submit();
					
						$.ajax({
							url : "${appRoot}/reviewReply/delete/"+replyId,
							type : "delete",
							success : function(data){
								console.log(replyId + "댓글 삭제됨");
								// 댓글 list refresh
								listReply();
								//메세지 출력
								$("#replyMessage1").show().text(data).fadeOut(3000);
							},
							error : function(){
								$("#replyMessage1").show().text("댓글을 삭제할 수 없습니다");
								console.log(replyId + "댓글 삭제중 문제가 발생");
							},
							complete : function(){
								console.log(replyId + "댓글 삭제됨");
							}
						});
					}
				});
			},
			error : function() {
				console.log("댓글 가져오기 실패");
			}
		});		
	}
	
	//댓글 가져오는 함수
	listReply();
	// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
	$("#addReplySubmitButton1").click(function(e){
		
		e.preventDefault();
		const data = $("#insertReplyForm1").serialize();
		
		$.ajax({
			url : "${appRoot }/reviewReply/insert",
			type : "post",
			data : data,
			success : function(data){
				$("#replyMessage1").show().text(data).fadeOut(3000);
				
				$("#insertReplyContentInput1").val("");
				
				listReply();
				//console.log(data);
			},
			error : function() {
				console.log("문제 발생");
			},
			complete : function() {
				console.log("요청 완료");
			}
		});
		
	});
	
});
	
	
	
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container-fluid">

		<!-- Header -->
		<div class="row">
			<div class="col-12">
				<tag:login />
				<tag:navBar />
			</div>
		</div>

		<!-- Body -->
		<div class="row">

			<!-- Left -->
			<div class="col-1"></div>


			<!-- Main -->
			<div class="col-11">
				<div class="container">
					<div class="row">
						<div class="col">
							<h1>
								리뷰
								<sec:authorize access="isAuthenticated()">
									<sec:authentication property="principal" var="principal" />
									<c:if test="${principal.username == review.writer}">
									<button id="edit-button1" class="btn btn-secondary">
										<i class="fa-solid fa-pen-to-square"></i>
									</button>
									</c:if>
								</sec:authorize>

							</h1>
							<c:if test="${not empty message }">
								<div class="alert alert-primary">${message }</div>
							</c:if>

							<form id="form1" action="${appRoot }/tourPackage/Review/modify"
								method="post" enctype="multipart/form-data">
								<input type="hidden" name="indexId" value="${review.indexId }" />

								<div>
									<label class="form-label" for="input1">제목</label> <input
										class="form-control" type="text" name="title" required
										id="input1" value="${review.title }" readonly />
								</div>

								<div>
									<label class="form-label" for="textarea1">본문</label>
									<textarea class="form-control" name="body" id="textarea1"
										cols="30" rows="10" readonly>${review.body }</textarea>
								</div>

								<div>
									<label for="input3" class="form-label">작성자</label> <input
										id="input3" class="form-control" type="text"
										value="${review.writer}" readonly />
								</div>

								<div>
									<label for="input2" class="form-label">작성일시</label> <input
										class="form-control" type="datetime-local"
										value="${review.inserted }" readonly />
								</div>

								<div>
									<label for="input3" class="form-label">패키지명</label> <input
										id="input 3" class="form-control" type="text"
										value="${review.packageName}" readonly />
								</div>

								<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
								<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
							</form>
						</div>
					</div>
				</div>

				<%-- 댓글 추가 form --%>
				<!-- .container.mt-3>.row>.col>form -->
				<div class="container mt-3">
					<div class="row">
						<div class="col">
							<form id="insertReplyForm1">
								<div class="input-group">
									<input type="hidden" name="reviewId" value="${review.indexId }" /> <input
										id="insertReplyContentInput1" class="form-control" type="text"
										name="content" required />
									<button id="addReplySubmitButton1"
										class="btn btn-outline-secondary">
										<i class="fa-solid fa-comment-dots"></i>
									</button>
								</div>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="alert alert-primary" style="display: none;"
							id="replyMessage1"></div>
					</div>
				</div>

				<%-- 댓글 목록 --%>

				<!-- .container.mt-3>.row>.col -->
				<div class="container mt-3">
					<div class="row">
						<div class="col">
							<h3>
								댓글 <span id="numOfReply1"></span> 개
							</h3>
							<ul id="replyList1" class="list-group">
							</ul>
						</div>
					</div>
				</div>

				<%-- reply 삭제 form --%>
				<div class="d-none">
					<form id="replyDeleteForm1" action="${appRoot }/reviewReply/delete"
						method="post">
						<input id="replyDeleteInput1" type="text" name="indexId" /> <input
							type="text" name="reviewId" value="${review.indexId }" />
					</form>
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