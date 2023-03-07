<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user_insert_form.jsp</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/insertForm.css" rel="stylesheet">
</head>
<script>

//우편번호 API
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);

        	var roadAddr = data.roadAddress; 
            var jibunAddr = data.jibunAddress;
            
            document.getElementById('user_post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("user_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("user_addr").value = jibunAddr;
            }
        }
    }).open();
}

//유효성체크 함수
function check() {


	
	if(!document.user_insert_Form.user_pass.value) {
		alert("PassWord를 입력하세요.");
		return false;
	}
	
	if(document.user_insert_Form.user_pass.value != document.user_insert_Form.user_Repass.value) {
		alert("PassWord가 서로 다릅니다.");
		return false;
	}
	
	if(document.user_insert_Form.license_num.value.length!=12) {
		alert("면허번호는 12자입니다.");
		return false;
	}
}



//아이디 중복확인
function confirmId() {
	
		var windowW = 500;  
		var windowH = 300;  
		var left = (window.screen.width - windowW)/2;
		var top = (window.screen.height - windowH)/2;
	   
		if(document.user_insert_Form.value == "") {
	      alter("ID를 입력하세요.");
	      return;
	  	}
	   
	   <!-- confirmId.jsp만들어야함. -->
	   url="./confirmId.us?user_id=" + document.user_insert_Form.user_id.value;
	   open(url, 'confirm' , 'status=no, height=' + windowH +' , width= ' + windowW + ', left='+ left + ', top='+ top );
	   
	
}

</script>

<!-- 우편API 주소 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<body>
<jsp:include page="../css/header.jsp"></jsp:include>
<br>
<!-- submit을 실행전에 실행, check()함수의 return값을 가져옴. true가 return되면 submit이 실행 
false를 return하면 submit이 취소 -->
<div class="user">
<h1>회원가입</h1>
	<form action="./UserInsertPro.us" method="post" name="user_insert_Form" onSubmit="return check()">
		<div class="field">
			<b>아이디</b><br>
			<input type="text" maxlength="20" name="user_id">
			<input class="id_check" type="button" value="중복확인" name="confirm_id" onclick="confirmId(this.form)"> <br>
		</div>
		
		<div class="field">	
			<b>비밀번호</b><br>	
			<input type="password" maxlength="20" name="user_pass" ><br>
		</div>
		
		<div class="field">
			<b>비밀번호 확인</b><br>	
			<input class="input" maxlength="20" type="password" name="user_Repass"> <br>
		</div>
		
		<div class="field">	
			<b>이름</b><br>		
			<input type="text" maxlength="10" name="user_name" required ><br>
		</div>
		
		<div class="field">	
			<b>핸드폰 번호</b><br>	
			<input type='tel' maxlength="15" name='user_hp'><br>
		</div>
		
		<div class="field">	
			<b>이메일</b><br>
			<input type='email' maxlength="45" name='email' required><br>
		</div>
		
		<div class="field">	
			<b>주소</b><br>
			<input id="user_post" name="address1" type="text" placeholder="우편번호" readonly onclick="findAddr()">
			<input id="user_addr" name="address2" type="text" placeholder="주소" readonly> <br>
			<input type="text" name="address3" placeholder="상세주소"> <br>
		</div>
		
		<div class="field">	
			<b>생년월일</b><br>
			<input type='date' name='user_birth' min='1900-01-01' max='2003-12-31' required > <br><br>
		</div>
		
		<div class="field">	
			<b>면허번호</b><br>
			<input type='text' maxlength="12" name='license_num' placeholder="'-'를 제거하고 작성해주세요." required > <br><br>
		</div>
		
		<div class="field">	
			<b>면허종류</b><br>
			<select name="license_type" required>
				<option value="">면허종류</option>
				<option value="1종">1종</option>
				<option value="2종">2종</option>
			</select><br><br>
		</div>
		
		<div class="c">
			<input type="submit" value="회원가입">
		</div>
		
	</form>
</div>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>
