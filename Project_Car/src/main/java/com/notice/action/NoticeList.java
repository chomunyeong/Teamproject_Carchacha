package com.notice.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;

public class NoticeList implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");


		

		//�궗�슜 => BoardDAO 湲곗뼲�옣�냼 �븷�떦(媛앹껜�깮�꽦)
		NoticeDAO dao=new NoticeDAO();

		
		// �븳 �솕硫댁뿉 蹂댁뿬以� 湲� 媛쒖닔 �꽕�젙(10媛� �꽕�젙)
		int pageSize=10; 
		System.out.println("�솕硫댁뿉 蹂댁뿬以� 湲� 媛��닔 pageSize="+pageSize);
		
		
		// �꽑�깮�븳 pageNum 媛� 媛�吏�怨� �삤湲�
		String pageNum = request.getParameter("pageNum");
			if(pageNum==null){pageNum = "1";} // �럹�씠吏� 踰덊샇媛� �뾾�쑝硫� => "1" �꽕�젙
		System.out.println("�꽑�깮�븳 �럹�씠吏� �꽆踰� pageNum="+pageNum);

		// pageNum 媛믪쓣 �젙�닔�삎?�쑝濡� 蹂�寃�
		int currentPage = Integer.parseInt(pageNum); //----- �슂泥��빐�꽌 諛쏆� �럹�씠吏� �닽�옄 
		// �럹�씠吏� �꽆�뼱媛� �썑 �떆�옉 湲�?
		int startRow = (currentPage-1)*pageSize+1; // (1-1)*10+1=>0*10+1=>0+1=>1  (2-1)*10+1=>1*10+1=>10+1=>11 (3-1)*10+1=>2*10+1=>20+1=>21
		System.out.println("�럹�씠吏��꽆�뼱媛꾪썑 �떆�옉 湲�? startRow="+startRow);
		// �럹�씠吏� �꽆�뼱媛� �썑 �걹 湲�?
		int endRow=startRow+pageSize-1; // 1+10-1 => 10  11+10-1 => 20  21+10-1 => 30
		System.out.println("�빐�떦�럹�씠吏��쓽 �걹 湲� endRow="+endRow);

		
		// 寃��깋議곌굔 諛� 寃��깋臾몄옄 諛쏆븘�삤湲�
		String searchField = request.getParameter("searchField");
		String searchText = request.getParameter("searchText");
		System.out.println("寃��깋 議곌굔 searchField" + searchField);
		System.out.println("寃��깋 �엯�젰媛� searchText" + searchText);
		
		
		List<NoticeDTO> noticeList = dao.getNoticeList(startRow, pageSize, searchField, searchText);

		
		// 湲�媛��닔
		int count = dao.getNoticeCount(searchField, searchText);
		System.out.println("珥� 湲� 媛��닔 " + count);
		
		
		
//		---------------------------------------------------------------------�븘�옒 �럹�씠吏�媛��닔 �꽕�젙
		
		
		int pageBlock=10;  // �븳 �솕硫댁뿉 蹂댁뿬以� �럹�씠吏� 媛쒖닔 �꽕�젙
		
		// �븳 �솕硫댁뿉 蹂댁뿬以� �떆�옉 �럹�씠吏� 
		int startPage=(currentPage-1)/pageBlock*pageBlock+1; // (0~9)/10*10+1=>0*10+1 => 0+1=> 1     //  (10~19)/10*10+1=>1*10+1 => 10+1=> 11  // (20~29)/10*10+1=>2*10+1 => 20+1=> 21
		System.out.println("�븳 �솕硫댁뿉 蹂댁뿬以� �떆�옉 �럹�씠吏� startPage="+startPage);
		
		// �븳 �솕硫댁뿉 蹂댁뿬以� �걹 �럹�씠吏�
		int endPage=startPage+pageBlock-1;
		
		// �쟾泥� �럹�씠吏� 媛��닔
		int pageCount = count/pageSize+(count%pageSize==0 ? 0 : 1);
		System.out.println("�쟾泥� �럹�씠吏� 媛��닔 pageCount="+pageCount);



		if(endPage > pageCount){
			endPage=pageCount;
		}

		System.out.println("endPage="+endPage);
		
		
		// startPage pageBlock currentPage endPage pageCount		
		// �뜲�씠�꽣瑜� �떞�븘�꽌 list.jsp �씠�룞
		request.setAttribute("noticeList",noticeList);
		request.setAttribute("startPage", startPage);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./notice/list.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
