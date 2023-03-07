package com.review.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.review.db.ReviewDAO;
import com.review.db.ReviewDTO;

public class ReviewWritePro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");

		String user_id=request.getParameter("user_id");
		String car_num=request.getParameter("car_num");
		String review_star = request.getParameterValues("review_star").length + "";
		String review_content=request.getParameter("review_content");
		review_content=review_content.replace("\r\n","<br>");

		ReviewDTO dto=new ReviewDTO();
		
		dto.setUser_id(user_id);
		dto.setCar_num(car_num);
		dto.setReview_star(review_star);
		dto.setReview_content(review_content);
		dto.setReview_date(new Timestamp(System.currentTimeMillis())); 


		ReviewDAO dao=new ReviewDAO();
		dao.insertReview(dto);
		
		
		request.setAttribute("user_id", user_id);
		request.setAttribute("car_num", car_num);
		System.out.println("car_num"+ car_num);
		
		
		//湲�紐⑸줉�씠�룞
		ActionForward forward=new ActionForward();
		forward.setPath("./ReviewList.re");
		forward.setRedirect(true);
		
		return forward;
	}
	
}
