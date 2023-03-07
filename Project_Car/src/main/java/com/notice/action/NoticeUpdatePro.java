package com.notice.action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NoticeUpdatePro implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// request �뜝�럥由썹뼨�먯삕嶺뚳퐣瑗띰옙遊�
		request.setCharacterEncoding("utf-8");
		
		
		
		String filepath = request.getSession().getServletContext().getRealPath("notice_images");
		
		int uploadFileSizeLimit = 5*1024*1024;
		String encType = "UTF-8";
		String uploadFilePath = filepath;
		MultipartRequest multi = null;
		multi = new MultipartRequest(request,uploadFilePath,uploadFileSizeLimit,
					encType,new DefaultFileRenamePolicy());
		
		
		
		
		
		
		// request �뜝�럩�젧�솻洹⑥삕 �뤆�룊�삕�뜝�럩二у뜝�럩沅롧뼨�먯삕
		// num name subject content �뜝�럥�냱�뜝�럩逾ф쾬�꼶梨멱땻占� �뤆�룊�삕�뜝�럩二у뜝�룞�삕�뜝�럡�맋 �솻洹⑥삕�뜝�럥�빢�뜝�럥�뱺 �뜝�룞�삕�뜝�럩�궋
		int num=Integer.parseInt(multi.getParameter("num"));
		String sessionId=multi.getParameter("sessionId");
		String subject=multi.getParameter("subject");
		String content=multi.getParameter("content");
		
		String eimg=multi.getParameter("eimg");
		String fileName = multi.getFilesystemName("fileName");
		System.out.println("�뜝�럡�돮 �뜝�럩逾졿쾬�꼶梨룟뜝占� �뜝�럥�냱�뜝�럩逾�"+fileName);
		System.out.println("�뼨轅명�ｏ옙占� �뜝�럩逾졿쾬�꼶梨룟뜝占� �뜝�럥�냱�뜝�럩逾�"+eimg);
		
		content = content.replace("\r\n", "<br>");
		
		// �뜝�럩逾졿쾬�꼶梨룟뜝占� �뜝�럡�뀭�뜝�럩�젷 �뼨轅명�∽옙裕� �뛾�룊�삕 �뜝�럥�뵜�뜝�럥�몥�뜝�럩逾졾뜝�럥諭쒎뜝�럥�냱�뜝�럩逾� �뜝�럥�뵪�뜝�럩諭썲뜝�럥六� �윜諛몄굡�뜝�뜽�뿉�뜝占� �뜝�럩占썹춯�쉻�삕
		if(fileName == null) {
			fileName = eimg;
		}
		if(!fileName.equals(eimg)) {
			String realFile = filepath +"\\"+eimg;
			File f = new File(realFile);
			if( f.exists()) f.delete();
		}
		
		
		
		// BoardDTO �뤆�룇鍮섊뙼�뮋�삕繹먲옙�뜝�럡�뎽
		NoticeDTO dto=new NoticeDTO();
		// set嶺뚮∥�뾼�땻�슪�삕獄��씛�삕占쎄퉰占쎈퉲�뜝占� num name subject content �뜝�룞�삕�뜝�럩�궋
		dto.setNotice_num(num);
		dto.setUser_id(sessionId);
		dto.setNotice_sub(subject);
		dto.setNotice_content(content);
		dto.setNotice_image(fileName);

		// �뜝�럥�빢�뜝�럩�젧�뜝�럩�굚�뜝�럥�뵜
		// BoardDAO �뤆�룇鍮섊뙼�뮋�삕繹먲옙�뜝�럡�뎽
		NoticeDAO dao=new NoticeDAO();
		// 占쎈뎨占쎈뿪�돇�뜝�럥留됧뜝�럩援ⓨ뜝�럥�뵪�뜝�럩踰� updateBoard(BoardDTO �솻洹⑥삕�뜝�럥�빢)嶺뚮∥�뾼�땻�슪�삕獄�占� �뜝�럩�젧�뜝�럩踰� 
		// �뜝�럥�꺏占쎈쑏熬곣뫗�굚�뜝�럥�뵜 �썒�슣�닔占쎄틬占쎈ご�뜝占� �뜝�럥苑겼뜝�럥�돵�뜝�럡�맋 updateBoard(BoardDTO �썒�슣�닔占쎄틬�뤆�룊�삕) �뜝�럩源덌옙鍮듿뜝占�
		dao.updateNotice(dto);
		// list.jsp �뜝�럩逾졾뜝�럥吏�
//		response.sendRedirect("list.jsp");
		ActionForward forward=new ActionForward();
		forward.setPath("./NoticeList.no");
		forward.setRedirect(true);
		return forward;
	}
}
