<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<div class=" bg-dark col jusfify-content-center" align="center">
	<i style="color:white;" class="fa-solid fa-leaf"> Spring Tour</i>
</div>

<sec:authorize access="not isAuthenticated()">
	<div class="col justify-content-right bg-gray login-bar" align="right">
		<!--  
		<form action="${appRoot }/login" id="loginTagLoginForm" method="post">
			아이디 :
			<input type="text" name="username" id="loginTagId" />
			<br />
			비밀번호 :
			<input type="password" name="password" id="loginTagPassword" />	
		</form>
		<input form="loginTagLoginForm" type="submit" value="로그인" />
		<input form="loginTagRegisterForm" type="submit" value="회원가입" />
		-->
		
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
		 로그인
		</button>
		
		
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Spring Tour</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		        <form action="${appRoot }/login" id="loginTagLoginForm" method="post">
					<div class="form-floating mb-12">
					  <input type="text" class="form-control" name="username" id="loginTagId" placeholder="아이디를 입력하세요.">
					  <label for="floatingInput">아이디</label>
					</div>
					<div class="form-floating mb-12">
					  <input type="password" class="form-control" name="password" id="loginTagPassword" placeholder="비밀번호를 입력하세요.">
					  <label for="floatingInput">비밀번호</label>
					</div>	
				</form>
				
		      </div>
		      
		      <div class="modal-footer">
		      	<div>
		      		<div class="row">
		      			<div>
		      				<input class="btn btn-success" form="loginTagLoginForm" type="submit" value="로그인" />
							<input class="btn btn-secondary" form="loginTagRegisterForm" type="submit" value="회원가입" />
		      			</div>
		      		</div>
		      		<div class="row">
		      			<div>
			      			<script>
								$(document).ready(function(){
									$("#loginTagFindIdButton").click(function(e){
										e.preventDefault();
										window.open("${appRoot}/user/forgotId", 'forgotIdPopUp', 'width=500, height=500, left=200, top=100, menubar=no, status=no, toolbar=no');
									});
									$("#loginTagFindPwButton").click(function(e){
										e.preventDefault();
										window.open("${appRoot}/user/forgotPw", 'forgotPwPopUp', 'width=500, height=500, left=200, top=100, menubar=no, status=no, toolbar=no');
									});
								});
							</script>
							<input class="btn btn-primary" id="loginTagFindIdButton" type="submit" value="아이디 찾기" />
							<input class="btn btn-primary" id="loginTagFindPwButton" type="submit" value="비밀번호 찾기" />	
		      			</div>	
		      		</div>
		      	</div>
		      </div>
		    </div>
		  </div>
		</div>
	</div>
</sec:authorize>

<sec:authorize  access="hasRole('GUEST')">
	<sec:authentication property="principal" var="principal" />	
	<div class="col justify-content-right bg-gray" align="right">
		<a href="" class="nav-link disabled">${principal.username }님 이메일 인증이 필요합니다.</a>
		<input form="resendRegisterMailForm" type="submit" value="인증메일 재전송" />
		<input form="loginTagLogoutForm" type="submit" value="로그아웃" />
	</div>
</sec:authorize>

<sec:authorize  access="hasRole('USER')">
	<sec:authentication property="principal" var="principal" />	
	<!-- <div class="col justify-content-right" align="right">
			<a href="" class="nav-link disabled">${principal.username }님 반갑습니다.</a>
			<input type="hidden" id="principalName" value="${principal.username }" />
			<input form="loginTagMyPageForm" type="submit" value="마이페이지" />
			<input form="loginTagLogoutForm" type="submit" value="로그아웃" />
			<br />
			<p id="loginTagMessageAlertParagraph">새로운 메시지가 <a id="loginTagMessageAlert" href="${appRoot }/user/dmReceiveList"></a>개 있습니다</p>
		</div> -->
	
	<div class="col justify-content-right md-12 util-right bg-gray" align="right">
		<a href="" class="nav-link disabled">${principal.username }님 반갑습니다.</a>
		<input type="hidden" id="principalName" value="${principal.username }" />
		
		<input id="icon-mypage" class="display_none btn-primary" form="loginTagMyPageForm" type="submit" value="마이페이지" />
		<label for="icon-mypage">
			<i class="fa-solid fa-user"></i>
		</label>
		
		<input id="icon-logout" class="display_none btn-primary" form="loginTagLogoutForm" type="submit" value="마이페이지" />
		<label for="icon-logout">
			<i class="fa-solid fa-arrow-right-from-bracket"></i>
		</label>
			<p class="bubble">로그아웃</p>
		
		<div class="icon-alert">
			<i class="fa-solid fa-bell"></i>
			<p class="bubble" id="loginTagMessageAlertParagraph">새로운 메시지가 <a id="loginTagMessageAlert" class="color-point" href="${appRoot }/user/dmReceiveList"></a>개 있습니다</p>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			const userId = $("#principalName").val()
			$.ajax({
				url : "${appRoot}/user/messageCount",
				method : "get",
				data : {"userId" : userId},
				success : function(data){
					$("#loginTagMessageAlert").text(data);
				},
				error : function(){
					$("#loginTagMessageAlert").hide();
					$("#loginTagMessageAlertParagraph").text("메시지 정보를 불러오는데 실패하였습니다.");
				},
				complete : function(){
				}
			});
		});
	</script>
</sec:authorize>

<div class="d-none">
	<form action="${appRoot }/logout" id="loginTagLogoutForm" method="post"></form>
</div>

<div class="d-none">
	<form action="${appRoot }/user/register" id="loginTagRegisterForm"></form>
</div>

<div class="d-none">
	<form action="${appRoot }/user/resend" id="resendRegisterMailForm" method="post">
		<input type="hidden" name="userId" value="${principal.username }" />
	</form>
</div>

<div class="d-none">
	<form action="${appRoot }/user/myPage" id="loginTagMyPageForm">
		<input type="hidden" name="userId" value="${principal.username }" />
	</form>
</div>
