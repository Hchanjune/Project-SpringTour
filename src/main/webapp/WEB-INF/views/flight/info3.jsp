<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.team.springtour.domain.flight.FlightDto"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Welcome</title>
	<script type="text/javascript">
		$(function(){
			var chkObj = document.getElementsByName("RowCheck");
			var rowCnt = chkObj.length;
			
			$("input[name='allCheck']").click(function(){
				var chk_listArr = $("input[name='RowCheck']");
				for (var i=0; i<chk_listArr.length; i++){
					chk_listArr[i].checked = this.checked;
				}
			});
			$("input[name='RowCheck']").click(function(){
				if($("input[name='RowCheck']:checked").length == rowCnt){
					$("input[name='allCheck']")[0].checked = true;
				}
				else{
					$("input[name='allCheck']")[0].checked = false;
				}
			});
		});
		function deleteValue(){
			var url = "info3";    // Controller??? ???????????? ?????? URL (.dh????????? ????????? ????????? ????????? ???????????????)
			var valueArr = new Array();
		    var list = $("input[name='RowCheck']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){ //???????????? ????????? ????????? ?????? ?????????
		            valueArr.push(list[i].value);
		        }
		    }
		    if (valueArr.length == 0){
		    	alert("????????? ????????? ???????????? ????????????.");
		    }
		    else{
				var chk = confirm("?????? ?????????????????????????");				 
				$.ajax({
				    url : url,                    // ?????? URL
				    type : 'POST',                // GET or POST ??????
				    traditional : true,
				    data : {
				    	valueArr : valueArr        // ???????????? ?????? data ?????? ??????
				    },
	                success: function(jdata){
	                    if(jdata = 1) {
	                        alert("????????? ?????????????????????.");
	                       location.replace("info3")
	                    }
	                    else{
	                    	return false;
	                        alert("????????? ?????????????????????.");  
	                        location.href="${pageContext.request.contextPath }/board/delete.do?board_idx=${boardContents.board_idx}";
	                    }
	                    
	                }
				});
			}
		}
	</script>
</head>

<body>

	<div class="container-fluid">
		<!-- Header -->
		<div class="row">
			<div class="col-12">
				<tag:login />
				<tag:navBar />
			</div>
		</div>


		<div class="row">
			<!-- Left -->
			<div class="col-2">
				<tag:managementSideMenu/>
			</div>

			<!-- Main -->
			<div class="col-10">

				<h1>????????? ??????</h1>

				<form action="${appRoot }/flight/info" method="post">
				
				<table>
					<thead>
						<tr>
							<th><input id="allCheck" type="checkbox" name="allCheck"/></th>
							<th>????????? ??????&nbsp;&nbsp;&nbsp;</th>
							<th>????????????&nbsp;&nbsp;&nbsp;</th>
							<th>????????????&nbsp;&nbsp;&nbsp;</th>
							<th>????????????&nbsp;&nbsp;&nbsp;</th>
							<th>????????????&nbsp;&nbsp;&nbsp;</th>
							
						</tr>
					</thead>

					<c:forEach items="${flightList }" var="Flight" >
						<tr>
							<td class="checkbox"><input name="RowCheck" type="checkbox" value="${Flight.planeNumber }"/></td>
							<td>${Flight.planeNumber }&nbsp;&nbsp;&nbsp;</td>
							<td>${Flight.departureDate }&nbsp;&nbsp;&nbsp;</td>
							<td>${Flight.returnDate }&nbsp;&nbsp;&nbsp;</td>
							<td>${Flight.departurePort }&nbsp;&nbsp;&nbsp;</td>
							<td>${Flight.returnPort }&nbsp;&nbsp;&nbsp;</td>
							
							
						</tr>
					</c:forEach>
					
					
				</table>
				
				<input type="button" value="????????????" onclick="deleteValue();">
				
				<br> <br> <br> <br>
				
				<button type="button-1">????????????</button>
					
				</form> 

			</div>

			<!-- Footer -->
			<div class="row">
				<div class="col-12">
					<tag:footer/>
				</div>
			</div>

		</div>

	</div>

</body>
</html>