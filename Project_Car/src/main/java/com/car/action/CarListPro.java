package com.car.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;

public class CarListPro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CarInfoDAO dao = new CarInfoDAO();
		
		request.setAttribute("carList", dao.getCarInfoList());
		
		ActionForward forward = new ActionForward();
		forward.setPath("./carinfo/CarListForm.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}
