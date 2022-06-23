<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<div class=" bg-dark col jusfify-content-center" align="center">
	<i style="color:white;" class="fa-solid fa-leaf"> Spring Tour</i>
</div>

<sec:authorize access="not isAuthenticated()">
	<div class="col justify-content-right" align="right">
		<form action="${appRoot }/login" id="loginTagLoginForm" method="post">
			아이디 :
			<input type="text" name="username" id="loginTagId" />
			<br />
			비밀번호 :
			<input type="password" name="password" id="loginTagPassword" />	
		</form>
		<input form="loginTagLoginForm" type="submit" value="로그인" />
		<input form="loginTagRegisterForm" type="submit" value="회원가입" />
	</div>
</sec:authorize>

<sec:authorize  access="hasRole('GUEST')">
	<sec:authentication property="principal" var="principal" />	
	<div class="col justify-content-right" align="right">
		<a href="" class="nav-link disabled">${principal.username }님 이메일 인증이 필요합니다.</a>
		<input form="resendRegisterMailForm" type="submit" value="인증메일 재전송" />
		<input form="loginTagLogoutForm" type="submit" value="로그아웃" />
	</div>
</sec:authorize>

<sec:authorize  access="hasRole('USER')">
	<sec:authentication property="principal" var="principal" />	
	<div class="col justify-content-right" align="right">
		<a href="" class="nav-link disabled">${principal.username }님 반갑습니다.</a>
		<input type="hidden" id="principalName" value="${principal.username }" />
		<input form="loginTagMyPageForm" type="submit" value="마이페이지" />
		<input form="loginTagLogoutForm" type="submit" value="로그아웃" />
		<br />
		<p id="loginTagMessageAlertParagraph">새로운 메시지가 <a id="loginTagMessageAlert" href="${appRoot }/user/dmReceiveList"></a>개 있습니다</p>
		<sec:authorize  access="hasRole('ADMIN')">
			<a href="${appRoot }/user/userList">회원관리</a>
		</sec:authorize>
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
