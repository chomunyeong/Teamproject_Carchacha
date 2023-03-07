package com.user.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.db.UserDAO;
import com.user.db.UserDTO;

public class UserInsertPro implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String user_id = request.getParameter("user_id");
		String user_pass = request.getParameter("user_pass");
		String user_name = request.getParameter("user_name");
		String user_hp = request.getParameter("user_hp");
		String email = request.getParameter("email");
		String address = request.getParameter("address1") + request.getParameter("address2") + request.getParameter("address3");
		String user_birth = request.getParameter("user_birth");
		String license_num = request.getParameter("license_num");
		String license_type = request.getParameter("license_type");
		
		UserDAO dao = new UserDAO();
		UserDTO dto = new UserDTO();
		// dto.id=id;
		dto.setUser_num(0);
		dto.setUser_id(user_id);
		dto.setUser_pass(user_pass);
		dto.setUser_name(user_name);
		dto.setUser_hp(user_hp);
		dto.setEmail(email);
		dto.setAddress(address);
		dto.setUser_birth(user_birth);
		dto.setLicense_num(license_num);
		dto.setLicense_type(license_type);

		dao.insertUser(dto);
		System.out.println(dto);

		
		ActionForward forward=new ActionForward();
		forward.setPath("./UserLoginForm.us");
		forward.setRedirect(true);
		return forward;
	}

}
