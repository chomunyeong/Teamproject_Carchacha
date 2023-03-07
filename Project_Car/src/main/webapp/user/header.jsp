<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="css/header.css" rel="stylesheet">
</head>
<body>
	<!-- header -->
		<header class="nav-menu">
			<div>
				<a href="#"><img class="logo" src="https://www.busan.go.kr/humanframe/theme/busan22/assets/img/main/svg/logo01_w.svg"></a>
<!-- 				<input type="search" id="searchBar" class="gnb_serch_box" placeholder="원하는 차종, 대여 날짜를 입력하세요."> -->
				<nav>
					<div>
						<p>
							<a href="#">차량예약</a>
						</p>
					</div>
					<div>
						<p>
							<a href="#">차량소개</a>
						</p>
					</div>
					<div>
						<p>이용안내</p>
						<p>
							<a href="#">대여요금</a>
							<a href="#">대여절차</a>
						</p>
					</div>
					<div>
						<p>회사소개</p>
						<p>
							<a href="#">회사소개</a>
							<a href="#">찾아오시는 길</a>
						</p>
					</div>
					<div>
						<p>고객지원</p>
						<p>
							<a href="#">공지사항</a>
							<a href="./QnaList.qn">문의사항</a>
						</p>
					</div>
				</nav>
			</div>
		</header>
		<div class="log-bar"></div>
		<div class="log_btn">
			<button Onclick="location.href='user/userLoginForm.jsp'">Login</button>
			<button Onclick="location.href='user/userInsertForm.jsp'">Sign up</button>
		</div>
</body>
</html>