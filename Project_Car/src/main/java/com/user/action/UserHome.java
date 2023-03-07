package com.user.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDTO;
import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;
import com.review.db.ReviewDAO;
import com.review.db.ReviewDTO;

public class UserHome implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		NoticeDAO dao=new NoticeDAO();
		int pageSize=3; 
		String pageNum = "1";
		
		int currentPage = Integer.parseInt(pageNum); 
		int startRow = (currentPage-1)*pageSize+1; // (1-1)*10+1=>0*10+1=>0+1=>1  (2-1)*10+1=>1*10+1=>10+1=>11 (3-1)*10+1=>2*10+1=>20+1=>21
		
		ReviewDAO dao2=new ReviewDAO();
		List<ReviewDTO> mainReviewList=dao2.getMainReviewList();
		
		
		List<NoticeDTO> noticeList = dao.MaingetNoticeList(startRow, pageSize);

		int count = dao.MaingetNoticeCount();
		
		request.setAttribute("mainReviewList",mainReviewList);
		request.setAttribute("noticeList",noticeList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./user/userHome.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
