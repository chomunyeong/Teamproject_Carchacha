package com.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;
import com.car.db.CarInfoDTO;
import com.reservation.db.ReservationDTO;

import vo.Action;
import vo.ActionForward;

public class PaymentPro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ReservationDTO res_dto = new ReservationDTO();
		String startDate = request.getParameter("selectedDate");
		String startTime = request.getParameter("selectedTime");

		res_dto.setCar_dto((CarInfoDTO)new CarInfoDAO().getCar(request.getParameter("car_num")));
		res_dto.setRes_stime(startDate + " " + startTime);
		res_dto.setRes_time(Integer.parseInt(startTime.split(":")[1].split(" ~ ")[1])- Integer.parseInt(startTime.split(":")[0]));
		res_dto.setUser_id((String)request.getSession().getAttribute("sessionId"));
			
		request.setAttribute("resDTO", res_dto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./payment/PaymentForm.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
