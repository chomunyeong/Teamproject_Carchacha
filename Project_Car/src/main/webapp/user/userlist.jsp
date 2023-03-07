<%@page import="java.security.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.user.db.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>다 함께 CarChaCha</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/userlist.css" rel="stylesheet">
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
// UserDAO dao = new UserDAO();
// List<UserDTO> userList = dao.getUserList();



List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
int startPage = (Integer) request.getAttribute("startPage");
int pageBlock = (Integer) request.getAttribute("pageBlock");
int currentPage = (Integer) request.getAttribute("currentPage");
int endPage = (Integer) request.getAttribute("endPage");
int pageCount = (Integer) request.getAttribute("pageCount");
int count = (Integer) request.getAttribute("count");
int pageSize = (Integer) request.getAttribute("pageSize");

String sessionId = (String)session.getAttribute("sessionId");




if(sessionId==null || !sessionId.equals("admin")){
   response.sendRedirect("./UserInfoMypage.us");
}
%>
<table>
    <thead>
	    <tr>
	        <th>회원번호</th>
	        <th>회원아이디</th>
	        <th>회원비밀번호</th>
	        <th>회원이름</th>
	        <th>생년월일</th>
			<th>잔여포인트</th>
			<th>회원주소</th>
			<th>회원이메일</th>
			<th>운전면허번호</th>
			<th>운전면허종류</th>
	    </tr>
    </thead>
    
    <tbody>
    	<%
		for(int i = 0; i < userList.size(); i++) {
			UserDTO dto = userList.get(i);
		%>
		<tr>
			<td><%= dto.getUser_num() %></td>
			<td><%= dto.getUser_id() %></td>
			<td><%= dto.getUser_pass()%></td>
			<td><%= dto.getUser_name() %></td>
			<td><%= dto.getUser_birth() %></td>
			<td><%= dto.getUser_pt() %></td>
			<td><%= dto.getAddress() %></td>
			<td><%= dto.getEmail() %></td>
			<td><%= dto.getLicense_num() %></td>
			<td><%= dto.getLicense_type() %></td>
		</tr>
		<%
}
%>
<div class="a_list">
	<%
	// 10페이지 이전
	if(startPage>pageBlock) {
	%>
		<a href="UserList.us?pageNum=<%=startPage-pageBlock %>"><<</a>
	<%
	}else {
		%>
		<a href="UserList.us?pageNum=<%=startPage %>"><<</a>
	<%
	}
	// 1페이지 이전
	if(currentPage != 1) {
	%>
		<a href="UserList.us?pageNum=<%=currentPage-1 %>">이전</a>
	<%
	} else {
		%>
		<a href="UserList.us?pageNum=<%=startPage %>">이전</a>
	<%
	}
	for(int i=startPage; i<=endPage; i++){
	%>
		<a class="list_num" href="UserList.us?pageNum=<%=i%>"><%=i%></a>
	<%
	} 
	
	// 1페이지 다음
	if(currentPage < pageCount) {
		%>
		<a href="UserList.us?pageNum=<%=currentPage+1 %>">다음</a>
		<%
	} else {
		%>
		<a href="#">다음</a>
	<%
	}
	%>
	<%
	//10페이지 다음
	if(endPage < pageCount) {
		%>
		<a href="UserList.us?pageNum=<%=startPage+pageBlock %>">>></a>
		<%
	} else {
		%>
		<a href="UserList.us?pageNum=<%=endPage %>">>></a>
	<%
	}
	%>

</div>
    </tbody>
</table>
</div>
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>