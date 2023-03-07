<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaChap</title>
<link href="./css/mypage.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
</head>
<meta charset="UTF-8">
<title>first/deleteForm.jsp</title>
</head>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<div id="wrapper">
		<div class="myPage_menu">
			<div>
				<button onclick="location.href='./UserInfoReservation.us'">예약 조회</button>
				<button onclick="location.href='./ReviewList.re'">나의 후기</button>
				<button onclick="location.href='./UserQnaList.us'">문의내역</button>
				<button onclick="location.href='./UserInfo.us'">회원조회</button>
				<button onclick="location.href='./UserInfoDeleteForm.us'">회원탈퇴</button>
				<%
				String sessionId = (String) session.getAttribute("sessionId");
				if (sessionId.equals("admin")) {
				%>
				<button onclick="location.href='./UserList.us'">회원목록</button>
				<%
				}
				%>
			</div>
		</div>
		<div class="myPageCont">
			<div class="my_page">
				<script type="text/javascript">
					function deletes() {
						if (!confirm("모든 파일이 삭제되도 괜찮나요")) {
							alert("취소(아니요)를 누르셨습니다");
							return false;
						} else {
							alert("확인(예)를 누르셨습니다");
						}
					}
				</script>
				<%
				String user_id = (String)session.getAttribute("sessionId");
				%>
				<form action="./UserInfoDeletePro.us" method="get" onsubmit="return deletes()">
					<table>
						<tr>
							<td colspan="2" style="text-align: center;">
								<h1>회원 탈퇴</h1>
								<p><%=user_id%>님 회원탈퇴 페이지입니다.
								</p>
							</td>
						</tr>

						<tr>
							<th>아이디</th>
							<td><input type="text" name="user_id" value="<%=user_id%>"></td>
						</tr>

						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="user_pass"></td>
						</tr>

						<tr>
							<td colspan="2" style="text-align: center;"><input class="update_input" type="submit"
								value="회원탈퇴"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>