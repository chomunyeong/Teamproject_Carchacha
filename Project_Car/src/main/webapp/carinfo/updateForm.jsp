<%@page import="com.car.db.CarInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/carinfoUpdateForm.css" rel="stylesheet">
<script type="text/javascript">
function check() {
	car_num = document.getElementById("car_num")
	
	if (document.getElementById("car_num").value=="") {
		document.getElementById("div").innerHTML="차 번호를 입력하시오.";
		document.getElementById("car_num").focus();
		return false;
	}
	if (document.getElementById("car_place").value=="") {
		document.getElementById("div").innerHTML="지역을 입력하시오.";
		document.getElementById("car_place").focus();
		return false;
	}
	if (document.getElementById("per_hour").value=="") {
		document.getElementById("div").innerHTML="시간당 금액을 입력하시오.";
		document.getElementById("per_hour").focus();
		return false;
	}
	if (document.getElementById("car_type").value=="") {
		document.getElementById("div").innerHTML="차종을 선택하시오.";
		return false;
	}
	if (document.getElementById("car_year").value=="") {
		document.getElementById("div").innerHTML="연식을 선택하시오."
		document.getElementById("car_year").focus();
		return false;
	}
	if (document.getElementById("car_model").value=="") {
		document.getElementById("div").innerHTML="모델을 입력하시오."
		document.getElementById("car_model").focus();
		return false;
	}
	if (document.getElementById("car_brand").value=="") {
		document.getElementById("div").innerHTML="브렌드를 입력하시오."
		document.getElementById("car_brand").focus();
		return false;
	}
	if (document.getElementById("car_fuel").value=="") {
		document.getElementById("div").innerHTML="연료를 입력하시오."
		document.getElementById("car_fuel").focus();
		return false;
	}
}
</script>
</head>
<body>
<%
CarInfoDTO dto=(CarInfoDTO)request.getAttribute("dto");
String car_type =dto.getCar_type();
%>
	<div class="carPage_1">
		<div>
				<form action="CarUpdatePro.ci" method="post" enctype="multipart/form-data" onsubmit="return check()">
					<div class="carinfo">
						<h1>차 정보 등록</h1>
						차번호: <input type="text" name="car_num" id="car_num" value="<%=dto.getCar_num()%>" readonly><br>
						<hr>
						지역	: <input type="text" name="car_place" id="car_place" value="<%=dto.getCar_place()%>"><br>
						<hr>
						이용금액(시간): <input type="text" name="per_hour" id="per_hour" value="<%=dto.getPer_hour()%>"><br>
						<hr>
						차종	: <select name="car_type" id="car_type">
							  	  	<option value="">차종을 선택하세요</option>
							  	  	<option value="대형" <%=car_type.equals("대형") ? "selected='selected'" : "" %>>대형</option>
							  	  	<option value="중형" <%=car_type.equals("중형") ? "selected='selected'" : "" %>>중형</option>
							  	  	<option value="소형" <%=car_type.equals("소형") ? "selected='selected'" : "" %>>소형</option>
							  </select><br>
						<hr>
						연식	: <input type="text" name="car_year" id="car_year" value="<%=dto.getCar_year()%>"><br>
						<hr>
						모델	: <input type="text" name="car_model" id="car_model" value="<%=dto.getCar_model()%>"><br>
						<hr>
						브렌드	: <input type="text" name="car_brand" id="car_brand" value="<%=dto.getCar_brand()%>"><br>
						<hr>
						이미지: <input type="file" name="car_image" id="car_image"><br> 
						<hr>
						기존 이미지 : <%=dto.getCar_image() %><br>
						<hr>
						연료	: <input type="text" name="car_fuel" id="car_fuel" value="<%=dto.getCar_fuel()%>"><br>
						<hr>
						<input type="submit" class="btn_update" value="등록">
					</div>
				</form>
			</div>
		</div>
	</div>	
</body>
</html>