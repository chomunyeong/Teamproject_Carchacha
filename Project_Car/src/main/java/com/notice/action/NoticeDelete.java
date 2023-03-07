package com.notice.action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;

public class NoticeDelete implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int num=Integer.parseInt(request.getParameter("num"));
		
		String filepath = request.getSession().getServletContext().getRealPath("notice_images");
		String notice_image = request.getParameter("notice_image");
		

			String realFile = filepath +"\\"+notice_image;
			File f = new File(realFile);
			if( f.exists()) f.delete();
		
		
		
		//BoardDAO 媛앹껜�깮�꽦
		NoticeDAO dao=new NoticeDAO();
		// 由ы꽩�븷�삎�뾾�쓬 deleteBoard(int num)硫붿꽌�뱶 �젙�쓽
		// �뵒鍮꾩옉�뾽 二쇱냼瑜� �넻�빐�꽌 deleteBoard(num) �샇異�
		dao.deleteNotice(num);
		

		
		
		
		ActionForward forward=new ActionForward();
		forward.setPath("./NoticeList.no");
		forward.setRedirect(true);
		return forward;
	}
}
