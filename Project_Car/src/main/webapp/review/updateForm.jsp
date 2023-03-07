<%@page import="com.review.db.ReviewDTO"%>
<%@page import="com.review.db.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>다 함께 CarChaCha</title>
    <link rel="stylesheet" href="./review/review1.css"/>
    <link rel="stylesheet" href="./css/header.css"/>
    <link rel="stylesheet" href="./css/footer.css"/>
    <script type="text/javascript" src="./review/review1.js"></script>

</head>
<body style="margin-top: 100px;">
<%
String sessionId=(String)session.getAttribute("sessionId");
int review_num=Integer.parseInt(request.getParameter("review_num"));
ReviewDAO dao=new ReviewDAO();

ReviewDTO dto=(ReviewDTO)request.getAttribute("dto");

String review_content=dto.getReview_content();
review_content=review_content.replace("<br>","\r\n");
%>
<jsp:include page="../css/header.jsp"></jsp:include>
<!-- <h1>REVIEW</h1> -->
    <div class="wrap" style="margin-bottom: 100px !important;">
        
        <form name="reviewform" class="reviewform" method="post" action="./ReviewUpdatePro.re" >
            <input type="hidden" name="rate" id="rate" value="0">
            
            <p align="center" class="title_star">별점과 이용후기를 남겨주세요</p>
     
            <div class="review_rating rating_point">
                <div class="warning_msg">별점을 선택해 주세요.</div>
                <div class="rating">
                    <div class="ratefill"></div>
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
                <div class="warning_msg"></div>
                <textarea name="review_content" rows="10" class="review_textarea" 
                		  minlength="5" maxlength="1500" placeholder="내용을 입력하세요" ><%=review_content %></textarea>
            </div>
      
            <div class="cmd">
<!--                <input type="button" name="save" id="save" value="등록하기" > -->

				
               <button type="button" name="save" id="save">수정완료</button>
               <input type="submit" id="btnSubmit" style="display: none;">
           	   <input type="hidden" name="car_num" value="<%=dto.getCar_num() %>"><br>
           	   <input type="hidden" name="user_id" value="<%=sessionId %>" readonly>
               <input type="hidden" name="review_num" value="<%=dto.getReview_num() %>"><br>
               <input type="hidden" id="review_star" value="<%=dto.getReview_star() %>"><br>
              
            </div>
            
 </form>
    </div>
    <jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>