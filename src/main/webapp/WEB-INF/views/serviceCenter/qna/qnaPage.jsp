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
<link rel="stylesheet" type="text/css" href="../../resources/css/style.css">
<script>

	$(document).ready(function() {
		$("#edit-buttonQna").click(function() {
			$("#qnaInput").removeAttr("readonly");
			$("#qnaTextarea").removeAttr("readonly");
			$("#modify-submit2").removeClass("d-none");
			$("#delete-submit2").removeClass("d-none");
			/* $("#addFileInputContainer1").removeClass("d-none");
			$(".removeFileCheckbox").removeClass("d-none"); */

		});

		$("#delete-submit2").click(function(e) {
			e.preventDefault();

			if (confirm("삭제하시겠습니까?")) {
				let qnaModifyForm = $("#qnaModifyForm");
				let actionAttr = "${appRoot}/serviceCenter/qna/remove";
				qnaModifyForm.attr("action", actionAttr);

				qnaModifyForm.submit();
			}

		});
	});	
		
	
// qnaPage reply ------------------------------------------------------------------------------------------
		
	 	// 페이지 로딩 후 reply List 가져오는 ajax 요청
		const listReply = function(){
		
			const data = {replyIndexId : ${qnaPost.indexId }};
			$.ajax({
				url : "${appRoot}/qnaReply/qnaList",
				type : "get",
				data : data,
				success : function(list){
					//console.log("댓글 가져오기 성공");
					console.log(list);
					
					const replyListElement = $("#replyQnaList");
					replyListElement.empty();
					
					// 댓글 개수 표시
					$("#numOfQnaReply").text(list.length);
					
					
					
					for (let i=0; i < list.length; i++){
						const replyElement = $("<li class='list-group-item' />");
						replyElement.html(`
								
									<div id="replyContainer\${list[i].replyIndexId }" >
										<div class="fw-bold">
												<i class="fa-solid fa-comment"></i> 
												\${list[i].prettyInserted}
												
												<span id="modifyButton\${list[i].replyIndexId }">
												</span>
											</div>
								
									 		<span id="replyQnaContent\${list[i].replyIndexId}"></span>
										 	
								
										</div>
										
										<div id="replyEditForm\${list[i].replyIndexId }" style="display: none;">
											<form action="${appRoot }/qnaReply/modify" method="post">
												<div class="input-group">
													<!-- 작성자 : ${board.writerNickName }
													<input type="hidden" name="writerId" value="${qnaReply.writerId }" />--> 
													<input type="hidden" name="replyIndexId" value="\${list[i].replyIndexId }" />
													<input class="form-control" value="\${list[i].qnaContent }" 
													       type="text" name="qnaContent" required /> 
													<button data-reply-id="\${list[i].replyIndexId}" 
													        class="reply-QnaModify-submit btn btn-outline-secondary">
														<i class="fa-solid fa-comment-dots"></i>
													</button>
												</div>
											</form>
										</div>			
								
								`); 
						replyListElement.append(replyElement);
						
						
						
						
						$("#replyQnaContent" + list[i].replyIndexId).text(list[i].qnaContent);
						// own이 true 일 때만 수정, 삭제 버튼 보이기
						if (list[i].own){
							$("#modifyButton" + list[i].replyIndexId).html(`
										
								<span class="reply-edit-toggle-button badge bg-info text-dark" 
								             id="replyEditToggleButtonQna\${list[i].replyIndexId }" 
								             data-reply-id="\${list[i].replyIndexId }" >
							 			<i class="fa-solid fa-pen-to-square"></i>
						 		</span>
							 	<span class="reply-delete-button badge bg-danger" 
							 	            data-reply-id="\${list[i].replyIndexId }">
							 		<i class="fa-solid fa-trash-can"></i>
							 	</span>
									
									`);
					    	}
						
						
					  } 
				
					  $(".reply-QnaModify-submit").click(function(e){
						 e.preventDefault();
						 
						 const replyIndexId = $(this).attr("data-reply-replyIndexId");
						 const formElem = $("#replyEditForm" + replyIndexId).find("form");
						 // const data = formElem.serialize(); put방식은 controller에서 못 받음.
						 const data = {
								<!--writerId : formElem.find("[name=writerId]").val(), -->
								replyIndexId : formElem.find("[name=replyIndexId]").val(),
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
								$("#replyQnaMessage").show().text(data).fadeOut(3000);
								// 댓글 refresh
								listReply();
							},
							error : function(){
								$("#replyQnaMessage").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
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
							const replyId = $(this).attr("data-reply-replyIndexId");
							const displayDivId = "#replyContainer" + replyId;
							const editFormId = "#replyEditForm" + replyId;
							
							console.log(replyId);
							console.log(displayDivId);
							console.log(editFormId);
							
							$(displayDivId).hide();
							$(editFormId).show();
						});
					
					
					
						// 삭제 버튼 클릭 이벤트 메소드 등록
						// reply-delete-button 클릭시
						$(".reply-delete-button").click(function() {
							const replyId = $(this).attr("data-reply-replyIndexId");
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
										$("#replyQnaMessage").show().text(data).fadeOut(3000);
									},
									error : function(){
										$("#replyQnaMessage").show().text("댓글을 삭제할 수 없습니다.").fadeout(3000);
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
		
		// ---------------------------------------------------------------------------------------------
		
		// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
		
	
		$("#addReplyQnaButton").click(function(e){
			e.preventDefault();
				
			const data = $("#insertReplyQnaForm").serialize();
			
			$.ajax({
				url :"${appRoot }/qnaReply/qna/qnaInsert",
				type :"post",
				data : data,
				success : function(data){
			
					// 새 댓글 등록되었다는 메세지 출력
					$("#replyQnaMessage").show().text(data).fadeOut(3000);		
					
					// text input 초기화
					$("#insertReplyContentInput").val("");
					
					// 모든 댓글 가져오는 ajax 요청
					//댓글 가져오는 함수 발생
					//	listReply();
					// console.log(data);
				},
				error : function(){
					$("#replyQnaMessage").show().text("댓글을 작성할  수 없습니다.").fadeout(3000);
					console.log("문제 발생");
				},
				complete : function(){
					console.log("요청완료");
				}
			});
		}); 
	 });  
	
		


</script>


<title>Insert title here</title>
</head>
<body>

	<tag:login/>
	<tag:navBar/>

	<c:url value="/serviceCenter/qna/modify" var="qnaModifyLink" />
	<div class="container board_view" style="padding-bottom: 25px;">
		<div class="row">
			<div class="col">
				
				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>
				<form id="qnaModifyForm" action="${qnaModifyLink }" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="indexId" value="${qnaPost.indexId }" />

					<div class="board_view_title">
						<!-- <label class="form-label" for="input1">제목</label> -->
						<input class="form-control" type="text" name="title"
							value="${qnaPost.title }" id="qnaInput" readonly />
					</div>

					<div class="board_view_date">
						<!-- <label for="input2" class="form-label">작성일시</label> -->
						<input class="form-control mb-3" type="datetime-local"
							value="${qnaPost.inserted }" readonly />
					</div>
					
					<div class="board_view_content">
						<!-- <label class="form-label" for="textarea1">본문</label> -->
						<textarea class="form-control" name="body" id="qnaTextarea"
							cols="30" rows="10" readonly>${qnaPost.body }</textarea>
					</div>


					<button form="qnaModifyForm" id="modify-submit2"
						class="btn btn-secondary d-none">수정</button>

					<button id="delete-submit2" class="btn btn-danger d-none">삭제</button>

				</form>
				<div class="container_fluid board_view_bottom">
					<div class="row">
						<div class="col">
							<div class="mt-3">
								<form action="${appRoot }/serviceCenter/qnaList" method="get">
									<button class="btn btn-primary">목록보기</button>
								</form>
							</div>
						</div>
						<div class="col">
							<div class="txt-right">
								<sec:authorize access="hasRole('ADMIN')">
									<sec:authentication property="principal" var="principal" />
									<c:if test="${principal.username == qnaPost.writer }">
										<button id="edit-buttonQna" class="btn btn-secondary">
											<i class="fa-solid fa-user-pen"></i>
										</button>
									</c:if>
								</sec:authorize>
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>



	<%-- 댓글 추가 form -------------------------------------------------------------------------- --%>
	<!-- .container.mt-3>.row>.col>form -->

	<div class="container">
		<div class="row">
			<div class="col">
				<form action="${appRoot }/serviceCenter/qna/qnaPage" id="insertReplyQnaForm">
					<div class="input-group">
					<h3 style="color: blue;">답변</h3>

					<%-- <form action="${appRoot }/serviceCenter/qna/insert" id="insertReplyForm1">  --%>

					<input type="hidden" name="replyIndexId"
						value="${qnaPost.indexId }" />
					<input id="insertReplyContentInput" class="form-control"
						type="text" name="qnaContent" required />


					<sec:authorize access="hasRole('ADMIN')">
						<sec:authentication property="principal" var="principal" />
						<%-- <c:if test="${principal.username == qnaPost.writer }"> --%>
						<button id="addReplyQnaButton" class="btn btn-outline-secondary">
							<i class="fa-solid fa-comment-dots"></i>
						</button>
						<%-- </c:if> --%>
					</sec:authorize>
			<!-- </form> -->
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div id="replyQnaMessage" class="alert alert-primary"
			style="display: none;"></div>
	</div>


	<%-- 댓글 목록 --%>

	<!-- .container.mt-3>.row>.col -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<!-- <h3>댓글 <span id="numOfQnaReply"></span> 개</h3>
				<ul id="replyQnaList" class="list-group">

				</ul> -->
			</div>
		</div>
	</div>

	<%-- reply 삭제 form --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/qnaReply/delete"
			method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="qnaIndexId" value="${qnaPost.indexId }" />
		</form>
	</div>


</body>
</html>