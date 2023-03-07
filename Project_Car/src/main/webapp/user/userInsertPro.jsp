<%@page import="com.user.db.UserDTO"%>
<%@page import="com.user.db.UserDAO"%>
<%@page import="java.sql.Timestamp"%>
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
/*
create table userinfo
( user_num int(11) primary key
, user_id varchar(20) not null
, user_pass varchar(20) not null
, user_name varchar(10) not null
, user_hp varchar(15) not null
, email varchar(45)
, address varchar(100) not null
, user_pt int(10) default 0
, user_birth date not null
, license_num varchar(20) not null
, license_type varchar(20) not null
, unique (user_hp)
);
*/
request.setCharacterEncoding("utf-8");

//서버에서 받아온 유저의 정보를 변수에 저장함.
String user_id = request.getParameter("user_id");
String user_pass = request.getParameter("user_pass");
String user_name = request.getParameter("user_name");
String user_hp = request.getParameter("user_hp");
String email = request.getParameter("email");
String address = request.getParameter("address1") + request.getParameter("address2") + request.getParameter("address3");
String user_birth = request.getParameter("user_birth");
String license_num = request.getParameter("license_num");
String license_type = request.getParameter("license_type");

//dao 메서드 호출하기위해서는 객체생성해야함.
UserDAO dao = new UserDAO();
//서버에서 받아온 유저정보를 바구니에 넣기위해서 dto 객체 생성
UserDTO dto = new UserDTO();

//dto의 set메서드를 이용해서 데이터를 담아줌.
dto.setUser_num(0);
dto.setUser_id(user_id);
dto.setUser_pass(user_pass);
dto.setUser_name(user_name);
dto.setUser_hp(user_hp);
dto.setEmail(email);
dto.setAddress(address);
dto.setUser_birth(user_birth);
dto.setLicense_num(license_num);
dto.setLicense_type(license_type);

//dao의 메서드를 호출함.
dao.insertUser(dto);

response.sendRedirect("user_login_Form.jsp");
%>
</body>
</html>