<%@page import="java.io.PrintWriter"%>
<%@page import="com.notice.db.NoticeDAO"%>
<%@page import="com.notice.db.NoticeDTO"%>
<%@page import="java.util.List"%>
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
	List<NoticeDTO> noticeList = (List<NoticeDTO>) request.getAttribute("noticeList");
	//startPage pageBlock currentPage endPage pageCount
	int currentPage = (Integer) request.getAttribute("currentPage");
	int count = (Integer) request.getAttribute("count");
	int pageSize = (Integer) request.getAttribute("pageSize");
	%>

	<!-- 죄측상단 링크 -->
	<a href="./MemberMain.me">메인페이지</a>
	<br>
	<a href="./MemberLogout.me">로그아웃</a>
	<br>
	<a href="./NoticeList.no">게시글 리스트</a>
	<br>
	<!-- 죄측상단 링크 -->


	<center>
		<h1>메인페이지임</h1>
		<br> <br> <br> <br> <br> 공지사항
		<!-- 리스트 보여주는 곳 -->
		<table border="1">
			<tr>
				<td>제목</td>
				<td>등록일</td>
				<td onclick="location.href='./NoticeList.no'"
					style="cursor: Pointer">+</td>
			</tr>

			<%
			int index = 0;
			for (int i = count - pageSize * (currentPage - 1); i > count - pageSize * currentPage && i > 0; i--) {
				NoticeDTO dto = noticeList.get(index++);
			%>

			<tr onclick="location.href='./NoticeContent.no?num=<%=dto.getNotice_num()%>'" style="cursor: Pointer">

				<td><%=dto.getNotice_sub()%></td>

				<td colspan="2"><%=dto.getNotice_date()%></td>
			</tr>
			<%
			}
			%>
		</table>
		<!-- 리스트 보여주는 곳 -->
</body>
</html>