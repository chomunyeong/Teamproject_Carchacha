<%@page import="com.user.db.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
</head>
<%
String user_name = request.getParameter("user_name");
String user_email = request.getParameter("user_email");

UserDAO dao = new UserDAO();
String user_id = dao.FindID(user_name, user_email);
System.out.println(user_id);

if(user_id!=null){
	%>
	아이디는 <%= user_id %>입니다.
	<%
	
}else{
	%>
	일치하는 정보가 없습니다.
	<%
}
%>
<script type="text/javascript">

</script>
<body>

</body>
</html>