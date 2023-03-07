<%@page import="com.user.db.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
</head>
<body>
<h1>나의 정보 수정 (updateForm 지워도 됨)</h1>
<%
UserDTO dto=(UserDTO)request.getAttribute("dto");
	%>
<form action="./UserInfoUpdatePro.us" method="get">
아이디 : <input type="text" name="id" value="<%=dto.getUser_id() %>" ><br>
비밀번호 : <input type="password" name="pass"><br>
이름 : <input type="text" name="name" value="<%=dto.getUser_name() %>" ><br>
<input type="submit" value="회원정보수정">
</form>	
<a href="./UserInfoMypage.us">FirstMypage.me 이동</a>
</body>
</html>