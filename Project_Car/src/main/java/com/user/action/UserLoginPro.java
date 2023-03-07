package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.user.db.UserDAO;
import com.user.db.UserDTO;


public class UserLoginPro implements Action{

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String sessionId = request.getParameter("user_id");
		String user_pass = request.getParameter("user_pass");
		
		UserDAO dao = new UserDAO();
		
		UserDTO dto = dao.UserCheck(sessionId, user_pass);
		
		UserDTO sessionDTO = new UserDTO();
		
		if(dto!=null){
			
			HttpSession session = request.getSession();
			session.setAttribute("sessionId", sessionId);
			session.setAttribute("user_pass", user_pass);
			session.setAttribute("address", dto.getAddress());
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("license_num", dto.getLicense_num());
			session.setAttribute("license_type", dto.getLicense_type());
			session.setAttribute("user_hp", dto.getUser_hp());
		    session.setAttribute("user_name", dto.getUser_name());
			session.setAttribute("user_pt", dto.getUser_pt());
			
			
			System.out.println("user_name : " + session.getAttribute("user_name"));
			
			ActionForward forward = new ActionForward();
			forward.setPath("./UserHome.us");
			forward.setRedirect(true);
			
			return forward;
			
		}else{
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('입력하신 정보가 틀립니다.');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			return null;
		}

	}
}
