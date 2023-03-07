package com.notice.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;

public class MainNoticeList implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		NoticeDAO dao=new NoticeDAO();
		// 한 화면에 보여줄 글 개수 설정
		int pageSize=3; 
		// 선택한 pageNum 값 가지고 오기
		String pageNum = "1";
		
		// pageNum 값을 정수형?으로 변경
		int currentPage = Integer.parseInt(pageNum); //----- 요청해서 받은 페이지 숫자 
		// 페이지 넘어간 후 시작 글?
		int startRow = (currentPage-1)*pageSize+1; // (1-1)*10+1=>0*10+1=>0+1=>1  (2-1)*10+1=>1*10+1=>10+1=>11 (3-1)*10+1=>2*10+1=>20+1=>21
		// 페이지 넘어간 후 끝 글?

		
		List<NoticeDTO> noticeList = dao.MaingetNoticeList(startRow, pageSize);

		
		// 글갯수
		int count = dao.MaingetNoticeCount();
		System.out.println("총 글 갯수 " + count);
		
		
//		---------------------------------------------------------------------아래 페이지갯수 설정
		
		
		// startPage pageBlock currentPage endPage pageCount		
		// 데이터를 담아서 list.jsp 이동
		request.setAttribute("noticeList",noticeList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./notice/MainPage.jsp");
		forward.setRedirect(false);
		return forward;
		

		
	}
}
