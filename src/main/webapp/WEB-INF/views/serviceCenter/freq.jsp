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
		$(".freqContent").hide();
		//content 클래스를 가진 div를 표시/숨김(토글)
		$(".heading").click(function()
		{
		$(this).next(".freqContent").slideToggle(500);
		});
	});
	


</script>


<title>Insert title here</title>
</head>
<body>
	
	<tag:login/>
	<tag:navBar/>

	
	<div class="containder-fluid" >
		<div class="row">
			<div class="col-2 navbar-left">
				<div class="navbar_menu">
					
					<h3>
						고객센터
						<a class="nav-link disabled"></a>
					</h3>
					<a class="nav-link" href="${appRoot }/serviceCenter/notice">공지사항</a>
					<a class="nav-link" href="${appRoot }/serviceCenter/qnaList">묻고답하기</a>
					<a class="nav-link left_nav_active" href="${appRoot }/serviceCenter/freq">자주묻는질문</a>
					
				</div>
			</div>


			<div class="col-10">
				<div class="contents">
					
					<h1>자주묻는질문</h1>
					
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



				<table class="table board_list" style="width: 1625px;">
					<thead>
						<ul class="nav nav-tabs" id="myTab" role="tablist">
							<li class="nav-item" role="presentation">
								<button class="nav-link active" id="home-tab"
									data-bs-toggle="tab" data-bs-target="#home-tab-pane"
									type="button" role="tab" aria-controls="home-tab-pane"
									aria-selected="true">전체</button>
							</li>
						<!-- 	<li class="nav-item" role="presentation">
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
							</li> -->
						</ul>


						<!-- <div class="tab-content" id="myTabContent">
							<div class="tab-pane fade show active" id="home-tab-pane"
								role="tabpanel" aria-labelledby="home-tab" tabindex="0"> -->

								
								<div>
									<c:forEach items="${Page }" var="sc">
										<%-- <ul class="list-group">
											<span name="toggle-control">
												<input  type="button" 
													value=" Q. ${sc.title }"
													class="form-control" style="text-align: left; padding: 15px 15px;" />
											</span>
										</ul>
										<span name="toggle-control" style="display: none;"> A.${sc.body }</span> --%>
										
										<ul class="list-group">
											<div class="heading" >
												<input  type="button" 
													value=" Q. ${sc.title }"
													class="form-control" style="text-align: left; padding: 15px 15px;" />
											</div>
											<div class="freqContent"  style="background-color:#dff9fb; padding: 15px 15px 15px 40px; " > A. ${sc.body }</div>
										</ul>
									 </c:forEach> 
								</div>
							<!-- </div>
						</div> -->
					</thead>
				</table>


			
				<sec:authorize access="hasRole('ADMIN')">
					<sec:authentication property="principal" var="principal" />
					<div class="col justify-content-right" align="right" style="padding-right:40px;">
						<button class="btn btn-primary" style="background: #E6FFFF;">
							<a href="${appRoot}/serviceCenter/freqInsert">글쓰기</a>
						</button>

						<button class="btn btn-primary" style="background: #E6FFFF;">
							<a href="${appRoot }/serviceCenter/freqmd">
								<i class="fa-solid fa-user-pen"></i>
							</a>
						</button>

					</div>
				</sec:authorize>
				</div>
				
				<tag:noticepagination path="freq" />
		
			</div>
		</div>

	<!-- <footer style="height: 25px; background-color:black;"></footer>  -->

</body>
</html>