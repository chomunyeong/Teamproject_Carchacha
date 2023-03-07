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
String user_id = request.getParameter("user_id");
String user_email = request.getParameter("user_email");

UserDAO dao = new UserDAO();
String user_pass = dao.FindPass(user_id, user_email);
System.out.println(user_pass);

if(user_pass!=null){
	%>
	비밀번호는 <%= user_pass %>입니다.
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