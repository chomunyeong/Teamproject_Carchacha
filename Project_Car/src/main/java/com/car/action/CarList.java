package com.car.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;
import com.car.db.CarInfoDTO;



public class CarList implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	CarInfoDAO dao = new CarInfoDAO();
			
		int pageSize=2;
		
		String pageNum=request.getParameter("pageNum");
		
		if(pageNum==null){
			pageNum="1";
		}
		
		int currentPage=Integer.parseInt(pageNum);
		
		int startRow=(currentPage-1)*pageSize+1;
		
		int endRow=startRow+pageSize-1;
	
		List<CarInfoDTO> carList = dao.getCarList(startRow,pageSize);
	
		int count=dao.getCarCount();
		
		int pageBlock=10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		
		int pageCount = count/pageSize+(count%pageSize==0? 0 : 1);
		if(endPage > pageCount) {
			endPage=pageCount;
		}
		
		request.setAttribute("carList", carList);
		// startPage pageBlock currentPage endPage pageCount
		request.setAttribute("startPage", startPage);
		request.setAttribute("pageBlock", pageBlock);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("pageCount", pageCount);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./carinfo/list.jsp");
		forward.setRedirect(false);
		return forward;
		
	}
	
}
