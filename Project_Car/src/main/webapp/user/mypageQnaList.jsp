<%@page import="com.qna.db.QnaDTO"%>
<%@page import="com.qna.db.QnaDTO"%>
<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link rel="stylesheet" href="./css/header.css"/>
<link rel="stylesheet" href="./css/footer.css"/>
<link rel="stylesheet" href="./css/mypageQnaList.css"/>
</head>
<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<div id="wrapper">
	<div class="myPage_menu">
		<div>
			<button onclick="location.href='./UserInfoReservation.us'">예약 조회</button>
			<button onclick="location.href='./ReviewList.re'">나의 후기</button>
			<button onclick="location.href='./UserQnaList.us'">문의내역</button>
			<button onclick="location.href='./UserInfo.us'">회원조회</button>
			<button onclick="location.href='./UserInfoDeleteForm.us'">회원탈퇴</button>
			<%
					String sessionId2 = (String)session.getAttribute("sessionId");
				if(sessionId2.equals("admin")) { %>
				<button onclick="location.href='./UserList.us'">회원목록</button>
				<% 	
					}%>
		</div>
	</div>
<%
String sessionId=(String)session.getAttribute("sessionId");
List<QnaDTO> mypageQnaList=(List<QnaDTO>)request.getAttribute("mypageQnaList");
int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
int count=(Integer)request.getAttribute("count");


QnaDTO dto = new QnaDTO();

if(sessionId==null){
	sessionId="null";
}
%>
<table id="qna">
<tr><td colspan="5"><a class = "page_box"><%=currentPage %>/<%=pageCount %>페이지(전체<%=count %>) </a></td></tr>
	<tr align ="center">
		<th>번호</th>
		<th width="100">글쓴이</th>
		<th width="500">제목</th>
		<th>등록일</th>
		<th>조회</th>
	</tr>
<%
	if(mypageQnaList.size()!=0){
		for(int i = 0; i<mypageQnaList.size(); i++){
			dto = mypageQnaList.get(i);
			%>
			<tr align ="center">
				<td><%=dto.getQna_index() %></td> 
				<td><%=dto.getUser_id() %></td> 
			<%
			if(dto.getQna_secret().equals("N") || sessionId.equals(dto.getUser_id()) || sessionId.equals("admin")){ %>
				<td align ="left" class="listSub"><a href="QnaContent.qn?qna_num=<%=dto.getQna_num()%>&qna_index=<%=dto.getQna_index() %>"><%=dto.getQna_sub() %></a></td> 
				<%
				} else {
				%>
					<td align ="left"> 비밀글입니다</td>
			<%
			}
			%>
					<td><%=dto.getQna_date() %></td>
					<td><%=dto.getQna_readcount() %></td></tr>
		<%
		}
		%>
	</table>
	<br>
<% 
	} else {
		%>
		<script>
			alert("문의 내역이 없습니다.");window.history.back();
		</script>
		<%
	}
%>
<div class="list_btn">
<%
// 10페이지 이전
if(startPage>pageBlock) {
%>
	<a href="UserQnaList.us?pageNum=<%=startPage-pageBlock %>"><<</a>
<%
}else {
	%>
	<a href="UserQnaList.us?pageNum=<%=startPage %>"><<</a>
<%
}
// 1페이지 이전
if(currentPage != 1) {
%>
	<a href="UserQnaList.us?pageNum=<%=currentPage-1 %>">이전</a>
<%
} else {
	%>
	<a href="UserQnaList.us?pageNum=<%=startPage %>">이전</a>
<%
}
for(int i=startPage; i<=endPage; i++){
%>
	<a class="list_num" href="UserQnaList.us?pageNum=<%=i%>"><%=i%></a>
<%
} 

// 1페이지 다음
if(currentPage < pageCount) {
	%>
	<a href="UserQnaList.us?pageNum=<%=currentPage+1 %>">다음</a>
	<%
} else {
	%>
	<a href="#">다음</a>
<%
}
%>
<%
//10페이지 다음
if(endPage < pageCount) {
	%>
	<a href="UserQnaList.us?pageNum=<%=startPage+pageBlock %>">>></a>
	<%
} else {
	%>
	<a href="UserQnaList.us?pageNum=<%=endPage %>">>></a>
<%
}
%>
</div>
<!-- <input type="button" value="글쓰기" onclick="location.href='./QnaWriteForm.qn'"><br> -->
<!-- <a href="./UserHome.us">메인으로 이동</a><br> -->
<!-- <a href="QnaWriteForm.qn">글쓰기</a><br> -->
</div>
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>