package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.review.db.ReviewDAO;
import com.review.db.ReviewDTO;

public class ReviewUpdatePro implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
	System.out.println(Integer.parseInt(request.getParameter("review_num")));
		System.out.println(request.getParameter("user_id"));
		System.out.println(request.getParameter("car_num"));
		System.out.println(request.getParameterValues("review_star"));
		System.out.println(request.getParameter("review_content"));
		
		int review_num=Integer.parseInt(request.getParameter("review_num"));
		String user_id=request.getParameter("user_id");
		String car_num=request.getParameter("car_num");
		String review_star = request.getParameterValues("review_star").length + "";
		String review_content=request.getParameter("review_content");
		
		review_content=review_content.replace("\r\n","<br>");
		
		ReviewDTO dto=new ReviewDTO();

		dto.setReview_num(review_num);
		dto.setUser_id(user_id);
		dto.setCar_num(car_num);
		dto.setReview_star(review_star);
		dto.setReview_content(review_content);
		
		System.out.println("ReviewDAO User_Id : " + dto.getUser_id());
		System.out.println("ReviewDAO Car_num : " + dto.getCar_num());		
		System.out.println("ReviewDAO Review_star : " + dto.getReview_star());
		System.out.println("ReviewDAO Review_content : " + dto.getReview_content());
		System.out.println("ReviewDAO Review_date : " + dto.getReview_date());
		
		
		
		

		//�닔�젙�옉�뾽
		ReviewDAO dao=new ReviewDAO();

		dao.updateReivew(dto);
		

		//湲�紐⑸줉
		ActionForward forward=new ActionForward();
		forward.setPath("./ReviewList.re");
		forward.setRedirect(true);
		return forward;
	}
	
	

}
