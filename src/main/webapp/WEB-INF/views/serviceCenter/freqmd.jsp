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

<script>	

	$(document).ready(function() {
		$("#edit-buttonFreq").click(function() {
			$("#input2").removeAttr("readonly");
			$("#textarea2").removeAttr("readonly");
			$("#modify-submit2").removeClass("d-none");
			$("#delete-submit2").removeClass("d-none");
			/* $("#addFileInputContainer1").removeClass("d-none");
			$(".removeFileCheckbox").removeClass("d-none"); */
			
		});
		
		$("#delete-submit2").click(function(e) {
			e.preventDefault();
			
			if (confirm("삭제하시겠습니까?")) {
				let freqModifyForm = $("#freqModifyForm");
				let actionAttr = "${appRoot}/serviceCenter/freqRemove";
				freqModifyForm.attr("action", actionAttr);
				
				freqModifyForm.submit();
			}
			
		});
	
	});

</script>

<title>Insert title here</title>
</head>
<body>

	<tag:login/>
	<tag:navBar/>



	<div class="container board_view">
		<div class="row">
			<div class="col">
				<c:url value="/serviceCenter/freqModify" var="freqModifyLink" />

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form id="freqModifyForm" action="${freqModifyLink }" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="freqIndexId"
						value="${freqPost.freqIndexId }" />

					<div class="board_view_title">
						<!-- <label class="form-label" for="input1">제목</label> -->
						<input class="form-control" type="text" name="title"
							value="${freqPost.title }" id="input2" readonly />
					</div>

					<div class="board_view_date">
						<!-- <label for="input2" class="form-label">작성일시</label>-->
						<input class="form-control mb-3" type="datetime-local"
							value="${freqPost.inserted }" readonly />
					</div>

					<div class="board_view_content">
						<!-- <label class="form-label" for="textarea1">본문</label>-->

						<textarea class="form-control" name="body" id="textarea2"
							cols="30" rows="10" readonly>${freqPost.body }</textarea>
					</div>



					<button form="freqModifyForm" id="modify-submit2"
						class="btn btn-secondary d-none">수정</button>

					<button id="delete-submit2" class="btn btn-danger d-none">삭제</button>


				</form>

				<div class="container_fluid board_view_bottom">
					<div class="row">
						<div class="col">
							<div class="mt-3">
								<form action="${appRoot }/serviceCenter/freq" method="post">
									<button class="btn btn-primary">목록보기</button>
								</form>
							</div>
						</div>
						<button id="edit-buttonFreq" class="btn btn-secondary">
							<a href="${appRoot }/serviceCenter/freqmd">
							<i class="fa-solid fa-user-pen"></i>
							</a>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>