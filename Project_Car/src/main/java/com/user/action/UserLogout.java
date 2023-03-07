package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserLogout implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//처리 - 세션값 초기화
				System.out.println("LogoutPro 들어옴");
				HttpSession session = request.getSession();
				session.invalidate();
				//   ./MemberMain.me 이동
				ActionForward forward = new ActionForward();
				forward.setPath("./UserHome.us");
				forward.setRedirect(true);
				return forward;
	}

}
