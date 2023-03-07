package com.user.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class UserFrontController extends HttpServlet {


	   protected void doProcess(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException {
	      
	      String strpath = request.getServletPath();
	      System.out.println("寃쎈줈1 strpath: " + strpath);
	      
	      ActionForward forward = null;
	      Action action = null;
	      
	      if (strpath.equals("/UserInsertForm.us")) {
	          forward = new ActionForward();
	          forward.setPath("./user/userInsertForm.jsp");
	          forward.setRedirect(false);
	          
	      } else if (strpath.equals("/UserInsertPro.us")) {
	    	  action = new UserInsertPro();
	          try {
	             forward = action.execute(request, response);
	          } catch (Exception e) {
	             e.printStackTrace();
	          }

	       } else if (strpath.equals("/UserLoginForm.us")) {
	          forward = new ActionForward();
	          forward.setPath("./user/userLoginForm.jsp");
	          forward.setRedirect(false);
	       } else if (strpath.equals("/UserLoginPro.us")) {
	          action = new UserLoginPro();
	          try {
	             forward = action.execute(request, response);
	          } catch (Exception e) {
	             e.printStackTrace();
	          }

//	       } else if (strpath.equals("/UserHome.us")) {
//	          forward = new ActionForward();
//	          forward.setPath("./user/userHome.jsp");
//	          forward.setRedirect(false);
	          
	       } else if (strpath.equals("/UserHome.us")) {
	          action = new UserHome();
	          try {
	             forward = action.execute(request, response);
	          } catch (Exception e) {
	             e.printStackTrace();
	          }   
	       } else if(strpath.equals("/UserLogout.us")) {
	     	  action = new UserLogout();
	     	  try {
	 			forward=action.execute(request,response);
	     	  } catch (Exception e) {
	 			e.printStackTrace();
	     	  }
	       } else if(strpath.equals("/confirmId.us")) {
	    	   forward = new ActionForward();
		          forward.setPath("./user/confirmId.jsp");
		          forward.setRedirect(false);
	       } else if(strpath.equals("/findId.us")) {
	    	   forward = new ActionForward();
		          forward.setPath("./user/findId.jsp");
		          forward.setRedirect(false);
	       } else if(strpath.equals("/findIdResult.us")) {
	    	   forward = new ActionForward();
		          forward.setPath("./user/findIdResult.jsp");
		          forward.setRedirect(false);
	       } else if(strpath.equals("/findPass.us")) {
	    	   forward = new ActionForward();
		       forward.setPath("./user/findPass.jsp");
		       forward.setRedirect(false);
	       } else if(strpath.equals("/findPassResult.us")) {
	    	   		forward = new ActionForward();
		          forward.setPath("./user/findPassResult.jsp");
		          forward.setRedirect(false);
	       } else if (strpath.equals("/UserInfoMypage.us")) {

//				forward = new ActionForward();
//				forward.setPath("./first/mypage.jsp");
//				forward.setRedirect(false);

				action = new UserInfoMypage();
				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (strpath.equals("/UserInfo.us")) {

				action = new UserInfo();

				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (strpath.equals("/UserInfoUpdateForm.us")) {
				action = new UserInfoUpdateForm();
				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (strpath.equals("/UserInfoUpdatePro.us")) {
				action = new UserInfoUpdatePro();
				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (strpath.equals("/UserInfoDeleteForm.us")) {
				forward = new ActionForward();
				forward.setPath("./user/deleteForm.jsp");
				forward.setRedirect(false);
			} else if (strpath.equals("/UserInfoDeletePro.us")) {
				action = new UserInfoDeletePro();
				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
//			} else if (strpath.equals("/UserList.us")) {
//				forward = new ActionForward();
//				forward.setPath("./user/userlist.jsp");
//				forward.setRedirect(false);
			} else if (strpath.equals("/UserQnaList.us")) {
				action = new UserQnaListPro();

				try {
					forward = action.execute(request, response);

				} catch (Exception e) {
					e.printStackTrace();
				}
			} else if (strpath.equals("/UserInfoReservation.us")) {

				action = new UserInfoReservation();

				try {
					forward = action.execute(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}    else if (strpath.equals("/UserList.us")) {

		         action = new UserList();

		         try {
		            forward = action.execute(request, response);
		         } catch (Exception e) {
		            e.printStackTrace();
		         }   
			}
	      
	      
	      
	      
			if (forward != null) {
				if (forward.isRedirect()) {
					System.out.println("true:" + forward.getPath());
					response.sendRedirect(forward.getPath());

				} else {
					System.out.println("false:" + forward.getPath());
					RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
					dis.forward(request, response);
				}
			}
		

	    }

	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	          throws ServletException, IOException {
	       System.out.println("UserFrontController doGet()");
//	       doProcess()占쎌깈�빊占�
	       doProcess(request, response);
	    } // doProcess()筌롫뗄苑뚳옙諭�

	    @Override
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	          throws ServletException, IOException {
	       System.out.println("UserFrontController doPost()");
//	       doProcess()占쎌깈�빊占�
	       doProcess(request, response);
	    }

	 }