<%@page import="com.car.db.CarInfoDTO"%>
<%@page import="javax.swing.plaf.synth.SynthOptionPaneUI"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function deleteCheck() {
		if(!confirm("삭제 하시겠습니까?")){
			alert("O");	
			return false;
		}else{
			alert("X");			
		}
</script>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
</head>
<body>
<%
// request.setCharacterEncoding("utf-8");
String id=(String)session.getAttribute("id");
List<CarInfoDTO> carList=(List<CarInfoDTO>)request.getAttribute("carList");
int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
CarInfoDTO dto = new CarInfoDTO();
%>

<%
	for(int i = 0; i<carList.size(); i++){
		dto = carList.get(i);
		%>
		<table border="1">
			<tr>
				<td>
					<img src="./car_images/<%=dto.getCar_image() %>" width=350px height=190px style="margin: 0px; margin-right: 40px;">
				</td>
				<td>
					<table border="1">
						<tr>
							<td align="center">차번호</td><td><%=dto.getCar_num() %></td>
						</tr>
						<tr>
							<td align="center">지점</td><td><%=dto.getCar_place() %></td>
						</tr>
						<tr>
							<td align="center">시간당 가격</td><td><%=dto.getPer_hour() %></td>
						</tr>
						<tr>
							<td align="center">차종</td><td><%=dto.getCar_type() %></td>
						</tr>
						<tr>
							<td align="center">연식</td><td><%=dto.getCar_year() %></td>
						</tr>
						<tr>
							<td align="center">모델명</td><td><%=dto.getCar_model() %></td>
						</tr>
						<tr>
							<td align="center">브렌드</td><td><%=dto.getCar_brand() %></td>
						</tr>
						<tr>
							<td align="center">연료</td><td><%=dto.getCar_fuel() %></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			<% 
			if(id.equals("admin")) {
			%>
				<input type="button" value="수정" onclick="location.href='./CarUpdateForm.ci?car_num=<%=dto.getCar_num() %>'"> 
				<input type="button" value="삭제" onsubmit="location.href='./CarDelete.ci?car_num=<%=dto.getCar_num() %>&car_image=<%=dto.getCar_image() %>'" onclick="return confirm('정말로 삭제하시겠습니까?')">
				<a href="./CarDelete.ci?car_num=<%=dto.getCar_num() %>&car_image=<%=dto.getCar_image() %>">삭제</a>
				<a href="./CarUpdateForm.ci?car_num=<%=dto.getCar_num() %>">수정</a>
			<%
			}
			%>
	<hr>
	<%
	}
	%>
<br>

<%
// System.out.println("endPage="+endPage);
// 10페이지 이전
if(startPage>pageBlock) {
	%>
	<a href="CarList.ci?pageNum=<%=startPage-pageBlock %>">[10이전]</a>
	<%
}

// 1페이지 이전
if(currentPage != 1) {
	%>
<%-- 	<a href="list.jsp?pageNum=<%=currentPage-1 %>">[이전]</a> --%>
	<%
}
for(int i=startPage; i<=endPage; i++){
	%>
	<a href="CarList.ci?pageNum=<%=i%>"><%=i%></a>
	<%
}

// 1페이지 다음
if(currentPage < pageCount) {
	%>
<%-- 	<a href="list.jsp?pageNum=<%=currentPage+1 %>">[다음]</a> --%>
	<%
}

//10페이지 다음
if(endPage < pageCount) {
	%>
	<a href="CarList.ci?pageNum=<%=startPage+pageBlock %>">[10다음]</a>
	<%
}
%>
<br>
<input type="button" value="메인으로 이동" onclick="location.href='./MemberMain.me'"> 
<%
if(id.equals("admin")) {
%>
| <input type="button" value="차량정보 등록" onclick="location.href='./CarInsertForm.ci'">
<%
}
%>
</body>
</html>