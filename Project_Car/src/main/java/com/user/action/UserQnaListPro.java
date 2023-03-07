package com.user.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.qna.db.QnaDAO;
import com.qna.db.QnaDTO;
import com.user.db.UserDAO;

public class UserQnaListPro implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		  //request.getSession(true);
		  HttpSession session = request.getSession();
		  //session.setAttribute();
		  String sessionId = (String)session.getAttribute("sessionId");
		  System.out.println("sessionId : "+sessionId);
		  
	      UserDAO dao = new UserDAO();
	      
	      int pageSize=10;
	      String pageNum=request.getParameter("pageNum");
	      
	      if(pageNum==null){
	         pageNum="1";
	      }
	      
	      int currentPage=Integer.parseInt(pageNum);
	      int startRow=(currentPage-1)*pageSize+1;
	      int endRow=startRow+pageSize-1;
	      
	      List<QnaDTO> mypageQnaList = dao.getMypageQnaList(sessionId,startRow,pageSize);

	      int count=dao.getQnaCount(sessionId);
	      int pageBlock=10;
	      int startPage=(currentPage-1)/pageBlock*pageBlock+1;
	      int endPage=startPage+pageBlock-1;

	      int pageCount = count/pageSize+(count%pageSize==0? 0 : 1);
	      if(endPage > pageCount) {
	         endPage=pageCount;
	      }
	      
	      request.setAttribute("mypageQnaList", mypageQnaList);
	      request.setAttribute("startPage", startPage);
	      request.setAttribute("pageBlock", pageBlock);
	      request.setAttribute("currentPage", currentPage);
	      request.setAttribute("endPage", endPage);
	      request.setAttribute("pageCount", pageCount);
	      request.setAttribute("count", count);
	      
	      ActionForward forward=new ActionForward();
	      forward.setPath("./user/mypageQnaList.jsp");
	      forward.setRedirect(false);
	      return forward;
	   

	}

}
