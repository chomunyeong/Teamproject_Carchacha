package com.qna_comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna_comm.db.QnaCommDAO;
import com.qna_comm.db.QnaCommDTO;

public class QnaCommUpdateForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		int comm_num=Integer.parseInt(request.getParameter("comm_num"));
		int qna_index=Integer.parseInt(request.getParameter("qna_index"));
		
		QnaCommDAO dao=new QnaCommDAO();
		QnaCommDTO dto=dao.getQnaComm(qna_num,comm_num);
		
		dto.setQna_num(qna_num);
		dto.setComm_num(comm_num);
		request.setAttribute("dto", dto);
		
		ActionForward forward=new ActionForward();
		forward.setPath("./qna_comm/updateForm.jsp?qna_index="+qna_index);
		forward.setRedirect(false);
		return forward;
	}
	
}
