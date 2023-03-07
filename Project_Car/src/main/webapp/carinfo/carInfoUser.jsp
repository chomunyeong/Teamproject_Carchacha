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
<link href="../css/header.css" rel="stylesheet" type="text/css">
<link href="../css/carInfo.css" rel="stylesheet" type="text/css">
</head>

<script type="text/javascript">
var today = new Date();
function buildCalendar(){
  var row = null
  var cnt = 0;
  var calendarTable = document.getElementById("calendar");
  var calendarTableTitle = document.getElementById("calendarTitle");
  calendarTableTitle.innerHTML = today.getFullYear()+"년"+(today.getMonth()+1)+"월";
  
  var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
  var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
  while(calendarTable.rows.length > 2){
  	calendarTable.deleteRow(calendarTable.rows.length -1);
  }

  row = calendarTable.insertRow();
  for(i = 0; i < firstDate.getDay(); i++){
  	cell = row.insertCell();
  	cnt += 1;
  }

  row = calendarTable.insertRow();

  for(i = 1; i <= lastDate.getDate(); i++){
  	cell = row.insertCell();
  	cnt += 1;

    cell.setAttribute('id', i);
  	cell.innerHTML = i;
  	cell.align = "center";

    cell.onclick = function(){
    	clickedYear = today.getFullYear();
    	clickedMonth = ( 1 + today.getMonth() );
    	clickedDate = this.getAttribute('id');

    	clickedDate = clickedDate >= 10 ? clickedDate : '0' + clickedDate;
    	clickedMonth = clickedMonth >= 10 ? clickedMonth : '0' + clickedMonth;
    	clickedYMD = clickedYear + "-" + clickedMonth + "-" + clickedDate;

    	opener.document.getElementById("date").value = clickedYMD;
    	self.close();
    }

    if (cnt % 7 == 1) {
    	cell.innerHTML = "<font color=#F79DC2>" + i + "</font>";
    }

    if (cnt % 7 == 0){
    	cell.innerHTML = "<font color=skyblue>" + i + "</font>";
    	row = calendar.insertRow();
    }
  }

  if(cnt % 7 != 0){
  	for(i = 0; i < 7 - (cnt % 7); i++){
  		cell = row.insertCell();
  	}
  }
}

function prevCalendar(){
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	buildCalendar();
}

function nextCalendar(){
	today = new Date(today.getFullYear(), today.getMonth()+1, today.getDate());
	buildCalendar();
}
</script>

<body>
<%
String car_num = request.getParameter("car_num");
CarInfoDAO dao = new CarInfoDAO();
CarInfoDTO dto = dao.getCar(car_num);
%>
   <jsp:include page="../css/header.jsp"></jsp:include>
   <div id="wrapper">
      <div> <!-- 1. 차 이미지 정보 요약 -->
         <div> <!-- 요약 프레임 -->
            <div class="carMain_car_img"> <!-- 이미지 프레임 -->
               <img src="../car_images/<%= dto.getCar_image() %>">
            </div>
         </div>
         
         <div class="carMain_summ">
            <div>
               <h4><%= dto.getCar_brand() %></h4>
               <h2><%= dto.getCar_model() %></h2>
               <p>
                  <span>친환경 전기차 | 전기 | 1,600CC</span><!-- 이건 없애도 될 듯? 임의로 넣어놨어 -->
               </p>
               <input type="checkbox" id="carMainBtn">
               <label for="carMainBtn"><a href="#infoBox"><p>차량 정보</p></a></label><!-- 차량정보 앵커 -->
               <input type="checkbox" id="likeBtn">
               <label for="likeBtn">♥</label>
            </div>
         </div> <!-- 요약 프레임 끝 -->
      </div> <!-- 2. 차 이미지 정보 요약 끝-->
      <div class="carMain_detail" id="infoBox"><!-- 2. 차 렌트 정보 상세 + 차량정보 앵커 -->
         <nav>
            <a href="#carBrand">브랜드</a>
            <a href="#carType">차종</a>
            <a href="#carModel">모델</a>
            <a href="#carFuel">연료</a>
            <a href="#carYear">연식</a>
<!--             <a href="#carOption">옵션</a> --> <!-- 이건 지울 거 -->
            <a href="#carPrice">가격</a>
         </nav>
         <span id="carBrand"></span><!-- 브랜드 앵커 -->
         <div class="details_layer">
            <p class="d_l_title">
            STEP1
               <span>브랜드</span>
            </p>
            <span id="carType"></span><!-- 차종 앵커 -->
            <div class="d_layer1">
               <p>
                  <span><%= dto.getCar_model()%></span>
                  <label><input type="radio" name="brand" checked></label>
               </p>
            </div>
            <span id="carModel"></span><!-- 모델 앵커 -->
            <p class="d_l_title">
            STEP2
               <span>차종</span>
            </p>
            <div class="d_layer2">
               <label><input type="radio" name="car-Type" checked><%= dto.getCar_type() %></label>
            </div>
            <span id="carFuel"></span><!-- 연료 앵커 -->
            <p class="d_l_title">
            STEP3
               <span>모델</span>
            </p>
            <div class="d_layer3">
               <details open>
                  <summary>그랜저</summary>
                  <label><input type="radio">디 올 뉴 그랜저</label>
               </details>
            </div>
            <span id="carYear"></span><!-- 연식 앵커 -->
            <p class="d_l_title">
            STEP4
               <span>연료</span>
            </p>
            <div class="d_layer4">
               <label><input type="radio" name="car-Fuel" checked><%= dto.getCar_fuel() %></label>
            </div>
<!--             <span id="carOption"></span>옵션 앵커 -->
            <p class="d_l_title">
            STEP5
               <span>연식</span>
            </p>
            <div class="d_layer5">
               <p><%= dto.getCar_year() %></p>
            </div>
            <span id="carPrice"></span><!-- 가격 앵커 -->
            <p class="d_l_title">
            STEP7
               <span>가격</span>
            </p>
            <div class="d_layer7">
               <p><%= dto.getPer_hour() %></p>
            </div>
         </div>
      </div> <!-- 2. 차 렌트 정보 상세 끝 -->
      <div> <!-- 3. 차 렌트 정리, 예약 -->
        <div class="car_detail_box">
		<div class="month_box">
			<div>
				<table id="calendar" align="center"> <!-- 퍼온 거 -->
				<tr>
					<td align="center"><label onclick="prevCalendar()"> ◀ </label></td>
					<td colspan="5" align="center" id="calendarTitle">yyyy년 m월</td>
					<td align="center"><label onclick="nextCalendar()"> ▶ </label></td>
				</tr>
				<tr>
					<td align="center"><span style="color: red;">일</span></td>
					<td align="center">월</td>
					<td align="center">화</td>
					<td align="center">수</td>
					<td align="center">목</td>
					<td align="center">금</td>
					<td align="center"><span style="color: blue;">토</span></td>
				</tr>
				<script type="text/javascript">buildCalendar();</script>
			</table> <!--  퍼온 거 -->
			</div>
			<div></div>
		</div>
            <ul>
               <li>
                  <div>
                     <strong>브랜드</strong>
                     <div>
                        <span><%= dto.getCar_brand() %></span>
                     </div>
                  </div>
               </li>
               <li>
                  <div>
                     <strong>차종</strong>
                     <div>
                        <span><%= dto.getCar_type() %></span>
                     </div>
                  </div>
               </li>
               <li>
                  <div>
                     <strong>모델</strong>
                     <div>
                        <span><%= dto.getCar_model() %></span>
                     </div>
                  </div>
               </li>
               <li>
                  <div>
                     <strong>연료</strong>
                     <div>
                        <span><%= dto.getCar_fuel() %></span>
                     </div>
                  </div>
               </li>
               <li>
                  <div>
                     <strong>연식</strong>
                     <div>
                        <span><%= dto.getCar_year() %></span>
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
                        <span><%= dto.getPer_hour() %></span>
                     </div>
                  </div>
               </li>
            </ul>
            <div class="book_box">
               <button type="submit">예약하기</button>
            </div>
         </div>
         
      </div> <!-- 3. 차 렌트 정리, 예약 끝 -->
      <div> <!-- 4. 리뷰 -->
         <div>
            <div class="car_review_img">이미지</div>
            <div class="car_review_cont">내용</div>
            <div class="car_review_user">
               <span>유저명</span>
               <span>별점</span>
            </div>
         </div>
         <div>
            <div class="car_review_img">이미지</div>
            <div class="car_review_cont">내용</div>
            <div class="car_review_user">
               <span>유저명</span>
               <span>별점</span>
            </div>
         </div>
         <div>
            <div class="car_review_img">이미지</div>
            <div class="car_review_cont">내용</div>
            <div class="car_review_user">
               <span>유저명</span>
               <span>별점</span>
            </div>
         </div>
         <div>
            <div class="car_review_img">이미지</div>
            <div class="car_review_cont">내용</div>
            <div class="car_review_user">
               <span>유저명</span>
               <span>별점</span>
            </div>
         </div>
      </div> <!-- 4. 리뷰 끝 -->
   </div>
</body>
</html>