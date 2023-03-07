package com.car.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CarInfoFrontController extends HttpServlet{

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
		} else if(command.equals("/CarInsertPro.ci")) {
			action=new CarInsertPro();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		} else if(command.equals("/CarListUser.ci")) {
			action=new CarListUser();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		} else if(command.equals("/CarDelete.ci")) {
			action=new CarDelete();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
		} else if(command.equals("/CarUpdateForm.ci")){
			action=new CarUpdateForm();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/CarUpdatePro.ci")){
			action=new CarUpdatePro();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(command.equals("/CarListAdmin.ci")) {
			action=new CarListAdmin();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			} 
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
