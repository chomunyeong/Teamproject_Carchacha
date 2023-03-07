package com.car.action;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.car.db.CarInfoDAO;
import com.car.db.CarInfoDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CarInsertPro implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String filepath = request.getSession().getServletContext().getRealPath("car_images");
		
		MultipartRequest multi = new MultipartRequest
				(request, filepath, 
						1024*1024*1024, "utf-8", new DefaultFileRenamePolicy()); 
		
		String car_num=multi.getParameter("car_num");
		String car_place=multi.getParameter("car_place");
		int per_hour=Integer.parseInt(multi.getParameter("per_hour"));
		String car_type=multi.getParameter("car_type");
		int car_year=Integer.parseInt(multi.getParameter("car_year"));
		String car_model=multi.getParameter("car_model");
		String car_brand=multi.getParameter("car_brand");
		String car_image=multi.getFilesystemName("car_image");
		String car_fuel=multi.getParameter("car_fuel");
	
		CarInfoDAO dao = new CarInfoDAO();
		CarInfoDTO dto = new CarInfoDTO();
		
		if(dao.carNumCheck(car_num)>0) {	// ì°? ë²ˆí˜¸ ì¤‘ë³µ ?™•?¸
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.print("<script>");
			out.print("alert('ÀÌ¹Ì µî·ÏµÈ Â÷ ¹øÈ£ÀÔ´Ï´Ù.');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
		}
		
		dto.setCar_num(car_num);
		dto.setCar_place(car_place);
		dto.setPer_hour(per_hour);
		dto.setCar_type(car_type);
		dto.setCar_year(car_year);
		dto.setCar_model(car_model);
		dto.setCar_brand(car_brand);
		dto.setCar_image(car_image);
		dto.setCar_fuel(car_fuel);
		
		dao.insertCar(dto);

		ActionForward forward = new ActionForward();
		forward.setPath("./CarListUser.ci");
		forward.setRedirect(true);
		return forward;
	}
}
