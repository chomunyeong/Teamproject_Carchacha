<%@page import="com.qna_comm.db.QnaCommDAO"%>
<%@page import="com.qna_comm.db.QnaCommDTO"%>
<%@page import="com.qna.db.QnaDAO"%>
<%@page import="com.qna.db.QnaDTO"%>
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
<link rel="stylesheet" href="./css/qnaContent.css"/>
<script type="text/javascript" src="./script/jquery-3.6.3.js"></script>
<style>

</style>
<script type="text/javascript">
 	$(document).ready(function() {
		$('.deleteQna').submit(function(){
			if(!confirm ("삭제하시겠습니까?")){
				return false;
			}
		});
		
		$('.deleteComm').submit(function(){
			if(!confirm ("삭제하시겠습니까?")){
				return false;
			}
		});
 	});
</script>
</head>
<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<%
QnaDTO dto=(QnaDTO)request.getAttribute("dto");
QnaDAO dao=new QnaDAO();

int qna_num=dto.getQna_num();
String filepath = request.getSession().getServletContext().getRealPath("qna_images");
%>
<div class="qna_container">
<table style="margin:430px auto 0;" border="1" class="table">
	<tr>
		<th align ="center" width="80">
			글번호
		</th>
		<td width="400px">
			<%=dto.getQna_index() %>
		</td>
		<th align ="center" width="80">
			등록일
		</th>
		<td width="400px">
			<%=dto.getQna_date() %>
		</td>
	</tr>
	<tr class="user_date">
		<th align ="center">
			작성자
		</th>
		<td>
			<%=dto.getUser_id() %>
		</td>
		<th align ="center" >
			조회수
		</th>
		<td>
			<%=dto.getQna_readcount() %>
		</td>
	</tr>
	<tr>
		<th align ="center">
			제목
		</th>
		<td style="word-break:break-all" colspan="4">
			<%=dto.getQna_sub() %>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="word-break:break-all">
			<div class="content">
				<% 
				if(dto.getQna_image() != null){
				%>
					<img src="./qna_images/<%=dto.getQna_image() %>" width=350px height=190px style="margin: 0px; margin-right: 40px;"><br>
				<% 
				}
				%>
				<%=dto.getQna_content() %>
			</div>
<%
// 세션값 가져오기
String sessionId=(String)session.getAttribute("sessionId");
	if(sessionId==null){
		sessionId+="";
	}
	// 글쓴이와 로그인(세션값) 일치하면 => 글수정, 글삭제 버튼 보이기
	if(!sessionId.equals("null")){
		if(dto.getUser_id().equals(sessionId) || sessionId.equals("admin")){
%>
			<div>
				<form action="./QnaDelete.qn" method="get" class="deleteQna" align ="right">
					<input type="button" value="글수정" class="update"
						   onclick="location.href='QnaUpdateForm.qn?qna_num=<%=dto.getQna_num()%>&qna_index=<%=dto.getQna_index()%>'">
					<input type="hidden" name="qna_num" value="<%=dto.getQna_num()%>">
					<input type="submit" value="글삭제">
				</form>
			</div>
		</td>
		<%
		}
	}
	%>
	<tr>
		<td colspan="4">
			<h3>답글</h3>
			<%
			
			QnaCommDAO dao2 = new QnaCommDAO();
			int pageSize=10;
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null){
				pageNum="1";
			}
			int currentPage=Integer.parseInt(pageNum);
			int startRow=(currentPage-1)*pageSize+1;
			int endRow=startRow+pageSize-1;
			List<QnaCommDTO> commList = dao2.getCommList(startRow,pageSize,qna_num);
			int count=dao2.getQnaCommCount(qna_num);
			%>
	<table class="table">
		<tr>
			<th width="50px">
				번호
			</th>
			<th width="100px">
				작성자
			</th>
			<th width="500px">
				내용
			</th>
			<th width="200px">
				등록일
			</th>
		</tr>
		<%
		for(int i = 0; i<commList.size(); i++){
			int commIndex=1;
			QnaCommDTO dto2 = commList.get(i);
		%> 
			<tr>
				<td align="center">
					<%=dto2.getComm_index() %>
				</td>
				<td align="center">
					<%=dto2.getUser_id() %>
				</td>
				<td align="left" style="word-break:break-all">
					<%=dto2.getComm_content() %>
				</td> 
				<td align="center">
					<%=dto2.getComm_date() %>
				</td>
			<%
			if(!sessionId.equals("null")){
				if(sessionId.equals("admin") || dto2.getUser_id().equals(sessionId)) {
			%>
				<td>
					<input type="button" value="수정" 
					onclick="location.href='./QnaCommUpdateForm.co?qna_num=<%=dto.getQna_num() %>&comm_num=<%=dto2.getComm_num()%>&qna_index=<%=dto.getQna_index()%>'">
				</td>
				<td>
					<form action="./QnaCommDelete.co" method="get" class="deleteComm">
						<input type="hidden" name="qna_num" value="<%=dto.getQna_num()%>">
						<input type="hidden" name="comm_num" value="<%=dto2.getComm_num()%>">
						<input type="hidden" name="qna_index" value="<%=dto.getQna_index() %>">
						<input type="submit" value="삭제">
					</form>
				</td>
			</tr>
		<%
				}
			}
		}
		%>
	</table>
<%
System.out.println("qna_num = "+qna_num );
System.out.println("pageNum = "+pageNum );
int pageBlock=10;
int startPage=(currentPage-1)/pageBlock*pageBlock+1;
int endPage=startPage+pageBlock-1;
int pageCount = count/pageSize+(count%pageSize==0? 0 : 1);
if(endPage > pageCount) {
	endPage=pageCount;
}
%>
<div align="center" class="list_box">
<%
	//10페이지 이전
	if(startPage>pageBlock) {
		%>
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=startPage-pageBlock %>&qna_index=<%=dto.getQna_index()%>"><<</a>
		<%
	}else {
		%>
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=startPage %>&qna_index=<%=dto.getQna_index()%>"><<</a>
	<%
	}
	// 1페이지 이전
	if(currentPage != 1) {
		%>
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=currentPage-1 %>&qna_index=<%=dto.getQna_index()%>">이전</a>
		<%
	}else {
		%>
		<a href="#">이전</a>
	<%
	}
	for(int i=startPage; i<=endPage; i++){
		%>
		<a class="list_num" href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=i%>&qna_index=<%=dto.getQna_index()%>"><%=i%></a>
		<%
	}
	// 1페이지 다음
	if(currentPage < pageCount) {
		%>
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=currentPage+1 %>&qna_index=<%=dto.getQna_index()%>">다음</a>
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
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=startPage+pageBlock %>&qna_index=<%=dto.getQna_index()%>">>></a>
		<%
	} else {
		%>
		<a href="QnaContent.qn?qna_num=<%=qna_num %>&pageNum=<%=endPage %>&qna_index=<%=dto.getQna_index()%>">>></a>
	<%
	}
	%>
</div>
<br>
<%
if(!sessionId.equals("null")) {
	if(sessionId.equals("admin") || dto.getUser_id().equals(sessionId)) {
%>
		<form action="./QnaCommWritePro.co" method="post" style="text-align: center;">
			<input type="hidden" name="qna_num" value="<%=qna_num %>">
			<input type="hidden" name="user_id" value="<%=sessionId %>">
			<input type="hidden" name="qna_index" value="<%=dto.getQna_index() %>">
			<%
			if(sessionId.equals("admin")) { 
			%>
				<textarea name="comm_content" rows="5" cols="100" maxlength="1500" class="commtext" ><%=dto.getUser_id() %>님 문의 감사합니다. </textarea>
				<%
				}else {
					%>
					<textarea name="comm_content" rows="5" cols="100" maxlength="1500" class="commtext" ></textarea>
					<%
				} 
				%>
			<br>
			<input type="submit" value="전송" align="right">
		</form>
		</td>
	</tr>
	<tr>
		<td colspan="4">
			<div class="qna_btn">
				<% 
				int beforeQnaNum = dao.getBeforeQna(dto.getQna_num());
				int nextQnaNum = dao.getNextQna(dto.getQna_num());
				if(sessionId.equals("admin")){
					if(beforeQnaNum!=dto.getQna_num()) {
					%>
						<a href="QnaContent.qn?qna_num=<%=beforeQnaNum	%>&qna_index=<%=dto.getQna_index()-1 %>">이전글</a>
					<%
					}
					%>
					<% 
					if(nextQnaNum !=dto.getQna_num()) {
					%>
						| <a href="QnaContent.qn?qna_num=<%=nextQnaNum %>&qna_index=<%=dto.getQna_index()+1 %>">다음글</a>
					<%
					}
				} 
				%>
				<div>
					<input type="button" value="QnA목록" onclick="location.href='./QnaList.qn'">
				</div>
			</div>
		</td>
	</tr>
<%
	}
}
%>
</table>
</div>
<!-- footer -->
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>