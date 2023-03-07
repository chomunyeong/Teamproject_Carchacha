package com.review.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReviewFrontController extends HttpServlet{
	
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberFrontControler doProcess()");
		
		String strpath=request.getServletPath();
		System.out.println("뽑은주소 path : " +strpath);
		
		
		ActionForward forward=null;
		Action action=null;
		
		
		if(strpath.equals("/ReviewWriteForm.re")) {
			forward=new ActionForward();
			forward.setPath("./review/writeForm.jsp");
			forward.setRedirect(false);

		}else if(strpath.equals("/ReviewWritePro.re")) {
			action=new ReviewWritePro();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(strpath.equals("/ReviewList.re")) {
			action=new ReviewList();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
		}else if(strpath.equals("/ReviewUpdateForm.re")) {
			action=new ReviewUpdateForm();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(strpath.equals("/ReviewUpdatePro.re")) {
			action=new ReviewUpdatePro();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(strpath.equals("/ReviewDelete.re")) {
			action=new ReviewDelete();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		// 이동
		if(forward!=null) {
			if(forward.isRedirect()) {
				System.out.println("true:" + forward.getPath() + "sendRedirect() 이동");
				response.sendRedirect(forward.getPath());
			}else {
				System.out.println("false:" + forward.getPath() + "forward() 이동");
				RequestDispatcher dis
				=request.getRequestDispatcher(forward.getPath());
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
