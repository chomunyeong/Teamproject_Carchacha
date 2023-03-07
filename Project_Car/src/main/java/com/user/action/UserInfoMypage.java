package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;
import com.user.db.UserDTO;


public class UserInfoMypage implements Action{
		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			HttpSession session = request.getSession();
			String id=(String)session.getAttribute("user_id");
			
			UserDAO dao = new UserDAO();
			UserDTO dto = dao.getUserinfo(id);
		
			request.setAttribute("dto", dto);
			
			ActionForward forward = new ActionForward();
			forward.setPath("./user/mypage.jsp");
			forward.setRedirect(false);
			
			return forward;
		}

	}
