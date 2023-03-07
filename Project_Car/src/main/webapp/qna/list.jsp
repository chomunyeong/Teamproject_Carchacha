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
<link rel="stylesheet" href="./css/qnalist.css"/>
</head>
<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<%
String sessionId=(String)session.getAttribute("sessionId");
List<QnaDTO> qnaList=(List<QnaDTO>)request.getAttribute("qnaList");
int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
QnaDTO dto = new QnaDTO();

if(sessionId==null){
	sessionId="null";
}

%>
<div id="wrapper">
	<div class="notice_top">
		<div class="notice_title">
			<h1>문의사항</h1>
			<p>궁금한 점을 남겨주세요.</p>
		</div>
	</div>
	<div>
		<div class="qna_cont">
			<table class="qna_table">
				<tr>
			<!-- 	<tr align ="center"> -->
					<th width="50px">
						번호
					</th>
					<th width="100px">
						글쓴이
					</th>
					<th width="500px">
						제목
					</th>
					<th width="100px">
						등록일
					</th>
					<th width="50px">
						조회
					</th>
				</tr>
					<%
					for(int i = 0; i<qnaList.size(); i++){
						dto = qnaList.get(i);
					%>
						<tr align ="center">
							<td>
								<%=dto.getQna_index() %>
							</td> 
							<td>
								<%=dto.getUser_id() %>
							</td> 
						<%
						if(dto.getQna_secret().equals("N") || sessionId.equals(dto.getUser_id()) || sessionId.equals("admin")){ %>
							<td class="listSub">
								<a href="QnaContent.qn?qna_num=<%=dto.getQna_num()%>&qna_index=<%=dto.getQna_index() %>">
									<%=dto.getQna_sub() %>
								</a>
							</td> 
							<%
							} else {
							%>
								<td align ="left"> 
									비밀글입니다
								</td>
						<%
						}
						%>
								<td>
									<%=dto.getQna_date() %>
								</td>
								<td>
									<%=dto.getQna_readcount() %>
								</td>
							</tr>
					<%
					}
					%>
			</table>
		</div>
		<br>
		<div class="list_box">
			<%
			// 10페이지 이전
			if(startPage>pageBlock) {
			%>
				<a href="QnaList.qn?pageNum=<%=startPage-pageBlock %>"><<</a>
			<%
			}else {
				%>
				<a href="QnaList.qn?pageNum=<%=startPage %>"><<</a>
			<%
			}
			// 1페이지 이전
			if(currentPage != 1) {
			%>
				<a href="QnaList.qn?pageNum=<%=currentPage-1 %>">이전</a>
			<%
			} else {
				%>
				<a href="QnaList.qn?pageNum=<%=startPage %>">이전</a>
			<%
			}
			for(int i=startPage; i<=endPage; i++){
			%>
				<a class="list_num" href="QnaList.qn?pageNum=<%=i%>"><%=i%></a>
			<%
			} 
			
			// 1페이지 다음
			if(currentPage < pageCount) {
				%>
				<a href="QnaList.qn?pageNum=<%=currentPage+1 %>">다음</a>
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
				<a href="QnaList.qn?pageNum=<%=startPage+pageBlock %>">>></a>
				<%
			} else {
				%>
				<a href="QnaList.qn?pageNum=<%=endPage %>">>></a>
			<%
			}
			%>
			<br>
			<input type="button" value="글쓰기" onclick="location.href='./QnaWriteForm.qn'">
			<!-- <a href="QnaWriteForm.qn">글쓰기</a><br> -->
		</div>
	</div>
</div>
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>