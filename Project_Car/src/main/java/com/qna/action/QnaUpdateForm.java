package com.qna.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna.db.QnaDAO;
import com.qna.db.QnaDTO;

public class QnaUpdateForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		QnaDAO dao=new QnaDAO();
		QnaDTO dto=dao.getQna(qna_num);
		dto.setQna_index(Integer.parseInt(request.getParameter("qna_index")));
		
		request.setAttribute("dto", dto);
		ActionForward forward=new ActionForward();
		forward.setPath("./qna/updateForm.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
