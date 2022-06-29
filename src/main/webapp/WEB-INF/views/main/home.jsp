<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>


<link rel="stylesheet" href="css/style.css">

<style>


		.imtext {
		position:absolute;
		top:70px;
		left:100px;
		z-index:1;
		color:white;
		font-size:130px;
		width:120px;
		font-weight:bold;
		
	}
	
		.imtext2 {
		position:absolute;
		top:350px;
		left:750px;
		z-index:1;
		color:#0a3d62;
		font-size:130px;
		width:120px;
		font-weight:bold;
		
	}
	
	
		.imtext3 {
		position:absolute;
		top:170px;
		left:550px;
		z-index:1;
		color:#EAB543;
		font-size:150px;
		width:120px;
		font-weight:bold;
		
	}
	
	
</style>


<title>Welcome</title>
</head>
<body>
	
	<div class="container-fluid" style="background:#60a3bc;">
		<div class="row">
			<div class="col-12">
				<tag:login/>
				<tag:navBar/>
			</div>
		</div>
		
		<div class="row">
			 <div class="col-1"> 

			</div>
			<div class="col-10">


				<div id="carouselExampleControls" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="../resources/img2/mapgirl.jpg" class="d-block w-100" alt="...">
							<span class="imtext">WHERE SHOULD WE GO?</span>
						</div>
						<div class="carousel-item">
							<img src="../resources/img2/resort.jpg" class="d-block w-100" alt="...">
							<span class="imtext2">RELAXING VACATION</span>
						</div>
						<div class="carousel-item">
							<img src="../resources/img2/lake.jpg" class="d-block w-100" alt="...">
							<span class="imtext3">HELLO, SPRING TOUR</span>
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>


				<c:if test="${not empty resultMessage}">
						<div class="alert alert-primary">
							${resultMessage }
						</div>
					</c:if>
					<%-- <h1>Welcome to Spring Tour!</h1>
					<p><span>ServerTime : </span><span style="color:red">${serverTime }</span></p>
					<p><span>Locale : </span><span style="color:red">${locale }</span></p>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eum dignissimos quae vel animi sequi consectetur ducimus voluptatibus sint earum inventore fugit modi tenetur cum eveniet assumenda odit fugiat. Soluta repudiandae!</p>	
					
					<h2>Description</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa architecto placeat deserunt odio hic quis reprehenderit tempora doloribus blanditiis debitis voluptates odit. Beatae sit consectetur porro explicabo veritatis dolorem impedit.</p>
					<p><span>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni at mollitia aspernatur velit beatae dolorem? Consequuntur aut facere excepturi quaerat doloremque similique error illum unde perferendis accusamus libero sed aspernatur!</span>
					<span>Unde officia omnis rerum nam voluptatem mollitia nemo debitis ipsa quia consequatur eveniet possimus molestias cupiditate magni dolor ipsam dolore vitae odit delectus iusto tenetur corporis accusamus praesentium doloremque optio!</span>
					<span>Numquam suscipit eos ratione tempore laudantium impedit laborum molestias earum nobis. Cumque ipsam qui adipisci iusto vitae dolore odit odio sapiente excepturi quis autem reiciendis aperiam doloribus natus officiis repellat.</span>
					<span>Autem neque ullam quaerat maiores aspernatur in sit consequatur hic itaque accusantium. Numquam omnis repudiandae beatae quis laudantium ad officia iste unde voluptates eos aliquid fugit itaque. Debitis illo dicta!</span>
					<span>Doloremque non error blanditiis iusto tenetur quae nam sed velit quia fugiat ullam fugit neque deserunt itaque amet accusamus sequi rem optio quasi placeat atque ipsa molestiae repellat nihil laudantium!</span>
					<span>Quis minus porro eveniet quos nemo numquam adipisci magnam nobis velit odio ea veniam in eligendi autem nulla dolores delectus odit incidunt enim ut blanditiis. Vel doloribus est dignissimos reiciendis!</span></p>
				
					<h3 style="color:red"><i class="fa-solid fa-location-dot"></i> Start a new Trip Now!!!</h3>
					<p>You can Write a Post about Review where you've travled Right below Here by clicking this button! <br />
					There is also a menubar upside, u can check the Reviews! on the board</p> --%>
			</div>


			<div class="col-1">
			
			</div>


		</div>
		
		<div class="row">
			<div class="col-12">
			
			</div>
		</div>
		
	 </div> 
</body>
</html>