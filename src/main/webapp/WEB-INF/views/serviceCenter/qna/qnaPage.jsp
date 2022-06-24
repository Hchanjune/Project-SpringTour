<%@page import="java.net.URLEncoder"%>
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

<script>

	$(document).ready(function() {
		$("#edit-buttonNotice").click(function() {
			$("#input1").removeAttr("readonly");
			$("#textarea1").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
			$("#addFileInputContainer1").removeClass("d-none");
			$(".removeFileCheckbox").removeClass("d-none");

		});

		$("#delete-submit1").click(function(e) {
			e.preventDefault();

			if (confirm("삭제하시겠습니까?")) {
				let qnaModifyForm = $("#qnaModifyForm");
				let actionAttr = "${appRoot}/serviceCenter/qna/remove";
				qnaModifyForm.attr("action", actionAttr);

				qnaModifyForm.submit();
			}

		});
		
		
		
		
		// 페이지 로딩 후 reply List 가져오는 ajax 요청
		const listReply = function(){
		
			const data = {qnaIndexId : ${qnaReply.qnaIndexId}};
			$.ajax({
				url : "${appRoot}/qnaReply/qnaList",
				type : "get",
				data : data,
				success : function(list){
					//console.log("댓글 가져오기 성공");
					console.log(list);
					
					const replyListElement = $("#replyList1");
					replyListElement.empty();
					
					// 댓글 개수 표시
					$("#numOfReply1").text(list.length);
					
					
					
					for (let i=0; i < list.length; i++){
						const replyElement = $("<li class='list-group-item' />");
						replyElement.html(`
								
									<div id="replyDisplayContainer\${list[i].qnaIndexId }" >
										<div class="fw-bold">
												<i class="fa-solid fa-comment"></i> 
												\${list[i].prettyInserted}
												
												<span id="modifyButtonWrapper\${list[i].qnaIndexId }">
												</span>
												
											
											</div>
								
									 		<span id="replyContent\${list[i].qnaIndexId}"></span>
										 	
								
										</div>
										
										<div id="replyEditFormContainer\${list[i].qnaIndexId }" style="display: none;">
											<form action="${appRoot }/qnaReply/modify" method="post">
												<div class="input-group">
													작성자 : ${board.writerNickName }
													<input type="hidden" name="writerId" value="${qnaReply.writerId }" />
													<input type="hidden" name="qnaIndexId" value="\${list[i].qnaIndexId }" />
													<input class="form-control" value="\${list[i].qnaContent }" 
													       type="text" name="qnaContent" required /> 
													<button data-reply-id="\${list[i].qnaIndexId}" 
													        class="reply-modify-submit btn btn-outline-secondary">
														<i class="fa-solid fa-comment-dots"></i>
													</button>
													
												</div>
											</form>
										</div>			
								
								`);
						replyListElement.append(replyElement);
						$("#replyContent" + list[i].id).text(list[i].content);
						
						// own이 true 일 때만 수정, 삭제 버튼 보이기
						if (list[i].own){
							$("#modifyButtonWrapper" + list[i].qnaIndexId).html(`
										
								<span class="reply-edit-toggle-button badge bg-info text-dark" 
								             id="replyEditToggleButton\${list[i].qnaIndexId }" 
								             data-reply-id="\${list[i].qnaIndexId }" >
							 			<i class="fa-solid fa-pen-to-square"></i>
						 		</span>
							 	<span class="reply-delete-button badge bg-danger" 
							 	            data-reply-id="\${list[i].qnaIndexId }">
							 		<i class="fa-solid fa-trash-can"></i>
							 	</span>
									
									`);
					    	}
						
						
					  } // end of for문
					  
					  $(".reply-modify-submit").click(function(e){
						 e.preventDefault();
						 
						 const qnaIndexId = $(this).attr("data-reply-qnaIndexId");
						 const formElem = $("#replyEditFormContainer" + qnaIndexId).find("form");
						 // const data = formElem.serialize(); put방식은 controller에서 못 받음.
						 const data = {
								writerId : formElem.find("[name=writerId]").val(),
								qnaIndexId : formElem.find("[name=qnaIndexId]").val(),
								qnaContent : formElem.find("[name=qnaContent]").val()
						 };
						 
						 
						 $.ajax({
							url :"${appRoot}/qnaReply/modify",
							type :"put",
							data : JSON.stringify(data),
							contentType : "application/json",
							success : function(data){
								console.log(data);
								
								// 메세지 보여주기
								$("#replyMessage1").show().text(data).fadeOut(3000);
								// 댓글 refresh
								listReply();
							},
							error : function(){
								$("#replyMessage1").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
								console.log("수정 실패");
							},
							complete : function(){
								console.log("수정 완료");
							}
						 });
					  });
					
						// reply-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고,
						// 수정 form 보여주기
						$(".reply-edit-toggle-button").click(function() {
							console.log("버튼클릭");
							const replyId = $(this).attr("data-reply-qnaIndexId");
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
							const replyId = $(this).attr("data-reply-qnaIndexId");
							const message = "댓글을 삭제하시겠습니까?";
							
							if (confirm(message)) {
								// $("#replyDeleteInput1").val(replyId);
								// $("#replyDeleteForm1").submit();
								
								$.ajax({
									url : "${appRoot}/qnaReply/delete/" + replyId,
									type : "delete",
									success : function(data){
										console.log(replyId + "댓글 삭제됨.");
										// 댓글 list refresh
										listReply();
										// 메세지 출력
										$("#replyMessage1").show().text(data).fadeOut(3000);
									},
									error : function(){
										$("#replyMessage1").show().text("댓글을 삭제할 수 없습니다.").fadeout(3000);
										console.log(replyId + "댓글 삭제 중 문제 발생됨.");	
									},
									complete : function(){
										console.log(replyId + "댓글 삭제 요청 끝.");	
									}
								});
							}
						});
						
				},
				error : function(){
					console.log("댓글 가져오기 실패");
				}
			});
		}
		
		//댓글 가져오는 함수 발생
		listReply();
		
		// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
		$("#addReplySubmitButton1").click(function(e){
			e.preventDefault();
			
			const data = $("#insertReplyForm1").serialize();
			
			$.ajax({
				url :"${appRoot }/qnaReply/insert",
				type :"post",
				data : data,
				success : function(data){
			
					// 새 댓글 등록되었다는 메세지 출력
					$("#replyMessage1").show().text(data).fadeOut(3000);		
					
					// text input 초기화
					$("#insertReplyContentInput1").val("");
					
					// 모든 댓글 가져오는 ajax 요청
					//댓글 가져오는 함수 발생
						listReply();
					// console.log(data);
				},
				error : function(){
					$("#replyMessage1").show().text("댓글을 작성할  수 없습니다.").fadeout(3000);
					console.log("문제 발생");
				},
				complete : function(){
					console.log("요청완료");
				}
			});
		});
	});

	});
</script>


<title>Insert title here</title>
</head>
<body>

	<tag:login/>
	<tag:navBar/>
	
	<c:url value="/serviceCenter/qna/modify" var="qnaModifyLink"/>
	<div class="container">
		<div class="row">
			<div class="col">
			
				<div class="mt-3">	
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal" var="principal" />
						<c:if test="${principal.username == qnaPost.writer }">
							<button id="edit-buttonNotice" class="btn btn-secondary">
								<i class="fa-solid fa-user-pen"></i>
							</button>
						</c:if>
					</sec:authorize>
				</div>
				

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form id="qnaModifyForm" action="${qnaModifyLink }" method="post" enctype="multipart/form-data">
					<input type="hidden" name="indexId" value="${qnaPost.indexId }" />
					
					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" type="text" name="title" value="${qnaPost.title }" id="input1"
							readonly />
					</div>

					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" name="body" id="textarea1"
							cols="30" rows="10" readonly>${qnaPost.body }</textarea>
					</div>
				 	

					<div>
						<label for="input2" class="form-label">작성일시</label>
						<input class="form-control mb-3" type="datetime-local"
							value="${qnaPost.inserted }" readonly />
					</div>

					<button form="qnaModifyForm" id="modify-submit1" class="btn btn-secondary d-none">수정</button>

					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>


				</form>


				<div class="mt-3">
					<form action="${appRoot }/serviceCenter/qnaList" method="get">
						<button class="btn btn-primary">목록보기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<br />
	
	
	
	
	
	
	
	<%-- 댓글 추가 form --%>
	<!-- .container.mt-3>.row>.col>form -->
	
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<h3 style="color:blue;">답변</h3>
				<form action="${appRoot }/serviceCenter/qna/qnaPage" id="insertReplyForm1">
					<div class="input-group">
						<input type="hidden" name="qnaIndexId" value="${qnaReply.qnaIndexId }" />
						<input id="insertReplyContentInput1" class="form-control" type="text" name="qnaContent" required /> 
						
						
						<sec:authorize access="hasRole('ADMIN')">
							<sec:authentication property="principal" var="principal" />
							<button id="addReplySubmitButton1" class="btn btn-outline-secondary">
								<i class="fa-solid fa-comment-dots"></i>
							</button>
						</sec:authorize>

						
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="alert alert-primary" style="display:none;" id="replyMessage1"></div>
		</div>
	</div>

	
	<%-- 댓글 목록 --%>
	
	<!-- .container.mt-3>.row>.col -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
			<!-- 	<h3>댓글 <span id="numOfReply1"></span> 개</h3> -->
				
				<ul id="replyList1" class="list-group">
					
					<%--
					<c:forEach items="${replyList }" var="reply">
						<li class="list-group-item">
							<div id="replyDisplayContainer${reply.id }">
								<div class="fw-bold">
									<i class="fa-solid fa-comment"></i> 
									${reply.prettyInserted}
								 	<span class="reply-edit-toggle-button badge bg-info text-dark" id="replyEditToggleButton${reply.id }" data-reply-id="${reply.id }" >
								 		<i class="fa-solid fa-pen-to-square"></i>
							 		</span>
								 	<span class="reply-delete-button badge bg-danger" data-reply-id="${reply.id }">
								 		<i class="fa-solid fa-trash-can"></i>
								 	</span>
								</div>
						 		<c:out value="${reply.content }" />
							 	
							 	
							</div>
							
							<div id="replyEditFormContainer${reply.id }" style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="${reply.id }" />
										<input class="form-control" value="${reply.content }" type="text" name="content" required /> 
										<button class="btn btn-outline-secondary"><i class="fa-solid fa-comment-dots"></i></button>
									</div>
								</form>
							</div>						 	
						</li>
					</c:forEach>
					 --%>
				</ul>
			</div>
		</div>
	</div>
	
	<%-- reply 삭제 form --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/qnaReply/delete" method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="qnaIndexId" value="${qnaReply.qnaIndexId }" />
		</form>
	</div>




















</body>
</html>