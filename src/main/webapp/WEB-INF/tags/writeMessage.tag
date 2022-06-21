<%@ tag language="java" pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		$("#writeMessageTagButton").click(function(){
			window.open("${appRoot}/user/writeMessage", 
					'writeMeassagePopUp', 
					'width=800, height=550, left=200, top=100, menubar=no, status=no, toolbar=no');
		});
	});
	
</script>

<div>
	<button id="writeMessageTagButton">메시지 쓰기</button>
</div>