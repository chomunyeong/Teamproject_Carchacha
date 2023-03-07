package com.user.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserList implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UserDAO dao = new UserDAO();
		int pageSize=10; 
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null)	pageNum = "1";
		
		
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1)*pageSize+1;
		int endRow=startRow+pageSize-1;
		
		List<UserDTO> userList = dao.getUserList2(startRow, pageSize);
		int count = dao.getUserCount2();
//		---------------------------------
		int pageBlock=10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		int pageCount = count/pageSize+(count%pageSize==0 ? 0 : 1);
		if(endPage > pageCount){
			endPage=pageCount;
		}
		
		
		request.setAttribute("userList",userList);
		request.setAttribute("startPage", startPage);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("count", count);
		request.setAttribute("pageSize", pageSize);
		
		System.out.println("1111111111111111startPage : " + startPage);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./user/userlist.jsp");
		forward.setRedirect(false);
		return forward;
		
		
	}

}
