<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.review.db.ReviewDTO"%>
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
<link rel="stylesheet" href="./css/reviewList.css"/>
<script type="text/javascript" src="./script/jquery-3.6.3.js"></script>
<script type="text/javascript">
$(document).ready(function() {
  // id="join"
		$('.review_delete').submit(function(){
			if(!confirm("삭제하시겠습니까")){
				return false;
			}
		});
});
				</script>
  
</head>
<body>
<%

List<ReviewDTO> reviewList=(List<ReviewDTO>)request.getAttribute("reviewList");
String sessionId=(String)session.getAttribute("sessionId");
int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
										 
%>
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
<div class="container">
  <table class="table table-striped">
    <thead>
      <tr>
      		<%
		if(sessionId.equals("admin")){
		%>
			<th>작성자</th>
		<% 
		}
		%>
<!--       	<th>번호<th> -->
        <th>상품</th>
        <th width="500">내용</th>
        <th>등록일</th>
<!--         <th>조회수</th> -->
      </tr>
    </thead>
    <tbody>
    
	<% 
// 	ReviewDTO dto = new ReviewDTO();
	SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
	if(reviewList.size()!=0){
		for(int i=0; i<reviewList.size(); i++) {
			ReviewDTO dto = reviewList.get(i);
			
			%>
			<tr>
			<%
			if(sessionId.equals("admin")){
			%>
				<td><%=dto.getUser_id() %></td>
			<%
			}
			%>
	<%-- 			<td><%=dto.getReview_num() %></td> --%>
				<td><img src="./car_images/<%=dto.getCar_image() %>" width="200"></td>
				<td style="word-break:break-all">
				<%
				if(dto.getReview_star().equals("1")){
					%>
					
					<img src="./review/img/star1.png" width="100" height="20 ">
					<%
				}else if(dto.getReview_star().equals("2")){
					%>
					<img src="./review/img/star2.png" width="100" height="20 ">
					<%
				}else if(dto.getReview_star().equals("3")){
					%>
					<img src="./review/img/star3.png" width="100" height="20 ">
					<%
				}else if(dto.getReview_star().equals("4")){
					%>
					<img src="./review/img/star4.png" width="100" height="20 ">
					<%	
				}else if(dto.getReview_star().equals("5")){
					%>
					<img src="./review/img/star5.png" width="100" height="20 ">
					<%	
				}else {
					dto.getReview_star();
				}
				%>
				<br>
				
				<%=dto.getReview_content() %></td>
			    <td><%=dateFormat.format(dto.getReview_date()) %></td>
				<td>
	<%-- 			<input type="button" value="수정" onclick="location.href='./ReviewUpdateForm.re?review_num=<%=dto.getReview_num() %>'"> --%>
	<%-- 			<input type="button" value="삭제" onclick="location.href='./ReviewDelete.re?review_num=<%=dto.getReview_num() %>'"> --%>
				
				
				  <form action="./ReviewDelete.re" class="review_delete" method="get">
			    	<input type="button" value="수정" onclick="location.href='./ReviewUpdateForm.re?review_num=<%=dto.getReview_num() %>'">
					<input type="hidden" name="review_num" value="<%=dto.getReview_num() %>">
					<input type="submit" value="삭제" >
				  </form>
				 
				</td>
			    <input type="hidden" name="user_id" value="<%=dto.getUser_id() %>" readonly>
			    </tr>
		<%
		}
	} else {
		%>
		<script>
			alert("리뷰 내역이 없습니다.");window.history.back();
		</script>
		<%
	}
		
	%>
		
    </tbody>
  </table>
  
<div class="list_box">
<%
//10페이지 이전
if(startPage > pageBlock){
	%>
	<a href="./ReviewList.re?pageNum=<%=startPage-pageBlock %>"><<</a>
	<%
}else{
	%>
	<a href="./ReviewList.re?pageNum=<%=startPage%>"><<</a>
	<%
}

//이전페이지 currentPage-1
if(currentPage > 1){
	%>
	<a href="./ReviewList.re?pageNum=<%=currentPage-1 %>">이전</a>
	<%
}else{
	%>
	<a href="./ReviewList.re?#">이전</a>
	<%
}

for(int i=startPage; i<=endPage; i++){
	%>
	<a class="list_num" href="./ReviewList.re?pageNum=<%=i %>"><%=i %></a>
	<%
}

// 다음페이지 currentPage+1
if(currentPage < pageCount){
	%>
	<a href="./ReviewList.re?pageNum=<%=currentPage+1 %>">다음</a>
	<%
}else{
	%>
	<a href="./ReviewList.re?#">다음</a>
	<%
}

//10페이지 다음
if(endPage < pageCount) {
	%>
	<a href="./ReviewList.re?pageNum=<%=startPage+pageBlock %>">>></a>
	<%
}else{
	%>
	<a href="./ReviewList.re?pageNum=<%=endPage%>">>></a>
	<%
}
%>
</div>
</div>
</div>
<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>