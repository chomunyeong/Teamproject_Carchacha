<%@page import="java.io.File"%>
<%@page import="com.notice.db.NoticeDTO"%>
<%@page import="com.notice.db.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/noticeContent.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">

<script type="text/javascript" src="./script/jquery-3.6.3.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.Dconfirm').click(function() {
			if (!confirm("삭제 하시겠습니까?")) {
				return false;
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
<div id="wrapper">
	<div class="notice_top">
		<div class="notice2">	
			<div class="notice">
<!-- 		<div class="notice_title"> -->
		</div>
	</div>
	<%
	NoticeDTO dto = (NoticeDTO) request.getAttribute("dto");
	String filepath = request.getSession().getServletContext().getRealPath("notice_images");
	String real = filepath;
	File viewFile = new File(real + "\\" + dto.getNotice_image());
	System.out.println(viewFile);
	%>
<div class="notice2">	
	<div class="notice">
		<table class="table_contents">
			<tr>
				<td colspan="7" width='150px' style="workd-break:break-all"><%=dto.getNotice_sub()%></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%=dto.getUser_id()%></td>
				<td>작성일</td>
				<td><%=dto.getNotice_date()%></td>
				<td>조회수</td>
				<td><%=dto.getNotice_readcount()%></td>
			</tr>

			<tr>
				<td colspan="6" style="text-align: center;">
					<%
					if (viewFile.exists()) {
					%> <img alt="img" src="notice_images/<%=dto.getNotice_image()%>"
					width="300">
				</td>
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="8" width = '800px' style="workd-break:break-all"><%=dto.getNotice_content()%></td>
			</tr>

		

		<!-- 세션값 가져오기 -->
		<%
		String sessionId = (String) session.getAttribute("sessionId");
		%>
		<!-- 글쓴이와 로그인(세션값) 일치하면 => 글수정,글삭제 버튼 보이기 -->
		
		<%
		if (sessionId != null) {
		%>
				<%
				if (sessionId.equals("admin")) {
				%>
				
				<tr>
				
					<td style="text-align: center;"><input type="button" value="글수정" onclick="location.href='./NoticeUpdateForm.no?num=<%=dto.getNotice_num()%>'"></td>
					<td style="text-align: center;">
					<form action="./NoticeDelete.no" method="get" class="Dconfirm">
						<input type="hidden" name="num" value=<%=dto.getNotice_num()%>>
						<input type="hidden" name="num" value=<%=dto.getNotice_num()%>>
						<input type="hidden" name="notice_image" value=<%=dto.getNotice_image()%>>
						<input type="submit" value="글삭제">
					</form> </td>
						<td><input type="button" value="글목록" onclick="location.href='./NoticeList.no'"></td>
				
						<%} else {%>
								<td><input type="button" value="글목록" onclick="location.href='./NoticeList.no'"></td>
						<%}%>
		
		<%} else {%>
				<td><input type="button" value="글목록" onclick="location.href='./NoticeList.no'"></td>
		<%} %>
		
							
		</tr>
		</table>
		
		<%
		NoticeDTO dto2 = (NoticeDTO) request.getAttribute("dto2"); //  dto2 next
		NoticeDTO dto3 = (NoticeDTO) request.getAttribute("dto3"); //  dto3 back
		%>
		<%
		// NoticeDAO dao = new NoticeDAO();
		//  dto4 = dao.backNotice(dto2.getNotice_num());
		%>
		<table style="margin: 0 auto;">
		<%
		if (dto2.getNotice_num() != dto.getNotice_num()) {
		%>
		
			<tr
				onclick="location.href='./NoticeContent.no?num=<%=dto2.getNotice_num()%>'"
				style="cursor: Pointer">
				<td>다음공지사항 ▲ | </td>
				<td><%=dto2.getNotice_sub()%></td>
			</tr>
		<%
		}
		%>

		<%
		if (dto3.getNotice_num() != dto.getNotice_num()) {
		%>
			<tr
				onclick="location.href='./NoticeContent.no?num=<%=dto3.getNotice_num()%>'"
				style="cursor: Pointer">
				<td>이전공지사항 ▼ | </td>
				<td><%=dto3.getNotice_sub()%></td>
			</tr>
		
		<%
		}
		%>
		</table>
		
<!-- 		<table class="a"> -->
<!-- 				<tr> -->
<!-- 					<td> -->
<!-- 						<input type="button" value="글목록" -->
<!-- 						onclick="location.href='./NoticeList.no'" style="text-align: right;display:inline !important;background: transparent;border:1px solid;"> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 		</table> -->

<!-- 		<div style="text-align: center;" > -->
<!-- 		<input type="button" value="글목록" -->
<!-- 						onclick="location.href='./NoticeList.no'" style="text-align: right;display:inline !important;background: transparent;border:1px solid;"> -->
<!-- 			</div> -->
			
			
							<div style="text-align: center;" class="notice">
							
							</div>
			</div>
		</div>
	</div>
</div>
	
	<!-- footer -->
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>


