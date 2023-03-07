package com.reservation.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.reservation.db.ReservationDAO;
import com.user.db.UserDAO;

import vo.Action;
import vo.ActionForward;

public class InsertReservation implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String user_id = (String)request.getSession().getAttribute("sessionId");
		int usePoint = Integer.parseInt(request.getParameter("usePoint"));
		int price = Integer.parseInt(request.getParameter("price"));
		ReservationDAO dao = new ReservationDAO();
		dao.insertReservation(request.getParameter("res_num") 
							  ,request.getParameter("car_num")
							  ,request.getParameter("res_stime")
							  ,Integer.parseInt(request.getParameter("res_time"))
							  ,user_id);
		dao.minusPoint(usePoint, user_id);
		dao.plusPoint(price,user_id);
		
		request.getSession().setAttribute("user_pt", new UserDAO().getUserPoint(user_id));
		/*
		 * JSONArray arr = new JSONArray();
		 * 
		 * JSONObject object = new JSONObject();
		 * 
		 * response.setContentType("text/html; charset=UTF-8"); PrintWriter out =
		 * response.getWriter(); out.print(arr); out.close();
		 */
		return null;
	}
	
}
