<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.review.db.ReviewDTO"%>
<%@page import="com.reservation.db.ReservationDTO"%>
<%@page import="com.car.db.CarInfoDTO"%>
<%@page import="com.car.db.CarInfoDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/carInfo.css" rel="stylesheet" type="text/css">
<link href="./css/header.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
	CarInfoDTO carDTO = (CarInfoDTO)request.getAttribute("carDTO");
	CarInfoDAO dao = new CarInfoDAO();
%>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<form action="./PaymentPro.res" method="get" onsubmit="return checkNull()">
	<input type="hidden" id="sessionId" value="<%=(String)session.getAttribute("sessionId")%>">
	<input type="hidden" name="car_num" value="<%=dao.getCarNum(carDTO.getCar_model())%>">
	<div id="wrapper">
		<div>
			<!-- 1. 차 이미지 정보 요약 -->
			<div>
				<!-- 요약 프레임 -->
				<div class="carMain_car_img">
					<!-- 이미지 프레임 -->
					<img src="./car_images/<%=carDTO.getCar_image() %>">
				</div>
			</div>

			<div class="carMain_summ">
				<div>
					<h4><%= carDTO.getCar_brand() %></h4>
					<h2><%= carDTO.getCar_model() %></h2>
					<p>
						<span>친환경 전기차 | 전기 | 1,600CC</span>
						<!-- 이건 없애도 될 듯? 임의로 넣어놨어 -->
					</p>
					<input type="checkbox" id="carMainBtn"> <label
						for="carMainBtn"><a href="#infoBox"><p>차량 정보</p></a></label>
					<!-- 차량정보 앵커 -->
					<input type="checkbox" id="likeBtn"> <label for="likeBtn">♥</label>
				</div>
			</div>
			<!-- 요약 프레임 끝 -->
		</div>
		<!-- 2. 차 이미지 정보 요약 끝-->
		<div class="carMain_detail" id="infoBox">
			<!-- 2. 차 렌트 정보 상세 + 차량정보 앵커 -->
			<nav>
				<a href="#carBrand">브랜드</a> <a href="#carType">차종</a> <a
					href="#carModel">모델</a> <a href="#carFuel">연료</a> <a
					href="#carYear">연식</a>
				<!--             <a href="#carOption">옵션</a> -->
				<!-- 이건 지울 거 -->
				<a href="#carPrice">가격</a>
			</nav>
			<span id="carBrand"></span>
			<!-- 브랜드 앵커 -->
			<div class="details_layer">
				<p class="d_l_title">
					STEP1 <span>브랜드</span>
				</p>
				<span id="carType"></span>
				<!-- 차종 앵커 -->
				<div class="d_layer1">
					<p>
						<span><%= carDTO.getCar_model()%></span> <label><input
							type="radio" name="brand" checked></label>
					</p>
				</div>
				<span id="carModel"></span>
				<!-- 모델 앵커 -->
				<p class="d_l_title">
					STEP2 <span>차종</span>
				</p>
				<div class="d_layer2">
					<label><input type="radio" name="car-Type" checked><%= carDTO.getCar_type() %></label>
				</div>
				<span id="carFuel"></span>
				<!-- 연료 앵커 -->
				<p class="d_l_title">
					STEP3 <span>모델</span>
				</p>
				<div class="d_layer3">
					<details open>
						<summary>그랜저</summary>
						<label><input type="radio" checked><%=carDTO.getCar_model() %></label>
					</details>
				</div>
				<span id="carYear"></span>
				<!-- 연식 앵커 -->
				<p class="d_l_title">
					STEP4 <span>연료</span>
				</p>
				<div class="d_layer4">
					<label><input type="radio" name="car-Fuel" checked><%= carDTO.getCar_fuel() %></label>
				</div>
				<!--             <span id="carOption"></span>옵션 앵커 -->
				<p class="d_l_title">
					STEP5 <span>연식</span>
				</p>
				<div class="d_layer5">
					<p><%= carDTO.getCar_year() %>년식
					</p>
				</div>
				<span id="carPrice"></span>
				<p class="d_l_title">
					STEP6 <span>시간당 가격</span>
				</p>
				<div class="d_layer7">
					<input type="text" id="price" value="<%=carDTO.getPer_hour()%>" readonly>원
				</div>
			</div>
		</div>
		<!-- 2. 차 렌트 정보 상세 끝 -->
		<div>
			<!-- 3. 차 렌트 정리, 예약 -->
			<div class="car_detail_box">
				<table border="1">
					<tr> 
						<td class="top" align="left" colspan="2">예약일시</td>
<!-- 					</tr> -->
<!-- 					<tr> -->
						<td class="content" colspan="2" align="left">
							<input id="selectedDate" style="border:none; width:100px"  name="selectedDate" value="" readonly></input>
							<input id="selectedTime" style="border:none"  name="selectedTime" value="" readonly></input><br>
						</td>
					</tr>
					<tr>
						<td class="top" align="left">결제가격</td>
<!-- 					</tr> -->
<!-- 					<tr> -->
						<td class="content" align="left" colspan="2">
							<input id="totalPrice"  style="border:none; text-align:right; width:100px" name="totalPrice" value="0" readonly>원</input>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td class="content" align="left" colspan="2"> -->
<!-- 						</td> -->
<!-- 					</tr> -->
				</table>
				<div class="month_box">
					<div>
						<table>
							<tr>
								<td>
							<!-- 달력 -->
									<table id="calendar" align="center">
										<tr>
											<td align="center"><label onclick="prevCalendar()"> ◀ </label></td>
											<td colspan="5" align="center" id="calendarTitle">yyyy년 m월</td>
											<td align="center"><label onclick="nextCalendar()"> ▶ </label></td>
										</tr>
										<tr>
											<td align="center"><font color="red">일</font></td>
											<td align="center">월</td>
											<td align="center">화</td>
											<td align="center">수</td>
											<td align="center">목</td>
											<td align="center">금</td>
											<td align="center"><font color="blue">토</font></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div id="scroll" style="height: 200px; overflow:auto">
<!-- 					<td>  -->
					
					<table id="timeTable"></table>
					
<!-- 					</td> -->
					</div>
				</div>
<!-- 				</tr> -->
				<ul>
					<li>
						<div>
							<strong>브랜드</strong>
							<div>
								<span><%= carDTO.getCar_brand() %></span>
							</div>
						</div>
					</li>
					<li>
						<div>
							<strong>차종</strong>
							<div>
								<span><%= carDTO.getCar_type() %></span>
							</div>
						</div>
					</li>
					<li>
						<div>
							<strong>모델</strong>
							<div>
								<span><%= carDTO.getCar_model() %></span>
							</div>
						</div>
					</li>
					<li>
						<div>
							<strong>연료</strong>
							<div>
								<span><%= carDTO.getCar_fuel() %></span>
							</div>
						</div>
					</li>
					<li>
						<div>
							<strong>연식</strong>
							<div>
								<span><%= carDTO.getCar_year() %></span>
							</div>
						</div>
					</li>
					<!--                <li> -->
					<!--                   <div> -->
					<!--                      <strong>옵션</strong> -->
					<!--                      <div> -->
					<!--                         <span>유아용 시트</span> -->
					<!--                         <span>네비게이션</span> -->
					<!--                         <span>하이패스</span> -->
					<!--                      </div> -->
					<!--                   </div> -->
					<!--                </li> -->
					<li>
						<div>
							<strong>시간 당 가격</strong>
							<div>
								<input type="text" value="<%=carDTO.getPer_hour()%>" readonly>원
							</div>
						</div>
					</li>
				</ul>
				<div class="book_box">
					<input type="submit" value="예약하기">
				</div>
			</div>
		</div>
		<!-- 3. 차 렌트 정리, 예약 끝 -->
		<div>
			<!-- 4. 리뷰 -->
<p>이용후기</p>			
<%
List<ReviewDTO> carReviewList=(List<ReviewDTO>)request.getAttribute("carReviewList");

int startPage=(Integer)request.getAttribute("startPage");
int pageBlock=(Integer)request.getAttribute("pageBlock");
int currentPage=(Integer)request.getAttribute("currentPage");
int endPage=(Integer)request.getAttribute("endPage");
int pageCount=(Integer)request.getAttribute("pageCount");
										 
%>
<div align="right">	
<%
//10페이지 이전
if(startPage > pageBlock){
	%>
	<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num() %>&pageNum=<%=startPage-pageBlock %>">[4 이전]</a>
	<%
}

//이전페이지 currentPage-1
if(currentPage > 1){
	%>
	<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num() %>&pageNum=<%=currentPage-1 %>">[이전]</a>
	<%
}

for(int i=startPage; i<=endPage; i++){
	%>
	<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num() %>&pageNum=<%=i %>"><%=i %></a>
	<%
}

// 다음페이지 currentPage+1
if(currentPage < pageCount){
	%>
	<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num() %>&pageNum=<%=currentPage+1 %>">[다음]</a>
	<%
}

//10페이지 다음
if(endPage < pageCount) {
	%>
	<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num() %>&pageNum=<%=startPage+pageBlock %>">[4다음]</a>
	<%
}
%>
</div>	

<div>
<% 
SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
	for(int i=0; i<carReviewList.size(); i++) {
		ReviewDTO dto = carReviewList.get(i);
%>			
		
		<div class="car_review_user">
		<span>유저명 : <%=dto.getUser_id() %></span> 
		<span>모델명 : <%=carDTO.getCar_model() %></span>
		<span height="100">별점 : 
<%-- 		<%=dto.getReview_star() %> --%>
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
			%></span>
<%-- 			<div class="car_review_cont"></div>--%>

			<span>내용 : <%=dto.getReview_content() %></span><br> 
			<span>날짜 : <%=dateFormat.format(dto.getReview_date()) %></span>
		</div>
	<%
	}
	%>	
	</div>
		<!-- 4. 리뷰 끝 -->
	</div>
		</form>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
	<script src="./JavaScript/calendar.js"></script>
	<script type="text/javascript">buildCalendar();</script>
</html>