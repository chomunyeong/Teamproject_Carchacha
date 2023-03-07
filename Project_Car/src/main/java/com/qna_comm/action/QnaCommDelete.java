package com.qna_comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna_comm.db.QnaCommDAO;

public class QnaCommDelete implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		int comm_num=Integer.parseInt(request.getParameter("comm_num"));
		int qna_index=Integer.parseInt(request.getParameter("qna_index"));
		QnaCommDAO dao = new QnaCommDAO();
		
		dao.deleteComm(qna_num, comm_num);
		
		ActionForward forward=new ActionForward();
		forward.setPath("/QnaContent.qn?qna_num="+String.valueOf(qna_num)+"&qna_index="+qna_index);
		forward.setRedirect(false);
		return forward;
	}

}
