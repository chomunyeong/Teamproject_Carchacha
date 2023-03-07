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
<link href="./css/noticeList.css" rel="stylesheet">
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">

<!-- 조건검색클릭시 웹페이지 이동없이 searchField에 데이터 넣기 () -->
<script type="text/javascript">
	function selectSearchField() {
		var value = document.getElementById('searchField').value;
		document.getElementById('searchFieldHidden').value = value;
	}
</script>
<!-- 조건검색클릭시 웹페이지 이동없이 searchField에 데이터 넣기 () -->


</head>
<body>
<!-- 	헤더 -->
	<jsp:include page="../css/header.jsp"></jsp:include>
<!-- 	헤더 -->
<div id="wrapper">
	<div class="notice_top">
		<%
		List<NoticeDTO> noticeList = (List<NoticeDTO>) request.getAttribute("noticeList");
		//startPage pageBlock currentPage endPage pageCount
		int startPage = (Integer) request.getAttribute("startPage");
		int pageBlock = (Integer) request.getAttribute("pageBlock");
		int currentPage = (Integer) request.getAttribute("currentPage");
		int endPage = (Integer) request.getAttribute("endPage");
		int pageCount = (Integer) request.getAttribute("pageCount");
		int count = (Integer) request.getAttribute("count");
		int pageSize = (Integer) request.getAttribute("pageSize");
	
		String user_id = (String) session.getAttribute("sessionId");
		String searchText = request.getParameter("searchText");
		String searchField = request.getParameter("searchField");
		%>
			<div class="notice_title">
				<!-- 	<center> -->
				<h1>공지사항</h1>
				<p>고객님들께 알려드리는 공지사항입니다.</p>
				
				<!-- form 검색기능 -->
				<form method="post" name="search" action="./NoticeList.no">
					<table class="pull-right">
						<tr>
							<td>
								
								<!-- 1/8페이지  전체 등등 안내--> <!-- 조건검색 리스트-->
								<input type="hidden" id="searchFieldHidden" name="searchField" value="<%=searchField%>">
								<select class="form-control" id="searchField" name="searchField" onchange="selectSearchField()">
		
									<option value="0">선택</option>
		
									<%
									if (searchText == null) {
									%>
									<option value="notice_sub">제목</option>
									<%
									} else {
									%>
									<option value="notice_sub"
										<%=searchField.equals("notice_sub") ? "selected='selected'" : ""%>>제목</option>
									<%
									}
									%>
		
									<%
									if (searchText == null) {
									%>
									<option value="notice_content">내용</option>
									<%
									} else {
									%>
									<option value="notice_content"
										<%=searchField.equals("notice_content") ? "selected='selected'" : ""%>>내용</option>
									<%
									}
									%>
		
									<%
									if (searchText == null) {
									%>
									<option value="user_id">작성자</option>
									<%
									} else {
									%>
									<option value="user_id"
										<%=searchField.equals("user_id") ? "selected='selected'" : ""%>>작성자</option>
									<%
									}
									%>
							</select>
							</td>
		
							<!-- 조건검색 리스트 끝 -->
		
							<!-- 검색값-->
							<%
							if (searchText != null && !searchText.equals("")) {
							%>
							<td><input type="text" class="form-control"
								placeholder="검색어 입력" name="searchText" maxlength="100"
								value=<%=searchText%>></td>
							<%
							} else {
							%>
							<td><input type="text" class="form-control"
								placeholder="검색어 입력" name="searchText" maxlength="100"></td>
							<%
							}
							%>
							<td><button class="search_btn" type="submit" class="btn btn-success">검색</button></td>
							<!--검색값 끝-->
						</tr>
					</table>
				</form>
		</div> <!-- notice title end -->
	</div> <!-- noticeTop end -->
	<div class="notice_cont">
		
		<!-- 리스트 보여주는 곳 -->
		<table class="notice_table">
			<tr><td  colspan="7"><!-- 1/8페이지  전체 등등 안내--> <a class="page_box"><%=currentPage%>/<%=pageCount%>페이지(전체<%=count%>건)</a></td></tr>
			<tr>
				<td width = "50">번호</td>
				<td width = "100">글쓴이</td>
				<td width = "500">제목</td>
				<td width = "80">등록일</td>
				<td width = "50">조회수</td>
			</tr>
			<%
			int index = 0;
			for (int i = count - pageSize * (currentPage - 1); i > count - pageSize * currentPage && i > 0; i--) {

				NoticeDTO dto = noticeList.get(index++);
			%>
<%-- 			<tr onclick="location.href='./NoticeContent.no?num=<%=dto.getNotice_num()%>'" style="cursor: Pointer"> --%>
			<tr>
				<td><%=i%></td>
				<td><%=dto.getUser_id()%></td>
				<td width='150px' style="workd-break:break-all"><a href="./NoticeContent.no?num=<%=dto.getNotice_num()%>">
						<%=dto.getNotice_sub()%></a></td>
				<td><%=dto.getNotice_date()%></td>
				<td><%=dto.getNotice_readcount()%></td>
			</tr>
			<%
			}
			%>
		</table>
		<br><br>
		<div class="notice_list">
			<!-- 리스트 보여주는 곳 -->
			<%
			// 10페이지 이전
			if (searchText == null) {
				if (startPage > pageBlock) {
			%><a href="./NoticeList.no?pageNum=<%=startPage - pageBlock%>">
				[<<] </a>
			<%
			} else {
			%><a href="./NoticeList.no?pageNum=<%=startPage%>"><<</a>
			<%
			}
			} else {
			if (startPage > pageBlock) {
			%><a
				href="./NoticeList.no?pageNum=<%=startPage - pageBlock%>&searchText=<%=searchText%>&searchField=<%=searchField%>"><<</a>
			<%
			} else {
			%><a
				href="./NoticeList.no?pageNum=<%=startPage%>&searchText=<%=searchText%>&searchField=<%=searchField%>"><<</a>
			<%
			}
			}
			//10페이지 이전 끝
	
			// 1페이지 이전
			if (searchText == null) {
			if (currentPage > 1) {
			%><a href="./NoticeList.no?pageNum=<%=currentPage - 1%>">이전</a>
			<%
			} else {
			%><a href="./NoticeList.no?pageNum=<%=startPage%>">이전</a>
			<%
			}
			} else {
			if (currentPage > 1) {
			%><a
				href="./NoticeList.no?pageNum=<%=currentPage - 1%>&searchText=<%=searchText%>&searchField=<%=searchField%>">다음</a>
			<%
			} else {
			%><a
				href="./NoticeList.no?pageNum=<%=startPage%>&searchText=<%=searchText%>&searchField=<%=searchField%>">다음</a>
			<%
			}
			}
			//1페이지 이전 끝
	
			// 숫자로 페이지 이동
			for (int i = startPage; i <= endPage; i++) {
			if (searchText == null) {
			%><a class="list_num" href="./NoticeList.no?pageNum=<%=i%>"> <%=i%> 
			</a>
			<%
			} else {
			%><a class="list_num"
				href="./NoticeList.no?pageNum=<%=i%>&searchText=<%=searchText%>&searchField=<%=searchField%>">
				<%=i%>
			</a>
			<%
			}
			}
			// 숫자로 페이지 이동 끝	
	
			// 1페이지 다음
			if (searchText == null) {
			if (currentPage < pageCount) {
			%><a href="./NoticeList.no?pageNum=<%=currentPage + 1%>">다음</a>
			<%
			} else {
			%><a href="./NoticeList.no?pageNum=<%=pageCount%>">다음</a>
			<%
			}
			} else {
			if (currentPage < pageCount) {
			%><a
				href="./NoticeList.no?pageNum=<%=currentPage + 1%>&searchText=<%=searchText%>&searchField=<%=searchField%>">다음</a>
			<%
			} else {
			%><a
				href="./NoticeList.no?pageNum=<%=pageCount%>&searchText=<%=searchText%>&searchField=<%=searchField%>">다음</a>
			<%
			}
			}
			//1페이지 다음 끝
	
			//10페이지 다음
			if (searchText == null) {
			if (endPage < pageCount) {
			%><a href="./NoticeList.no?pageNum=<%=startPage + pageBlock%>">>></a>
			<%
			} else {
			%><a href="./NoticeList.no?pageNum=<%=pageCount%>">>></a>
			<%
			}
			} else {
			if (endPage < pageCount) {
			%><a
				href="./NoticeList.no?pageNum=<%=startPage + pageBlock%>&searchText=<%=searchText%>&searchField=<%=searchField%>">>></a>
			<%
			} else {
			%><a
				href="./NoticeList.no?pageNum=<%=pageCount%>&searchText=<%=searchText%>&searchField=<%=searchField%>">>></a>
			<%
			}
			}
			%>
			<!-- 10페이지 다음 -->
		</div>


		<!-- 글쓰기 버튼 -->
		<%
		if (user_id != null) {
			if (user_id.equals("admin")) {
		%>
		<form method="post" name="serach" action="./NoticeWriteForm.no">
			<button class="write_btn" type="submit" class="search">글쓰기</button>
		</form>
		<%
		}
		}
		%>
		<!-- 글쓰기 버튼 -->
	</div>
</div><!-- wrapper end -->
<!-- footer -->
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>