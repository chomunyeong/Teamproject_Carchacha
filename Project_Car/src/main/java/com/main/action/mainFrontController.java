package com.main.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.action.Action;
import com.car.action.ActionForward;
import com.car.action.CarDelete;
import com.car.action.CarInsertPro;
import com.car.action.CarListPro;
import com.car.action.CarListUser;
import com.car.action.CarUpdateForm;
import com.car.action.CarUpdatePro;

public class mainFrontController extends HttpServlet {

protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String requestURI = request.getRequestURI();
		System.out.println(" Controller : requestURI = "+requestURI);
		String ctxPath = request.getContextPath();
		System.out.println(" Controller : ctxPath = "+ctxPath);
		String command = requestURI.substring(ctxPath.length());
		System.out.println(" Controller : command = "+command);
		
		ActionForward forward=null;
		Action action=null;
		
		if(command.equals("/CarInsertForm.ci")) {
			forward=new ActionForward();
			forward.setPath("./carinfo/insertForm.jsp");
			forward.setRedirect(false);
		} else if(command.equals("/guide.mn")) {
			forward=new ActionForward();
			forward.setPath("./mainHome/guide.jsp");
			forward.setRedirect(false); 
		} else if(command.equals("/information.mn")) {
			forward=new ActionForward();
			forward.setPath("./mainHome/information.jsp");
			forward.setRedirect(false); 
		} else if(command.equals("/map.mn")) {
			forward=new ActionForward();
			forward.setPath("./map/map.jsp");
			forward.setRedirect(false); 
		} 
		
		
		if(forward!=null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
				RequestDispatcher dis
				= request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
}
