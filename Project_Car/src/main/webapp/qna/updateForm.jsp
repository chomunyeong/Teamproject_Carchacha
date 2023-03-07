<%@page import="com.qna.db.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/qnaupdateForm.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
</head>
<body>
<!-- 	헤더 -->
	<jsp:include page="../css/header.jsp"></jsp:include>
<!-- 	헤더 -->
<div id="wrapper">
	<div class="qna_top">
		<div class="qna2">
			<div class="qna">
				<%
				QnaDTO dto=(QnaDTO)request.getAttribute("dto");
				String sessionId=(String)session.getAttribute("sessionId");
				String qna_content=dto.getQna_content();
				qna_content=qna_content.replace("<br>","\r\n");
				if(sessionId==null ) {
					sessionId += "";
				}
					if(!sessionId.equals("admin") && !sessionId.equals(dto.getUser_id())){
						response.sendRedirect("./QnaList.qn");
					}
				%>
				<form action="./QnaUpdatePro.qn" method="post" enctype="multipart/form-data">
					<input type="hidden" name="qna_num" value="<%=dto.getQna_num()%>">
					<input type="hidden" name="qna_index" value="<%=dto.getQna_index() %>">
					<table>
						<tr>
							<th>
								글쓴이
							</th>
							<td>
								<input type="text" name="user_id" value="<%=dto.getUser_id() %>" readonly>
							</td>
						</tr>
						<tr>
							<th>
								제목
							</th>
							<td>
								<input type="text" name="qna_sub" value="<%=dto.getQna_sub() %>" maxlength="50">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea name="qna_content" rows="10" cols="20" maxlength="1500"><%=qna_content%></textarea>
							</td>
						</tr>
						<tr>
							<th>
								사진
							</th>
							<td>
								<input type="file" name="qna_image" id="qna_image">
							</td> 
						</tr>
						<tr>
							<th>
								기존 이미지
							</th>
							<td>
							 	<%=dto.getQna_image() %>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="checkbox" name="qna_secret" value="Y" 
								<%=dto.getQna_secret().equals("Y") ? "checked='checked'" : "" %>>비밀글
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="글쓰기">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- footer -->
<jsp:include page="../css/footer.jsp"></jsp:include>
<!-- footer -->
</body>
</html>