<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>다 함께 CarChaCha</title>
<link rel="stylesheet" href="./css/findId.css"/>
</head>
<script type="text/javascript">
//유효성체크 - null값 못오게함.

function findValid2() {
	
	var FV2 = document.FindPass;
	if(FV2.user_id.value == "" || FV2.user_email.value == ""  ) {
		alert("정보를 정확하게 입력해주세요.");
		return false;
	}

}

</script>
<body>
	<div class="fId">	
		<h1>비밀번호찾기</h1>
		<form action="./findPassResult.us" name="FindPass" onSubmit="return findValid2()">
			<input type="text" name='user_id' placeholder="아이디를 입력하세요."> <br>
			<input type='email' name='user_email' placeholder="이메일을 입력하세요."><br><br>
			<input type="submit" id="passbtn" name="findbtn" value="비밀번호 찾기">
		</form>
	</div>
</body>
</html>