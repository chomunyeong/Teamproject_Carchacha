<%@page import="com.notice.db.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCharm.jsp</title>
<link href="./css/noticeWrite.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">

<script type="text/javascript" src="./script/jquery-3.6.3.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	 $('#join').submit(function(){
		 if($('.subject').val()=="" ){
				alert("제목을 입력하세요");
				$('.subject').focus();
				return false;
			}
			 
	 });
 });

 
 
 </script>

</head>
<body>
<!-- 	헤더 -->
	<jsp:include page="../css/header.jsp"></jsp:include>
<!-- 	헤더 -->
<div id="wrapper">
	<div class="notice_top">
	<%
//세션값 가져오기
NoticeDTO dto = (NoticeDTO) request.getAttribute("dto");
	String sessionId=(String)session.getAttribute("sessionId");


	if(sessionId==null){
		response.sendRedirect("./NoticeList.no");
	}
	%>

	<!--  enctype="multipart/form-data" -->
	<div class="notice_title">
		</div> <!-- notice title end -->
	</div> <!-- noticeTop end -->
<div class="notice2">	
	<div class="notice">
	<form action="./NoticeWritePro.no" method="post"
		encType="multipart/form-data" id="join">
		<table  class="notice_table">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="name" value="<%=sessionId %>"
					readonly></td>
			</tr>
			<tr>
				<td>글제목</td>
				<td><input type="text" name="subject" class="subject" placeholder="글제목을 입력하세요."
					maxlength="50"></td>
			</tr>
			<tr>
				<td>글내용</td>
				<td ><textarea name="content" rows="10" class="content" maxlength="1500"></textarea></td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td ><input type="file" name="fileName" ></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><input class="update_input" type="submit" value="글쓰기"></td>
			</tr>
		</table>
	</form>
	</div>
</div>	
	</div><!-- wrapper end -->
<!-- footer -->
<jsp:include page="../css/footer.jsp"></jsp:include>
<!-- footer -->
</body>
</html>


