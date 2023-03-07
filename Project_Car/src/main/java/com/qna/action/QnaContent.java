package com.qna.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna.db.QnaDAO;
import com.qna.db.QnaDTO;

public class QnaContent implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		int qna_index=Integer.parseInt(request.getParameter("qna_index"));
		QnaDAO dao=new QnaDAO();
		dao.updateQnaReadcount(qna_num);
		QnaDTO dto=dao.getQna(qna_num);
		dto.setQna_index(qna_index);
		
		request.setAttribute("dto", dto);
		ActionForward forward=new ActionForward();
		forward.setPath("./qna/content.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}