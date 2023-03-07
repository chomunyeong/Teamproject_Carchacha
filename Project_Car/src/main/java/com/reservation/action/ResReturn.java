package com.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna.db.QnaDAO;
import com.reservation.db.ReservationDAO;

import vo.Action;
import vo.ActionForward;

public class ResReturn implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String res_num=request.getParameter("res_num");
		ReservationDAO dao = new ReservationDAO();
		
		dao.returnRes(res_num);
		
		ActionForward forward=new ActionForward();
		forward.setPath("UserInfoReservation.us");
		forward.setRedirect(false);
		return forward;
	}

}
