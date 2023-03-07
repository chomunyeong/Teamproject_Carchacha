<%@page import="com.car.db.CarInfoDAO"%>
<%@page import="com.car.db.CarInfoDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/carList.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
</head>
<%
String sessionId=(String)session.getAttribute("sessionId");
CarInfoDAO dao = new CarInfoDAO();
List<CarInfoDTO> carList = (List<CarInfoDTO>)request.getAttribute("carList");
if(sessionId==null){
	sessionId="null";
}
%>
<body>
   <jsp:include page="../css/header.jsp"></jsp:include>
      <%
   if(sessionId.equals("admin")){
   %>
		<div>
			<button onclick="location.href='./CarListAdmin.ci'" class="update_btn">
			차<br>량<br>등<br>록
			</button>
		</div>
   <%
   }
   %>
   <div id="wrapper">
      <div id="container">
      <% for(int i = 0; i < carList.size(); i++ ) {
         %>
         <div><!-- 1 -->
            <a href="./ReservationMain.res?car_num=<%=carList.get(i).getCar_num()%>">
               <img src="./car_images/<%= carList.get(i).getCar_image()%>">
            </a>
            <input type="submit" value="상세 정보" class="dtls-btn" onclick="location.href='./ReservationMain.res?car_num=<%=carList.get(i).getCar_num()%>'">
         </div>
      <%   
      }
      %>
      </div>
   </div>
</body>
</html>