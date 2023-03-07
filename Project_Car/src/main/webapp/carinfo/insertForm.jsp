<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<head>
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
	if (document.getElementById("car_image").value=="") {
		document.getElementById("div").innerHTML="이미지를 업로드하시오."
		document.getElementById("car_image").focus();
		return false;
	}
}
</script>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link href="./css/carinfoInsertForm.css" rel="stylesheet">
</head>
<body>
<div id="div"></div>
<form action="CarInsertPro.ci" method="post" enctype="multipart/form-data" onsubmit="return check()">
<h1>차 정보 등록</h1>
차번호	: <input type="text" name="car_num" id="car_num"><br><br>
지역		: <input type="text" name="car_place" id="car_place"><br><br>
이용금액(시간): <input type="text" name="per_hour" id="per_hour"><br><br>
차종		: <select name="car_type" id="car_type">
  	  		<option value="">차종을 선택하세요</option>
	  	  	<option value="대형">대형</option>
	  	  	<option value="중형">중형</option>
	  	  	<option value="소형">소형</option>
	 	 </select><br><br>
연식		: <input type="text" name="car_year" id="car_year"><br><br>
모델		: <input type="text" name="car_model" id="car_model"><br><br>
브렌드	: <input type="text" name="car_brand" id="car_brand"><br><br>
연료		: <input type="text" name="car_fuel" id="car_fuel"><br><br>
사진 		: <input type="file" name="car_image" id="car_image">
<input type="submit" value="등록">
</form>
</body>
</html>