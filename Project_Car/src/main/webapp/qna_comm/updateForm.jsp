<%@page import="com.qna_comm.db.QnaCommDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/qnacommupdateForm.css" rel="stylesheet">
<link rel="stylesheet" href="./css/header.css"/>
</head>
<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<div id="wrapper">
	<div class="qna_top">
		<div class="qna2">
			<div class="qna">
				<%
				QnaCommDTO dto=(QnaCommDTO)request.getAttribute("dto");
				String sessionId=(String)session.getAttribute("sessionId");
				int qna_index=Integer.parseInt(request.getParameter("qna_index"));
				String comm_content=dto.getComm_content();
				comm_content=comm_content.replace("<br>","\r\n");
				
				if(sessionId==null && !sessionId.equals(dto.getUser_id())){
					response.sendRedirect("./QnaList.qn");
				}
				%>
				<h1>글수정</h1>
				<form action="QnaCommUpdatePro.co" method="post">
					<input type="hidden" name="qna_num" value="<%=dto.getQna_num()%>">
					<input type="hidden" name="comm_num" value="<%=dto.getComm_num()%>">
					<input type="hidden" name="qna_index" value="<%=qna_index %>">
					<table border="1">
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
								글내용
							</th>
							<td>
								<textarea name="comm_content" rows="10" cols="20" maxlength="1500"><%=comm_content%></textarea>
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
</body>
</html>