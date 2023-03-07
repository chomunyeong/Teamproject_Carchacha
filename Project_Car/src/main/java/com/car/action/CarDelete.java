package com.car.action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;


public class CarDelete implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String car_num=request.getParameter("car_num");
		System.out.println(car_num);
		CarInfoDAO dao = new CarInfoDAO();
		String filepath = request.getSession().getServletContext().getRealPath("car_images");
		File deleteImageName = new File (filepath + "\\" + request.getParameter("car_image"));
		deleteImageName.delete();
		
		dao.deleteCar(car_num);
		
		ActionForward forward=new ActionForward();
		forward.setPath("CarList.ci");
		forward.setRedirect(false);
		return forward;
	}

} 
