<%@page import="com.user.db.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
</head>
<body>
<%
String user_id = request.getParameter("user_id");
UserDAO dao = new UserDAO();
boolean result = dao.confirmId(user_id);

if(result) { %>
	<center>
	<br><br>
	<h4>이미 사용중인 ID입니다.</h4>
	</center>
<% } else { %>
	<center>
	<br><br>
	<h4>입력하신 <%= user_id %>는 사용하실 수 있는 ID입니다.</h4>
	</center>
<% 
}
%>
</body>
</html>