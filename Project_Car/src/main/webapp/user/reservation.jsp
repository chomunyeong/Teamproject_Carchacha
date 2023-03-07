<%@page import="com.reservation.db.ReservationDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userinfo/reservationMForm</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/myReservation.css" rel="stylesheet">
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
 					String sessionId2 = (String)session.getAttribute("sessionId");
					if(sessionId2.equals("admin")) { %>
					<button onclick="location.href='./UserList.us'">회원목록</button>
					<% 	
 					}%>
			</div>
		</div>
<%
List<ReservationDTO> mypageResList = (List<ReservationDTO>)request.getAttribute("mypageResList");
String sessionId=(String)session.getAttribute("sessionId");
int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
int count=(Integer)request.getAttribute("count");

%>

<div class="user_txt"><p><%=sessionId %>님의 예약정보 내용입니다.</p></div>
<div class="table_list">
	<%
	if(mypageResList.size()!=0){
		for(int i = 0; i<mypageResList.size(); i++) {
			ReservationDTO dto = mypageResList.get(i);
			%>
			<div>
				<table>
					<tr>
						<th>예약번호</th>
						<td><input type="text" name="res_num" value="<%=dto.getRes_num() %>"
							readonly="readonly"></td>
					</tr>
					<tr>
						<th>차량번호</th>
						<td><input type="text" name="res_car_num"
							value="<%=dto.getRes_car_num() %>"readonly="readonly"></td>
					</tr>
					<tr>
						<th>예약시작시간</th>
						<td><input type="text" name="res_stime" value="<%=dto.getRes_stime() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>예약종료시간</th>
						<td><input type="text" name="res_time" value="<%=dto.getRes_time() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>반납시간</th>
						<td><input type="text" name="return_car" value="<%=dto.getReturn_car() %>" readonly="readonly"></td>
					</tr>
					<tr>
						<%if(sessionId.equals("admin") && dto.getReturn_car()!= 1 ){ %>
							<td colspan="2">
								<button onclick="location.href='./ResReturn.res?res_num=<%=dto.getRes_num() %>'" >반납완료</button>
							</td>
						<%} %>
						<%if(!sessionId.equals("admin") && dto.getReturn_car()==1){ %>
							<td colspan="2">
								<button onclick="location.href='./ReviewWriteForm.re?car_num=<%=dto.getRes_car_num() %>&user_id=<%=dto.getUser_id() %>'" >리뷰작성</button>
							</td>
					</tr>
					<%} %>
				</table>
			</div>
		<%
		}
	} else{
		%>
		<script>
			alert("예약 내역이 없습니다.");window.history.back();
		</script>
		<%
	}
	%>
	
</div>
  
</div>
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>