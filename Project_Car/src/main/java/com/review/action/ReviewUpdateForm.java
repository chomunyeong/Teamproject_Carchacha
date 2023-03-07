package com.review.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.review.db.ReviewDAO;
import com.review.db.ReviewDTO;

public class ReviewUpdateForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session=request.getSession();
		String sessionId=(String)session.getAttribute("sessionId");

		int review_num=Integer.parseInt(request.getParameter("review_num"));

		ReviewDAO dao=new ReviewDAO();

		ReviewDTO dto=dao.getReivew(review_num);
		
		request.setAttribute("dto", dto);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./review/updateForm.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
	

}
