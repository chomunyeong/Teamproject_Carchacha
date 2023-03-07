package com.user.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;
import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserInfoUpdatePro implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");

		System.out.println("##############");
		
		String user_id = request.getParameter("user_id");
		String user_pass = request.getParameter("user_pass");
		String user_pass2 = request.getParameter("user_pass2");
		String user_name = request.getParameter("user_name");
		String user_hp = request.getParameter("user_hp");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String user_pt = request.getParameter("user_pt");
		String license_num = request.getParameter("license_num");
		String license_type = request.getParameter("license_type");

		UserDAO dao = new UserDAO();

		UserDTO dto = dao.UserCheck(user_id, user_pass);

		if (dto != null) {
			dto.setUser_id(user_id);
			dto.setUser_pass(user_pass2);
			dto.setUser_name(user_name);
			dto.setUser_hp(user_hp);
			dto.setEmail(email);
			dto.setAddress(address);
			dto.setUser_pt(0);
			dto.setLicense_num(license_num);
			dto.setLicense_type(license_type);
			System.out.println("@#@#@!#@!#!@!#@#@!");
			System.out.println(dto);
			
			HttpSession session=request.getSession();
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_name", user_name);
			session.setAttribute("user_hp", user_hp);
			session.setAttribute("email", email);
			session.setAttribute("address", address);
			session.setAttribute("license_num", license_num);
			session.setAttribute("license_type", license_type);
			session.setAttribute("email", email);
			
			dao.updateUserinfo(dto);

			ActionForward forward = new ActionForward();
			forward.setPath("./UserInfoMypage.us");
			forward.setRedirect(true);
			return forward;

		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('back');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			return null;
		}
	}

}
