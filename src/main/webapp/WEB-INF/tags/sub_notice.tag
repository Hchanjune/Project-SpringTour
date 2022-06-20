<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:url value="/serviceCenter/notice/notice" var="noticeLink"/>



<div class="container">
	<div class="row">
		<div class="col">
			<nav class="nav flex-column"
				style="posotion: relative; left: 0px; margin-top: 0px; bottom: inherit;">
				<a class="nav-link disabled">고객센터</a>
				<a class="nav-link" href="${appRoot }/serviceCenter/notice/notice">공지사항</a>
				<a class="nav-link" href="${appRoot }/serviceCenter/qna">묻고답하기</a>
				<a class="nav-link" href="${appRoot }/serviceCenter/freq">자주묻는질문</a>
			</nav>
		</div>
	</div>
</div>