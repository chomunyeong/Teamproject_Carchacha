package com.notice.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;

public class NoticeUpdateForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//updateForm.jsp?num=1
		int num=Integer.parseInt(request.getParameter("num"));
		//BoardDAO 媛앹껜�깮�꽦 湲곗뼲�옣�냼 �븷�떦=> dao 湲곗뼲�옣�냼 二쇱냼 ���옣
		NoticeDAO dao=new NoticeDAO();
		//dao二쇱냼瑜� �넻�빐�꽌 getBoard(num)硫붿꽌�뱶 �샇異� => 由ы꽩�븷�삎 BoardDTO
		NoticeDTO dto=dao.getNotice(num);
		
		request.setAttribute("dto", dto);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./notice/updateForm.jsp");
		forward.setRedirect(false);
		return forward;
		

		
	}

}
