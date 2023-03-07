
<%@page import="com.user.db.UserDAO"%>
<%@page import="com.car.db.CarInfoDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.format.FormatStyle"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.reservation.db.ReservationDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/paymentform.css" rel="stylesheet">
</head>
<%
ReservationDTO res_dto = (ReservationDTO) request.getAttribute("resDTO");
CarInfoDTO car_dto = res_dto.getCar_dto();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
String startDate = res_dto.getRes_stime().split(" ~ ")[0].split(" ")[0];
String startTime = res_dto.getRes_stime().split(" ~ ")[0].split(" ")[1];
if (startTime.length() < 5)
	startTime = " 0" + startTime;
String userId = (String) session.getAttribute("sessionId");
int point = (Integer) session.getAttribute("user_pt");
System.out.println(point);
%>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<div id="wrapper">
		<img src="./car_images/<%=car_dto.getCar_image()%>" width="500">
		<input type="hidden" class="carNum" value="<%=car_dto.getCar_num()%>">
	<table>
		<tr>
			<th>예약자ID</th>
			<th><%=userId%></th>
		</tr>
		<tr>
			<th>차 모델</th>
			<th><%=car_dto.getCar_model()%></th>
			<!-- carinfo.getCarModel() -->
		</tr>
		<tr>
			<th>차 종류</th>
			<th><%=car_dto.getCar_type()%></th>
			<!-- carinfo.getCarType() -->
		</tr>
		<tr>
			<th>차 브랜드</th>
			<th><%=car_dto.getCar_brand()%></th>
			<!-- carinfo.getCarBrand() -->
		</tr>
		<tr>
			<th>차 연료</th>
			<th><%=car_dto.getCar_fuel() %></th>
			<!-- carinfo.getCarFuel() -->
		</tr>
		<tr>
			<th>대여 시간</th>
			<th><input type="hidden" class="stime" value="<%=res_dto.getRes_stime()%>"><%=res_dto.getRes_stime()%></th>
		</tr>
		<tr>
			<th>총 시간</th>
			<th><input type="hidden" class="time" value="<%=res_dto.getRes_time()%>"><%=res_dto.getRes_time()%></th>
		</tr>
		<tr>
			<th>결제가격</th>
			<th><input type="hidden" class="price" value="<%=res_dto.getRes_time() * res_dto.getCar_dto().getPer_hour()%>"><%=res_dto.getRes_time() * res_dto.getCar_dto().getPer_hour()%>원</th>
			<!-- * carinfo.price() -->
		</tr>
		<tr>
			<th>보유 포인트</th>
			<th><%=point%></th>
			<!-- * carinfo.price() -->
		</tr>
		<tr>
			<th>사용할 포인트</th>
			<th><input type="text" class="usePoint" value="0" oninput="this.value = this.value.replaceAll(/\D/g, '')"></th>
		<!-- * carinfo.price() -->
		</tr>
	</table>
	<input type="button" value="결제하기" id="order">
	</div>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(document).ready(function() {	
		var date = new Date;
		var now = date.getTime();
		
		IMP.init("imp51271655"); // 예: imp00000000

		$('#order').click(function() { // 성공 시 값 처리해주기 남음
			var usept = $(".usePoint").val();

			if (usept * 1 > <%=point%> * 1) {
				alert("사용 포인트 > 보유포인트");
				console.log("조건실행");
				return false;
			}
			if (usept < 0) {
				alert("사용 포인트 < 0")
				return false;
			}

			IMP.request_pay({
				pg : "html5_inicis",
				pay_method : "card",
				merchant_uid : "c" + now, 
				name : "CAR", // 상호명
				amount : $('.price').val() - usept, // 결제금액	
				buyer_name : "$('sessionId')", // 결제자 이름
			}, function(rsp) {
				if (rsp.success) {
					$.ajax({
						url : "./InsertReservation.res", // 예약 db처리 할 경로
						data : {
							res_num : rsp.merchant_uid,
							car_num : $('.carNum').val(),
							res_stime : $('.stime').val(),
							res_time : $('.time').val(),
							price : $('.price').val(),
							usePoint : usept
						}, // 예약에 들어갈 정보들
						success : function(data) {
							alert("예약이 완료되었습니다.");
							location.href = "./CarListUser.ci"; // 내 예약 목록
						}
					});
				} else {
					alert("결제에 실패하였습니다.");
					alert(rsp.error_msg);
				}
			});
		});
	});
</script>
</html>