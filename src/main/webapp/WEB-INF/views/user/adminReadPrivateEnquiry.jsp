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
<title>SpringTour - ${privateEnquiry.title }</title>
<script>
	$(document).ready(function(){
		$("#replyPrivateEnquiryButton").click(function(){
			$(this).hide();
			$("#replyPrivateEnquiryParagraph").show();
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
			<div class="col-2">
				<tag:managementSideMenu/>
			</div>
			
			
			<!-- Main -->
			<div class="col-10">
				<form action="${appRoot }/user/replyPrivateEnquiry" class="form-control" id="replyPrivateEnquiryForm" method="post">
					<h3>제목 : ${privateEnquiry.title }</h3>
					<c:if test="${privateEnquiry.replyInfo == true }">
						<p>답변이 완료된 문의 입니다.</p>
					</c:if>
					<p style="display : none;" id="replyPrivateEnquiryParagraph" class="alert alert-primary">답변을 등록중입니다...</p>
					<input type="hidden" name="indexId" value="${privateEnquiry.indexId }" />
					<input type="hidden" name="clientName" value="${privateEnquiry.clientName }" />
					<label for="">카테고리</label>
					<input type="text" class="form-control" value="${privateEnquiry.category }" readonly/>
					<label for="">본문</label>
					<textarea class="form-control" cols="30" rows="10" readonly>${privateEnquiry.body }</textarea>
					<label for="">답변</label>
					<textarea name="reply" class="form-control" cols="30" rows="10" placeholder="답변을 입력해 주세요."<c:if test="${privateEnquiry.replyInfo == true }">readonly</c:if>><c:if test="${privateEnquiry.replyInfo == true }">${privateEnquiry.reply }</c:if></textarea>
				</form>
				<div class="row">
					<div style="text-align:center;">
						<form action="${appRoot }/user/adminPrivateEnquiryList" method="get">
							<button type="submit">목록 보기</button>
							<c:if test="${privateEnquiry.replyInfo == false }">
								<button form="replyPrivateEnquiryForm" type="submit" id="replyPrivateEnquiryButton">답변 등록</button>
							</c:if>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- Footer -->
		<div class="row">
			<div class="col-12">
			
			</div>
		</div>
		
	</div>
</body>
</html>