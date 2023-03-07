<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>다 함께 CarChaCha</title>
  	<link rel="stylesheet" href="./css/header.css"/>
  	<link rel="stylesheet" href="./css/footer.css"/>
    <link rel="stylesheet" href="./review/review1.css"/>
    <script type="text/javascript" src="./review/review1.js"></script>

</head>
<!-- <body onload="setInnerHTML()"> -->
<body>
<%
String sessionId=(String)session.getAttribute("sessionId");
String car_num=request.getParameter("car_num");
%>
<jsp:include page="../css/header.jsp"></jsp:include>

<!-- <h1>REVIEW</h1> -->
<div id="wrapper">
	<div class="myPage_menu">
		<div>
			<button onclick="location.href='./UserInfoReservation.us'">예약 조회</button>
			<button onclick="location.href='./ReviewList.re'">나의 후기</button>
			<button onclick="location.href='./UserQnaList.us'">문의 내역</button>
			<button onclick="location.href='./UserInfo.us'">회원조회</button>
			<button onclick="location.href='./UserInfoDeleteForm.us'">회원탈퇴</button>
			<%
			String sessionReview = (String)session.getAttribute("sessionId");
			if(sessionId.equals("admin")) { %>
			<button onclick="location.href='./UserList.us'">회원목록</button>
			<% 	
			}
			%>
		</div>
	</div>
    <div class="wrap">
        <form name="reviewform" class="reviewform" method="post" action="./ReviewWritePro.re" >
            <input type="hidden" name="rate" id="rate" value="0">
            <p align="center" class="title_star">별점과 이용후기를 남겨주세요</p>
            <div class="review_rating rating_point">
               <div class="warning_msg">별점을 선택해 주세요.</div>
                <div class="rating">
                    <div class="ratefill"></div>
                    <!-- [D] 해당 별점이 선택될 때 그 점수 이하의 input엘리먼트에 checked 클래스 추가 -->
<!--                     <div id="content"></div> -->
                     <input type="checkbox" name="review_star" id="rating11" value="1" class="rate_radio" title="1점">
		             <label for="rating11"></label>
                     <input type="checkbox" name="review_star" id="rating12" value="2" class="rate_radio" title="2점">
                     <label for="rating12"></label>
                     <input type="checkbox" name="review_star" id="rating13" value="3" class="rate_radio" title="3점">
                     <label for="rating13"></label>
                     <input type="checkbox" name="review_star" id="rating14" value="4" class="rate_radio" title="4점">
                     <label for="rating14"></label>
                     <input type="checkbox" name="review_star" id="rating15" value="5" class="rate_radio" title="5점">
                     <label for="rating15"></label>
                </div>
            </div>
			<br>
			<br>
			<br>
			
            <div class="review_contents">
                <div class="warning_msg">내용을 입력하시오</div>
                <textarea name="review_content" rows="10" class="review_textarea" minlength="5" maxlength="1500" placeholder="내용을 입력하세요" ></textarea>
            </div>
      
            <div class="cmd">
<!--           <input type="button" name="save" id="save" value="등록하기" > -->
               <button type="button" name="save" id="save">등록하기</button>
               <input type="submit" id="btnSubmit" style="display: none;">
			   <input type="hidden" name="res_num"><br>
           	   <input type="hidden" name="car_num" value=<%=car_num %>><br>
           	   
           	   <input type="hidden" name="user_id" value="<%=sessionId %>" readonly><br>
<!--           <input type="hidden" name="review_num"><br> -->
            </div>
 		</form>     
    </div>
</div>
    <jsp:include page="../css/footer.jsp"></jsp:include>

</body>
</html>
