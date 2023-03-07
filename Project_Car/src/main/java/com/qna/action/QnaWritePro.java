package com.qna.action;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.qna.db.QnaDAO;
import com.qna.db.QnaDTO;

public class QnaWritePro implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String filepath = request.getSession().getServletContext().getRealPath("qna_images");
		
		MultipartRequest multi = new MultipartRequest
				(request, filepath, 
						1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
		
		String user_id=multi.getParameter("user_id");
		String qna_sub=multi.getParameter("qna_sub");
		String qna_content=multi.getParameter("qna_content");
		String qna_secret=multi.getParameter("qna_secret");
		String qna_image=multi.getFilesystemName("qna_image");
		
		if(qna_secret == null) {
			qna_secret="N";
		} 
		qna_content=qna_content.replace("\r\n","<br>");
		QnaDTO dto = new QnaDTO();
		dto.setUser_id(user_id);
		dto.setQna_sub(qna_sub);
		dto.setQna_content(qna_content);
		dto.setQna_image(qna_image);
		dto.setQna_readcount(0);
		dto.setQna_secret(qna_secret);

		QnaDAO dao = new QnaDAO();

		dao.insertQna(dto);

		ActionForward forward=new ActionForward();
		forward.setPath("./QnaList.qn");
		forward.setRedirect(true);
		return forward;
	}
	
}
