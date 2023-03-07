package com.qna_comm.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.qna_comm.db.QnaCommDAO;
import com.qna_comm.db.QnaCommDTO;

public class QnaCommWritePro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		int qna_num=Integer.parseInt(request.getParameter("qna_num"));
		String comm_content = request.getParameter("comm_content");
		String user_id = request.getParameter("user_id");
		int qna_index=Integer.parseInt(request.getParameter("qna_index"));

		QnaCommDTO dto = new QnaCommDTO();
		comm_content=comm_content.replace("\r\n","<br>");
		dto.setComm_content(comm_content);
		dto.setQna_num(qna_num);
		dto.setUser_id(user_id);
		QnaCommDAO dao = new QnaCommDAO();

		dao.insertQnaComm(dto);

		ActionForward forward=new ActionForward();
		forward.setPath("/QnaContent.qn?qna_num="+String.valueOf(qna_num)+"&qna_index="+qna_index);
		forward.setRedirect(false);
		return forward;
	}

}
