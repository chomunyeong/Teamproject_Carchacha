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
<title>�� �Բ� CarChaCha</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/userlist.css" rel="stylesheet">
</head>

<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<div id="wrapper">
	<div class="myPage_menu">
		<div>
			<button onclick="location.href='./UserInfoReservation.us'">���� ��ȸ</button>
			<button onclick="location.href='./ReviewList.re'">���� �ı�</button>
			<button onclick="location.href='./UserQnaList.us'">���ǳ���</button>
			<button onclick="location.href='./UserInfo.us'">ȸ����ȸ</button>
			<button onclick="location.href='./UserInfoDeleteForm.us'">ȸ��Ż��</button>
			<%
					String sessionId2 = (String)session.getAttribute("sessionId");
				if(sessionId2.equals("admin")) { %>
				<button onclick="location.href='./UserList.us'">ȸ�����</button>
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
	        <th>ȸ����ȣ</th>
	        <th>ȸ�����̵�</th>
	        <th>ȸ����й�ȣ</th>
	        <th>ȸ���̸�</th>
	        <th>�������</th>
			<th>�ܿ�����Ʈ</th>
			<th>ȸ���ּ�</th>
			<th>ȸ���̸���</th>
			<th>���������ȣ</th>
			<th>������������</th>
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
	// 10������ ����
	if(startPage>pageBlock) {
	%>
		<a href="UserList.us?pageNum=<%=startPage-pageBlock %>"><<</a>
	<%
	}else {
		%>
		<a href="UserList.us?pageNum=<%=startPage %>"><<</a>
	<%
	}
	// 1������ ����
	if(currentPage != 1) {
	%>
		<a href="UserList.us?pageNum=<%=currentPage-1 %>">����</a>
	<%
	} else {
		%>
		<a href="UserList.us?pageNum=<%=startPage %>">����</a>
	<%
	}
	for(int i=startPage; i<=endPage; i++){
	%>
		<a class="list_num" href="UserList.us?pageNum=<%=i%>"><%=i%></a>
	<%
	} 
	
	// 1������ ����
	if(currentPage < pageCount) {
		%>
		<a href="UserList.us?pageNum=<%=currentPage+1 %>">����</a>
		<%
	} else {
		%>
		<a href="#">����</a>
	<%
	}
	%>
	<%
	//10������ ����
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