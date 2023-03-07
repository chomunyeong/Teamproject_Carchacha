<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
    <link rel="stylesheet" href="./css/userLoginForm.css"/>
</head>
<script type="text/javascript">
function id_search() {
	
	var windowW = 500;  
	var windowH = 300;  
	var left = (window.screen.width - windowW)/2;
	var top = (window.screen.height - windowH)/2;
	
	url="./findId.us";
	 open(url, 'confirm' , 'status=no, height=' + windowH +' , width= ' + windowW + ', left='+ left + ', top='+ top );
}

function pass_search() {
	
	var windowW = 500;  
	var windowH = 300;  
	var left = (window.screen.width - windowW)/2;
	var top = (window.screen.height - windowH)/2;
	
	url="./findPass.us";
	 open(url, 'confirm' , 'status=no, height=' + windowH +' , width= ' + windowW + ', left='+ left + ', top='+ top );
}
</script>

<!-- 카카오 자바스크립트 코드 86ad72e4cc590fb5133c38f3d4058f6e"> -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<body>
<video preload="auto" class="video-bg" loop muted autoplay playsinline>
	<source src="./car_images/car4.mp4" type="video/mp4">
</video>
<div class="bg_blur"></div>
<form action="./UserLoginPro.us" name="userLogin" method="post"> 
<input class="input" type="text" name="user_id" placeholder="userID"> <br>

<input class="input" type="password" name="user_pass" placeholder="password"> <br>

<input type="submit" value="로그인">
<input type="button" value="회원가입" id="sign" onClick="location.href ='./UserInsertForm.us'">

<div class="login_find">
	<input type="button" class="idpass" value="아이디찾기" onclick="id_search()">
	<input type="button" class="idpass" value="비밀번호찾기" onclick="pass_search()">
</div>

</form>
</body>
</html>