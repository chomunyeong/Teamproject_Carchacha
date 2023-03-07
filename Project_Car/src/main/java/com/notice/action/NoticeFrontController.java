package com.notice.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//서블릿(처리담당자)
public class NoticeFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("NoticeFrontController doProcess()");
		//가상주소 뽑아오기
		String requestURI=request.getRequestURI();
		System.out.println("requestURI : "+requestURI);
		
		String contextPath=request.getContextPath();
		System.out.println("contextPath : " + contextPath);
		System.out.println("contextPath길이 : " + contextPath.length());
		
		String strpath=requestURI.substring(contextPath.length());
		System.out.println("뽑은 주소 strpath : "+strpath);
		
		//가상주소 비교 => 실제파일 연결
		ActionForward forward=null;
		Action action=null;
		if(strpath.equals("/NoticeWriteForm.no")) {
//			./board/writeForm.jsp 이동주소, false 이동방식
			forward=new ActionForward();
			forward.setPath("./notice/writeForm.jsp");
			forward.setRedirect(false);
		}else if(strpath.equals("/NoticeWritePro.no")) {
			//BoardWritePro 객체생성
			action=new NoticeWritePro();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(strpath.equals("/NoticeList.no")) {
			// DB내용 가져와서 list.jsp 출력
			// BoardList 객체생성
			action=new NoticeList();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}else if(strpath.equals("/NoticeContent.no")) {
			// 디비에 가서 num에 대한 글을 가져와서 content.jsp 이동
			// BoardContent 객체생성
			action=new NoticeContent();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(strpath.equals("/NoticeUpdateForm.no")) {
			// 디비에 가서 num에 대한 글을 가져와서 updateForm.jsp 이동
			// BoardUpdateForm 객체생성
			action=new NoticeUpdateForm();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(strpath.equals("/NoticeUpdatePro.no")) {
			// BoardUpdatePro 객체생성
			action=new NoticeUpdatePro();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(strpath.equals("/NoticeDelete.no")) {
			// BoardDelete 객체생성
			action=new NoticeDelete();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(strpath.equals("/MainPage.no")) {
			// BoardDelete 객체생성
			action=new MainNoticeList();
			//메서드호출
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//이동
		if(forward!=null) {
			if(forward.isRedirect()) {
				//true : 주소변경 되면서 이동
				System.out.println("true:"+ forward.getPath() +"sendRedirect() 이동");
				response.sendRedirect(forward.getPath());
			}else {
				//false : 주소변경 안되면서 이동
				System.out.println("false:"+ forward.getPath() +"foward() 이동");
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
