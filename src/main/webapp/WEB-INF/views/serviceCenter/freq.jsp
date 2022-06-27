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

/* 	// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
	$("#addReplySubmitButton1").click(function(e){
		e.preventDefault();
		
		const data = $("#insertReplyForm1").serialize();
		
		$.ajax({
			url :"${appRoot }/serviceCenter/freq",
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
	 */
</script>


<title>Insert title here</title>
</head>
<body>
	
	<tag:login/>
	<tag:navBar/>

	<br />
	<div class="containder-fluid" style="margin: 25px;">
		<div class="row">
			<div class="col-2 navbar-left">
				<div class="navbar_menu"
					style="background: #C2E2E8; text-align: center;">
					<h3
						style="background: #E6FFFF; text-align: center; padding-top: 10px;">
						고객센터
						<a class="nav-link disabled"></a>
					</h3>
					<a class="nav-link" href="${appRoot }/serviceCenter/notice">공지사항</a>
					<a class="nav-link" href="${appRoot }/serviceCenter/qnaList">묻고답하기</a>
					<a class="nav-link" href="${appRoot }/serviceCenter/freq">자주묻는질문</a>
					<br /><br /><br /><br><br /><br /><br /><br /><br /><br />
				</div>
			</div>


			<div class="col-10">
				<div class="">
					<h1>자주묻는질문</h1>
					<br />
					<div class="nav justify-content-end">

						<form action="${appRoot }/serviceCenter/freq" class="d-flex"
							method="post">
							<div class="input-group">
								<!-- select.form-select>option*3 -->
								<select name="type" id="" class="form-select"
									style="flex: 0 0 100px;">
									<option value="all"
										${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
									<%-- <option value="title" ${param.type=='title' ? 'selected' : '' }>제목</option> --%>
									<option value="body" ${param.type=='body' ? 'selected' : '' }>본문</option>
								</select>

								<input type="search" class="form-control" name="keyword" />
								<button class="btn btn-outline-success">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</form>
					</div>
				</div>
				
				<br />
				
				<table class="table mt-3">
					<thead>
						<form action="${appRoot }/serviceCenter/freq" class="d-flex" method="post">


							<ul class="nav nav-tabs" id="myTab" role="tablist">
								<li class="nav-item" role="presentation">
									<button class="nav-link active" id="home-tab"
										data-bs-toggle="tab" data-bs-target="#home-tab-pane"
										type="button" role="tab" aria-controls="home-tab-pane"
										aria-selected="true">전체</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
										data-bs-target="#profile-tab-pane" type="button" role="tab"
										aria-controls="profile-tab-pane" aria-selected="false">예약/결제</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="contact-tab" data-bs-toggle="tab"
										data-bs-target="#contact-tab-pane" type="button" role="tab"
										aria-controls="contact-tab-pane" aria-selected="false">상품문의</button>
								</li>
								<li class="nav-item" role="presentation">
									<button class="nav-link" id="disabled-tab" data-bs-toggle="tab"
										data-bs-target="#disabled-tab-pane" type="button" role="tab"
										aria-controls="disabled-tab-pane" aria-selected="false">기타</button>
								</li>
							</ul>


							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show active" id="home-tab-pane"
									role="tabpanel" aria-labelledby="home-tab" tabindex="0">
									<br />
									${freqList.title }

									<c:forEach items="${Page }" var="serviceCenter">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="input-group">
													<input type="hidden" name=freqList value="${freqList.indexId }" id="insertReplyContentInput1" class="form-control" />
													
													
													Q ${serviceCenter.body }

													

													<%-- <div class="input-group">
														<input type="hidden" name="boardId" value="${board.id }" />
														<input id="insertReplyContentInput1" class="form-control"
															type="text" name="content" required />
														<button id="addReplySubmitButton1"
															class="btn btn-outline-secondary">
															<i class="fa-solid fa-comment-dots"></i>
														</button>
													</div> --%>




												</div>
											</li>
										</ul>
									</c:forEach>
								</div>
							</div>
							
							
						</form>
					</thead>


					<%-- <br />
					<tbody>
						<tr>
							<td scope="row">Q ${freqList.body }</td>
						</tr>

					</tbody> --%>
				</table>
				



				<sec:authorize access="hasRole('ADMIN')">
					<sec:authentication property="principal" var="principal" />
					<div class="col justify-content-right" align="right">
						<button class="btn btn-primary" style="background: #E6FFFF;">
							<a href="${appRoot}/serviceCenter/freqInsert">글쓰기</a>
						</button>
					</div>
				</sec:authorize>
			</div>
		</div>
	</div>
	













</body>
</html>