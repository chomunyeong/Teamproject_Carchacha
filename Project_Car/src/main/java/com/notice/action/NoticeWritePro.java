package com.notice.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.notice.db.NoticeDAO;
import com.notice.db.NoticeDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class NoticeWritePro implements Action{
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 疫뀐옙占쎈쾺疫뀐옙 占쎈쨲占쎈퓠占쎄퐣 占쎌뿯占쎌젾占쎈립 占쎄땀占쎌뒠占쎌뱽 占쎄퐣甕곌쑴肉� 占쎌읈占쎈뼎占쎈릭筌롳옙 
		// 占쎄땀占쎌삢揶쏆빘猿� request占쎈퓠 占쏙옙占쎌삢
		// request 占쎈립疫뀐옙筌ｌ꼶�봺
		request.setCharacterEncoding("utf-8");
		// request name,subject,content 占쎈솁占쎌뵬沃섎챸苑� 揶쏉옙占쎌죬占쏙옙占쎄퐣 癰귨옙占쎈땾占쎈퓠 占쏙옙占쎌삢
		
		String filepath = request.getSession().getServletContext().getRealPath("notice_images");
		
		int uploadFileSizeLimit = 5*1024*1024;
		String encType = "UTF-8";
		String uploadFilePath = filepath;
		MultipartRequest multi = null;
		multi = new MultipartRequest(request,uploadFilePath,uploadFileSizeLimit,
					encType,new DefaultFileRenamePolicy());
		
		
		
		String name= multi.getParameter("name");
		String subject=multi.getParameter("subject");
		String content=multi.getParameter("content");
		content = content.replace("\r\n", "<br>");
		String fileName=multi.getFilesystemName("fileName");
		System.out.println("占쎈�믭옙�뮞占쎈뱜 占쎌뿯占쎈빍占쎈뼄" + fileName);
		System.out.println("占쎈�믭옙�뮞占쎈뱜 占쎌뵠�뵳袁⑹뿯占쎈빍占쎈뼄" + name);
		
		
		// 占쎈솭占쎄텕筌욑옙board 占쎈솁占쎌뵬占쎌뵠�뵳猿쬸ardDTO 占쎌쁽獄쏉옙 占쎄깻占쎌삋占쎈뮞 筌띾슢諭얏묾占�
		// 筌롢끇苡�癰귨옙占쎈땾 num,name,subject,content,readcount,date
		// set() get() 筌롫뗄苑뚳옙諭� 占쎌젟占쎌벥

		// BoardDTO揶쏆빘猿쒙옙源�占쎄쉐(疫꿸퀣堉뀐옙�삢占쎈꺖 占쎈막占쎈뼣)
		NoticeDTO dto=new NoticeDTO();
		// set筌롫뗄苑뚳옙諭� 占쎌깈�빊占� 占쎈솁占쎌뵬沃섎챸苑ｅ첎占� 占쏙옙占쎌삢
		dto.setUser_id(name);
		dto.setNotice_sub(subject);
		dto.setNotice_content(content);
		// 占쎌겱占쎈뻻占쎈뮞占쎈�� 占쎄텊筌욎뮇�뻻揶쏉옙
//		dto.setDate(new Timestamp(System.currentTimeMillis()));
		//鈺곌퀬�돳占쎈땾 0 占쎄퐬占쎌젟
		dto.setNotice_readcount(0);
		// 疫뀐옙甕곕뜇�깈 num => BoardDAO占쎈퓠占쎄퐣 占쎌삂占쎈씜
		dto.setNotice_image(fileName);
		

		// 占쎈솭占쎄텕筌욑옙board 占쎈솁占쎌뵬占쎌뵠�뵳猿쬸ardDAO 占쎌쁽獄쏉옙 占쎄깻占쎌삋占쎈뮞 筌띾슢諭얏묾占�
		// BoardDAO 揶쏆빘猿쒙옙源�占쎄쉐(疫꿸퀣堉뀐옙�삢占쎈꺖 占쎈막占쎈뼣)
		NoticeDAO dao=new NoticeDAO();
		// �뵳�뗪쉘占쎈막占쎌굨 占쎈씨占쎌벉 insertBoard(BoardDTO 雅뚯눘�꺖揶쏉옙 占쏙옙占쎌삢占쎈릭占쎈뮉 癰귨옙占쎈땾) 筌롫뗄苑뚳옙諭� 占쎌젟占쎌벥 
		// BoardDAO雅뚯눘�꺖.insertBoard(BoardDTO 雅뚯눘�꺖)筌롫뗄苑뚳옙諭� 占쎌깈�빊占�
		dao.insertNotice(dto);
		//疫뀐옙筌뤴뫖以� 占쎌뵠占쎈짗
//		response.sendRedirect("list.jsp");
		ActionForward forward=new ActionForward();
		forward.setPath("./NoticeList.no");
		forward.setRedirect(true);
		return forward;
	}
}

