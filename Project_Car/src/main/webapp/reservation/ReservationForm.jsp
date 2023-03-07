<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.review.db.ReviewDTO"%>
<%@page import="com.reservation.db.ReservationDTO"%>
<%@page import="com.car.db.CarInfoDTO"%>
<%@page import="com.car.db.CarInfoDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/carInfo.css" rel="stylesheet" type="text/css">
<link href="./css/header.css" rel="stylesheet" type="text/css">
<link href="./css/footer.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%
	CarInfoDTO carDTO = (CarInfoDTO) request.getAttribute("carDTO");
	CarInfoDAO dao = new CarInfoDAO();
	Map<String, List<Integer>> car_res = (Map<String, List<Integer>>)request.getAttribute("car_res");
	System.out.println(car_res);
	
	%>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<form action="./PaymentPro.res" method="get"
		onsubmit="return checkNull()">
		<input type="hidden" id="sessionId"
			value="<%=(String) session.getAttribute("sessionId")%>"> <input
			type="hidden" name="car_num" value="<%=carDTO.getCar_num()%>">
		<div id="wrapper">
			<!-- 1. 차 이미지 정보 요약 -->
			<div>
				<div>
					<!-- 요약 프레임 -->
					<div class="carMain_car_img">
						<!-- 이미지 프레임 -->
						<img src="./car_images/<%=carDTO.getCar_image()%>">
					</div>
				</div>
				<!-- 차정보 요약 -->
				<div class="carMain_summ">
					<div>
						<h4><%=carDTO.getCar_brand()%></h4>
						<h2><%=carDTO.getCar_model()%></h2>
						<p>
							<span>친환경 전기차 | 전기 | 1,600CC</span><!-- 수정 -->
							<!-- 차종/연료/연식 -->
						</p>
						<input type="checkbox" id="carMainBtn"> <label
							for="carMainBtn"><a href="#infoBox"><p>차량 정보</p></a></label>
						<!-- 차량정보 앵커 -->
						<input type="checkbox" id="likeBtn"> <label for="likeBtn">♥</label>
					</div>
				</div>
				<!-- 요약 프레임 끝 -->
			</div>
			<!-- 1. 차 이미지 정보 요약 끝-->

			<!-- 2. 차 렌트 정보 상세 + 차량정보 앵커 -->
			<div class="carMain_detail" id="infoBox">
				<nav>
					<a href="#carBrand">브랜드</a> <a href="#carType">차종</a> <a
						href="#carModel">모델</a> <a href="#carFuel">연료</a> <a
						href="#carYear">연식</a> <a href="#carPrice">가격</a>
				</nav>
				<span id="carBrand"></span>
				<!-- (1) 브랜드 앵커 -->
				<div class="details_layer">

					<!-- 스텝1. 브랜드 -->
					<p class="d_l_title">
						STEP1 <span>브랜드</span>
					</p>
					<span id="carType"></span>
					<!-- 차종 앵커 -->
					<div class="d_layer1">
						<p>
							<span><%=carDTO.getCar_model()%></span> <label> <input
								type="radio" name="brand" checked></label>
						</p>
					</div>

					<span id="carModel"></span>
					<!-- (2) 모델 앵커 -->

					<!-- 스텝2. 차종 -->
					<p class="d_l_title">
						STEP2 <span>차종</span>
					</p>
					<div class="d_layer2">
						<label><input type="radio" name="car-Type" checked><%=carDTO.getCar_type()%></label>
					</div>

					<span id="carFuel"></span>
					<!-- (3) 연료 앵커 -->

					<!-- 스텝3. 모델 -->
					<p class="d_l_title">
						STEP3 <span>모델</span>
					</p>
					<div class="d_layer3">
						<details open>
							<summary>그랜저</summary>
							<label><input type="radio" checked><%=carDTO.getCar_model()%></label>
						</details>
					</div>

					<span id="carYear"></span>
					<!-- (4) 연식 앵커 -->

					<!-- 스텝4. 연료 -->
					<p class="d_l_title">
						STEP4 <span>연료</span>
					</p>
					<div class="d_layer4">
						<label><input type="radio" name="car-Fuel" checked><%=carDTO.getCar_fuel()%></label>
					</div>

					<!-- 스텝5. 연식 -->
					<p class="d_l_title">
						STEP5 <span>연식</span>
					</p>
					<div class="d_layer5">
						<p><%=carDTO.getCar_year()%>년식
						</p>
					</div>

					<span id="carPrice"></span>
					<!-- (5) 가격 앵커 -->

					<!-- 스텝6. 시간당 가격 -->
					<p class="d_l_title">
						STEP6 <span>시간당 가격</span>
					</p>
					<div class="d_layer6">
						<input type="text" id="price" value="<%=carDTO.getPer_hour()%>" readonly>원
					</div>
				</div>
			</div>
			<!-- 2. 차 렌트 정보 상세 끝 -->

			<!-- 3. 차 렌트 정리, 예약 -->
			<div>
				<div class="car_detail_box">
					<!-- 예약, 결제 가격 위에 있는거 -->
					<div class="month_box">
						<div>
							<!-- 달력 -->
							<table id="calendar" align="center">
								<tr>
									<td align="center"><label onclick="prevCalendar()">
											◀ </label></td>
									<td colspan="5" align="center" id="calendarTitle">yyyy년 m월</td>
									<td align="center"><label onclick="nextCalendar()">
											▶ </label></td>
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
						</div>
						<!-- 달력 끝 -->
						<div id="scroll" style="height: 200px; overflow: auto;">
							<table id="timeTable"></table>
						</div>
						<div>
							<!-- 						<table> -->
							<!-- 							<tr>  -->
							<!-- 								<td class="top" align="left" colspan="2">예약일시</td> -->
							<!-- 								<td class="content" colspan="2" align="left"> -->
							<!-- 									<input id="selectedDate" style="border:none; width:100px"  name="selectedDate" value="" readonly> -->
							<!-- 									<input id="selectedTime" style="border:none"  name="selectedTime" value="" readonly><br> -->
							<!-- 								</td> -->
							<!-- 							</tr> -->
							<!-- 							<tr> -->
							<!-- 								<td class="top" align="left">결제가격</td> -->
							<!-- 								<td class="content" align="left" colspan="2"> -->
							<!-- 									<input id="totalPrice"  style="border:none; text-align:right; width:100px" name="totalPrice" value="0" readonly>원 -->
							<!-- 								</td> -->
							<!-- 							</tr> -->
							<!-- 						</table> -->
							<!-- p태그 -->
							<p> 
								예약일시<br> <input id="selectedDate" name="selectedDate"
									value="" readonly> <input id="selectedTime"
									name="selectedTime" value="" readonly>
							</p>
							<p>
								결제가격<br> <input id="totalPrice" name="totalPrice" value="0"
									readonly>원
							</p>
						</div>
					</div>
					<!-- 				</tr> -->
					<ul>
						<li>
							<div>
								<strong>브랜드</strong>
								<div>
									<span><%=carDTO.getCar_brand()%></span>
								</div>
							</div>
						</li>
						<li>
							<div>
								<strong>차종</strong>
								<div>
									<span><%=carDTO.getCar_type()%></span>
								</div>
							</div>
						</li>
						<li>
							<div>
								<strong>모델</strong>
								<div>
									<span><%=carDTO.getCar_model()%></span>
								</div>
							</div>
						</li>
						<li>
							<div>
								<strong>연료</strong>
								<div>
									<span><%=carDTO.getCar_fuel()%></span>
								</div>
							</div>
						</li>
						<li>
							<div>
								<strong>연식</strong>
								<div>
									<span><%=carDTO.getCar_year()%></span>
								</div>
							</div>
						</li>
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
				<!-- 				<p>이용후기</p> -->
				<%
				List<ReviewDTO> carReviewList = (List<ReviewDTO>) request.getAttribute("carReviewList");

				int startPage = (Integer) request.getAttribute("startPage");
				int pageBlock = (Integer) request.getAttribute("pageBlock");
				int currentPage = (Integer) request.getAttribute("currentPage");
				int endPage = (Integer) request.getAttribute("endPage");
				int pageCount = (Integer) request.getAttribute("pageCount");
				%>

				<div class="review_cont">
					<%
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
					for (int i = 0; i < carReviewList.size(); i++) {
						ReviewDTO dto = carReviewList.get(i);
					%>

					<div class="car_review_user">
						<span><%=dto.getUser_id()%></span>
						<span><%=carDTO.getCar_model()%></span>
						<span height="100">
							<%
							if (dto.getReview_star().equals("1")) {
							%> <img src="./review/img/star1.png" width="100" height="20 ">
							<%
							} else if (dto.getReview_star().equals("2")) {
							%> <img src="./review/img/star2.png" width="100" height="20 ">
							<%
							} else if (dto.getReview_star().equals("3")) {
							%> <img src="./review/img/star3.png" width="100" height="20 ">
							<%
							} else if (dto.getReview_star().equals("4")) {
							%> <img src="./review/img/star4.png" width="100" height="20 ">
							<%
							} else if (dto.getReview_star().equals("5")) {
							%> <img src="./review/img/star5.png" width="100" height="20 ">
							<%
							} else {
							dto.getReview_star();
							}
							%>
						</span>
						<span>내용 : <%=dto.getReview_content()%></span><br> <span>날짜 : <%=dateFormat.format(dto.getReview_date())%></span>
					</div>
					<%
					}
					%>
				</div>
				<!-- 4. 리뷰 끝 -->
				<div align="right" class="list_box">
					<%
					//10페이지 이전
					if (startPage > pageBlock) {
					%>
					<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num()%>&pageNum=<%=startPage - pageBlock%>"><<</a>
					<%
					}

					//이전페이지 currentPage-1
					if (currentPage > 1) {
					%>
					<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num()%>&pageNum=<%=currentPage - 1%>">이전</a>
					<%
					}

					for (int i = startPage; i <= endPage; i++) {
					%>
					<a class="list_num" href="./ReservationMain.res?car_num=<%=carDTO.getCar_num()%>&pageNum=<%=i%>"><%=i%></a>
					<%
					}

					// 다음페이지 currentPage+1
					if (currentPage < pageCount) {
					%>
					<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num()%>&pageNum=<%=currentPage + 1%>">다음</a>
					<%
					}

					//10페이지 다음
					if (endPage < pageCount) {
					%>
					<a href="./ReservationMain.res?car_num=<%=carDTO.getCar_num()%>&pageNum=<%=startPage + pageBlock%>">>></a>
					<%
					}
					%>
				</div>
			</div>
			<div><jsp:include page="../css/footer.jsp"></jsp:include></div>
		</div>
	</form>

</body>
<script type="text/javascript">
//---------------- calendar table --------------------------

//달력 설정
var today = new Date();

var date = new Date();
//사용자가 클릭한 셀 객체 저장
var selectedCell;
//오늘 기준으로 불현하는 월. 일 객체
var realMonth = date.getMonth()+1;
var realToDay = date.getDate();
//사용자가 클릭한 일자의 월, 일 객체
var selectedMonth = null;
var selectedDate = null;

function buildCalendar(){
	var row = null;
	var cnt = 0;
	
	firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
		
	nowMonth = today.getMonth()+1;
	monthEquals = thisMonth(nowMonth, realMonth);
	
	var calendarTable = document.getElementById("calendar");
	var calendarTableTitle = document.getElementById("calendarTitle");
	calendarTableTitle.innerHTML = today.getFullYear()+"년"+(today.getMonth()+1)+"월";
	
	// 현재 달의 첫날과 마지막날
	var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
	
	// 달력 초기화
	while(calendarTable.rows.length > 2){
		calendarTable.deleteRow(calendarTable.rows.length -1);
	}
	
	row = calendarTable.insertRow();
	// 달력의 첫쨰줄 빈칸 채우기
	for(i = 0; i < firstDate.getDay(); i++){
		cell = row.insertCell();
		cell.innerHTML = null;
		cnt += 1;
	}
	
	// 달력에 요일 채우기
	for(i = 1; i <= lastDate.getDate(); i++){
		noCount = 0;
		
		cell = row.insertCell();
		
		cell.setAttribute('id', i);
		cell.innerHTML = i;
		cell.align = "center";
		cnt += 1;
		
 	if (cnt % 7 == 1) {
			cell.innerHTML = "<font color=#F79DC2>" + i + "</font>";
		}  
		
		if (cnt % 7 == 0){
			cell.innerHTML = "<font color=skyblue>" + i + "</font>";
			row = calendar.insertRow();
		}
		
		etp = exchangeToPosibleDay(cnt)*1;
		
		if (nowMonth == realMonth && i <= realToDay) {
				noCount +=1;
	    } else if (nowMonth > realMonth && i > realToDay) {
				noCount +=1;
	    }
	    
		if (noCount > 0){
			cell.style.backgroundColor = "#E0E0E0";
			cell.innerHTML = "<font color='#C6C6C6' >" + i + "</font>";
		} else {
			console.log("cell 클릭생성");
			cell.onclick = function(){
				selectedTimeAndTotalPriceInit();
				console.log("cell 클릭함");
				clickedYear = today.getFullYear();
				clickedMonth = ( 1 + today.getMonth() );
				clickedDate = this.getAttribute('id');
	
				clickedDate = clickedDate >= 10 ? clickedDate : '0' + clickedDate;    
				clickedMonth = clickedMonth >= 10 ? clickedMonth : '0' + clickedMonth;
				clickedYMD = clickedYear + "-" + clickedMonth + "-" + clickedDate;
				
				
				//하단에 예약일시 표시
				inputField = document.getElementById("selectedDate");
				inputField.value = clickedYMD;
				//선택된 월, 일 변수 저장
				selectedMonth = today.getMonth() + 1;
				selectedDate = this.getAttribute('id');
				
				//선택된 셀 색 변화
				if(selectedCell != null){
					selectedCell.bgColor = "transparent";
				}
				
				selectedCell = this;
				this.bgColor = "#fbedaa";
				
				//time table 생성
				timeTableMaker(today.getMonth() + 1,this.getAttribute('id'));
			}
		}
	} 

	// 선택한 날짜 출력
	
	// 달력의 마지막행 빈칸 채우기
	if(cnt % 7 != 0){
		for(i = 0; i < 7 - (cnt % 7); i++){
			cell = row.insertCell();
		}
	}
}

//이전달 이동
function prevCalendar(){
	if (today.getMonth() < realMonth){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");	
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	buildCalendar();
}

//다음달 이동
function nextCalendar(){
	if(today.getMonth()+1 == (realMonth + 1)){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()+1, today.getDate());
	buildCalendar();
}

function exchangeToPosibleDay(num){
	result = num % 7;
	result -= 1;
	if (result == -1) {
		result = 6;
	}
	return result;
}

function thisMonth(todayMonth, dateMonth){
	if (todayMonth*1 == dateMonth*1){
		return 0;
	} 
	return 1;
}

//---------------- time table --------------------------
var price = document.getElementById("price");
var startTime = "0";
var endTime = "24";
//선택된 시간중 가장 빠른/늦은 시간;
var selectedFirstTime = 24*1;
var selectedFinalTime = 0*1;

//예약시간표를 만들 table객체 획득

function timeTableMaker(selectedMonth, selectedDate){
	row = null
	month = selectedMonth + "";
	day = selectedDate + "";
	if(month.length == 1){
		month = "0" + month;
	}
	if(day.length == 1){
		day = "0" + day;
	}
	var fdate = "2023"+month+day;
	console.log(fdate);
	var timeTable = document.getElementById("timeTable");
	//테이블 초기화
	while(timeTable.rows.length > 0){
		timeTable.deleteRow(timeTable.rows.length-1);
	}
	
	for (i = 0; i < endTime - startTime; i++){
		//곱해서 숫자타입으로 변환
		cellTime = startTime*1 + i;
		
		cellStartTimeText = cellTime + ":00";
		cellEndTimeText = (cellTime + 1) + ":00";
		inputCellText = cellStartTimeText + " ~ " +  cellEndTimeText;
		
		//셀 입력을 위해 테이블 개행
		row = timeTable.insertRow();
		//해당 row의 셀 생성
		cell = row.insertCell();
		//cell에 id 부여
		cell.setAttribute('id', cellTime);
		//셀에 입력
		cell.innerHTML = inputCellText;
		//클릭이벤
// 		car_res["2023011901"].indexOf(8)
		debugger;
		if(car_res[fdate] != null){
			if(car_res[fdate].indexOf(cellTime) > -1){
				cell.bgColor = "#d3d3d3";
					cell.onclick = function(){
						alert("이미 예약된 시간입니다.")
				}
			}
		} else{
		cell.onclick = function(){
			cellTime = this.getAttribute('id');
			cellTime = cellTime*1;
			console.log("first : " + selectedFirstTime + ", selectedFinalTime : " + selectedFinalTime + ", selected : " + cellTime);
			//예약일시 입력처리
			if (selectedFirstTime != 24 && selectedFinalTime != 0){
				if(cellTime < selectedFirstTime - 1){
					alert("연속한 시간만 예약가능합니다.");
					return false;
				}
				if (cellTime > selectedFinalTime + 1){
					alert("연속한 시간만 예약가능합니다.");
					console.log(cellTime + ">" + selectedFinalTime + 1)
					return false;
				}
			}
			this.bgColor = "#fbedaa";
			if (cellTime < selectedFirstTime) {
				selectedFirstTime = cellTime
			}
			if (cellTime > selectedFinalTime) {
				selectedFinalTime = cellTime
			}
			
			//하단의 예약일시에 시간 표시
			resTime  = selectedFirstTime + ":00 ~ " + (selectedFinalTime + 1) + ":00";
		
			resTimeForm = document.getElementById("selectedTime");
			resTimeForm.value = resTime;
			
			//하단의 결제정보에 가격정보 표시
			useTime = (selectedFinalTime + 1) - selectedFirstTime;
			
			useTimeForm = document.getElementById("totalPrice");
			useTimeForm.value = useTime * price.value;
			
		}
		}
	}
}
	//시간표 초기화
	function tableinit(){
		timeTableMaker(selectedMonth, selectedDate);
		selectedTimeAndTotalPriceInit();
		buildCalendar();
	}
	
	//날자 클릭시 예약시간 및 결제정보 초기화
	function selectedTimeAndTotalPriceInit(){
		resDateForm = document.getElementById("selectedDate");
		resTimeForm = document.getElementById("selectedTime");
		resTimeForm.value = "";
		resDateForm.value = "";
		
		useTimeForm = document.getElementById("totalPrice");
		useTimeForm.value = "";
		
		selectedFirstTime = 24*1;
		selectedFinalTime = 0*1;
	}
	
		function checkNull(){
		userId = document.getElementById("sessionId");
		resDateForm = document.getElementById("selectedDate");
		resTimeForm = document.getElementById("selectedTime");
		
		if(userId.value == 'null'){
			alert("로그인해주세요.");
			return false;
		} else if(resDateForm.value == ""){
			alert("날짜를 선택해주세요.");
			return false;
		} else if(resTimeForm.value == ""){
			alert("시간을 선택해주세요.");
			return false;
		}
		return true;
	}

		buildCalendar();
</script>

<script type="text/javascript">
	debugger;
	let car_res = JSON.parse('${car_res}'.replaceAll("=", ":"));
</script>

</html>