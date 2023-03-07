package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.review.db.ReviewDAO;

public class ReviewDelete implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int review_num=Integer.parseInt(request.getParameter("review_num")); 

		ReviewDAO dao=new ReviewDAO();

		dao.deleteReview(review_num);

		ActionForward forward=new ActionForward();
		forward.setPath("./ReviewList.re");
		forward.setRedirect(true);
		return forward;
	}
	
	

}
