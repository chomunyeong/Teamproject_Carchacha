<%@page import="org.apache.jasper.tagplugins.jstl.core.If"%>
<%@page import="java.util.function.Function"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="./css/qnaWrite.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<script type="text/javascript">

	function check() {
		if (document.getElementById("qna_sub").value=="") {
			alert("제목을 입력하시오")
			document.getElementById("qna_sub").focus();
			return false;s
		}
	}
</script>
<link rel="stylesheet" href="./css/header.css"/>
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
				String sessionId=(String)session.getAttribute("sessionId");
				if(sessionId==null){
					response.sendRedirect("./QnaList.qn");
				}
				%>
				
				<form action="QnaWritePro.qn" method="post" name="fo" enctype="multipart/form-data" onsubmit="return check()">
					<table>
						<tr>
							<th>
								글쓴이
							</th>
							<td>
								<input type="text" name="user_id" value="<%=sessionId %>" readonly>
							</td>
						</tr>
						<tr>
							<th>
								글제목
							</th>
							<td>
								<input type="text" name="qna_sub" id="qna_sub" maxlength="50">
							</td>
						</tr>
						<tr>
							<th>
								글내용
							</th>
							<td>
								<textarea name="qna_content" rows="10" cols="20" maxlength="1500" style="word-wrap:break-word;"></textarea>
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
							<td colspan="2">
								<input type="checkbox" name="qna_secret" value="Y" > 비밀글
							</td>
						</tr>
						<tr align="right">
							<td colspan="2">
								<input type="submit" value="글쓰기">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>	
</div><!-- wrapper end -->
<!-- footer -->
<jsp:include page="../css/footer.jsp"></jsp:include>
<!-- footer -->
</body>
</html>