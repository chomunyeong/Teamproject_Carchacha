<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/guide.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<div id="wrapper">
		<input type="checkbox" id="aboutBtn">
		<section class="sec01">
			<video preload="auto" class="video-bg" loop muted autoplay>
				<source src="./car_images/회사소개영상.mp4" type="video/mp4">
			</video>
			<div class="about_us">
				<label for="aboutBtn">About Us</label>
				<p>여행의 행복에서 삶의 행복까지 함께 할 수 있도록</p>
				<span>고객 여러분께 더 좋은 서비스를 제공하기 위해 끊임없이 노력하겠습니다.</span>
			</div>
		</section>
<!-- 		<section class="sec02"> -->
<!-- 			<input type="radio" name="company-info" id="vision"> -->
<!-- 			<input type="radio" name="company-info" id="mission"> -->
<!-- 			<div> -->
<!-- 				<div> -->
<!-- 				<label for="vision">비전</label> -->
<!-- 				</div> -->
<!-- 				<div><label for="mission">핵심가치</label></div> -->
<!-- 			</div> -->
<!-- 			<div class="vision_cont"> -->
<!-- 			vision -->
<!-- 			</div> -->
<!-- 			<div class="mission_cont"> -->
<!-- 			mission -->
<!-- 			</div> -->
<!-- 		</section> -->
	</div>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>