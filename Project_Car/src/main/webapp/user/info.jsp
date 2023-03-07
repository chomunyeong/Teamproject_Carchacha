<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/mypage.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<div id="wrapper">
		<div class="myPage_menu">
			<div>
				<button onclick="location.href='./UserInfoReservation.us'">예약
					조회</button>
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
				<form>
					<%
					String user_id = (String) session.getAttribute("sessionId");
					// String user_pass = (String) session.getAttribute("user_pass");
					String user_name = (String) session.getAttribute("user_name");
					String user_hp = (String) session.getAttribute("user_hp");
					String email = (String) session.getAttribute("email");
					String address = (String) session.getAttribute("address");
					int user_pt = (Integer) session.getAttribute("user_pt");
					String license_num = (String) session.getAttribute("license_num");
					String license_type = (String) session.getAttribute("license_type");
					%>
					<table>
						<tr>
							<td colspan="2" style="text-align: center;">
								<h1>나의 정보 조회</h1>
								<p><%=user_id%>님 정보를 조회하셨습니다
								</p>
							</td>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="user_id" value="<%=user_id%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>이름</th>
							<td><input type="text" name="user_name" value="<%=user_name%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>휴대전화</th>
							<td><input type="text" name="user_hp" value="<%=user_hp%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>이메일</th>
							<td><input type="text" name="user_email" value="<%=email%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>지역</th>
							<td><input type="text" name="address" value="<%=address%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>포인트</th>
							<td><input type="text" name="user_pt" value="<%=user_pt%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>면허증 번호</th>
							<td><input type="text" name="license_num" value="<%=license_num%>" readonly="readonly"></td>
						</tr>

						<tr>
							<th>면허증 종류</th>
							<td><input type="text" name="license_type" value="<%=license_type%>" readonly="readonly"></td>
						</tr>


						<tr>
							<td colspan="2" style="text-align: center;"><input
								type="button" value="마이페이지 이동"
								onclick="location.href='./UserInfoMypage.us'"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>
