package com.notice.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;

public class NoticeContent implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// content.jsp?num=1
		int num=Integer.parseInt(request.getParameter("num"));
		// 객체생성 기억장소 할당=> dao 기억장소 주소 저장
		NoticeDAO dao=new NoticeDAO();
		// 조회수 증가 readcount 1증가
		// update board set readcount=readcount+1 where num=?
		// 리턴할형없음 updateReadcount(int num)	메서드 정의
		// dao주소를 통해서  updateReadcount(num) 메서드 호출
		dao.updateReadcount(num);
		// BoardDTO 리턴할형  getBoard(int num)메서드 정의
		// dao주소를 통해서 메서드 호출 => 리턴할형 BoardDTO
		NoticeDTO dto = dao.getNotice(num);
		NoticeDTO dto2 = dao.nextNotice(num);
		NoticeDTO dto3 = dao.backNotice(num);
		System.out.println("22222222222222222222222222222" + dto2.getNotice_num());
		request.setAttribute("dto", dto);
		request.setAttribute("dto2", dto2);
		request.setAttribute("dto3", dto3);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./notice/content.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
