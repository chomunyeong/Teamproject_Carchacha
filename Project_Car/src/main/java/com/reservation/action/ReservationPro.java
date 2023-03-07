package com.reservation.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;
import com.car.db.CarInfoDTO;
import com.reservation.db.ReservationDAO;
import com.reservation.db.ReservationDTO;
import com.review.db.ReviewDAO;
import com.review.db.ReviewDTO;

import vo.Action;
import vo.ActionForward;

public class ReservationPro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CarInfoDAO dao=new CarInfoDAO();
		String car_num=request.getParameter("car_num");
		CarInfoDTO carDTO = dao.getCar(car_num);
		// request car
		request.setAttribute("carDTO",carDTO);
		
		ReviewDAO dao2=new ReviewDAO();

		int pageSize=4;

		String pageNum=request.getParameter("pageNum");

		if(pageNum==null){
			pageNum="1";
		}

		int currentPage=Integer.parseInt(pageNum);

		int startRow=(currentPage-1)*pageSize+1;

		int endRow=(startRow-1)+pageSize;



		List<ReviewDTO> carReviewList=dao2.getCarReviewList(startRow, pageSize, car_num);

		int count=dao2.getReviewCount(carDTO);
		
		int pageBlock=10;

		int startPage=(currentPage-1)/pageBlock*pageBlock+1;

		int endPage=startPage+pageBlock-1;

		int pageCount=count/pageSize+(count%pageSize==0 ? 0 : 1);
		
		if(endPage>pageCount){
			endPage=pageCount;
		}
		
		request.setAttribute("carReviewList", carReviewList);
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("car_res", new ReservationDAO().getResCarDate(carDTO.getCar_model()));
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./reservation/ReservationForm.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}
