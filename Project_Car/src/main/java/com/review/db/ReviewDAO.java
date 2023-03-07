package com.review.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.car.db.CarInfoDTO;


public class ReviewDAO {

	Connection con=null;
	PreparedStatement pstmt2=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;

	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Mysql");
		con=ds.getConnection();
		
		return con;
	}
	
	
	public void close() {
		if(rs!=null) try{rs.close();} catch(SQLException ex) {}
		if(pstmt2!=null) try{pstmt2.close();} catch(SQLException ex) {}
		if(pstmt!=null) try{pstmt.close();} catch(SQLException ex) {}
		if(con!=null) try{con.close();} catch(SQLException ex) {}
	}
	
	
	public void insertReview(ReviewDTO dto) {
		
		try {
			con=getConnection();

			String sql2="select max(review_num) from review";
			pstmt2=con.prepareStatement(sql2);
			rs=pstmt2.executeQuery();
			
			int review_num=0;
			if(rs.next()) {
				review_num=rs.getInt("max(review_num)")+1;
				
			}
			
//			String sql="insert into review(review_num, user_id, car_num, review_star, review_content, review_date, res_num) values(?,?,?,?,?,?,?)";
			String sql="insert into review(review_num, user_id, car_num, review_content, review_star, review_date) \r\n"
					+ "values(?,?,?,?,?,?);";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, review_num);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getCar_num());
			pstmt.setString(4, dto.getReview_content());
			pstmt.setString(5, dto.getReview_star());
			pstmt.setTimestamp(6, dto.getReview_date());
			
			
			pstmt.executeUpdate();
			
			System.out.println(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			close();
		}
	}//insertReview()
	
	
	
	
	
	public List<ReviewDTO> getReviewList(int startRow, int pageSize, String user_id) {
		
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			String sql="select r.car_num, r.review_num, r.user_id, r.review_star, r.review_content, r.review_date, c.car_image\r\n"
					 + "  from review r join carinfo c\r\n"
				   	 + "    on r.car_num = c.car_num ";
					 if(!user_id.equals("admin")) {
						 sql+= " where r.user_id=?";
					 }
				   	 sql+= "order by review_num desc limit ?,?";
			pstmt= con.prepareStatement(sql);
			 if(!user_id.equals("admin")) {
				 pstmt.setString(1, user_id);
				 pstmt.setInt(2, startRow-1);
				 pstmt.setInt(3, pageSize);
			 } else  {
				 pstmt.setInt(1, startRow-1);
				 pstmt.setInt(2, pageSize);
			 }
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setReview_num(rs.getInt("review_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setReview_star(rs.getString("review_star"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_date(rs.getTimestamp("review_date"));
				dto.setCar_image(rs.getString("car_image"));
				
				reviewList.add(dto);
			}
			System.out.println();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return reviewList;
	
	}//reivewList()	
	
	
	
	public ReviewDTO getReivew(int review_num) {
		ReviewDTO dto = null;
		
		try {
			con = getConnection();
			String sql="select * from review where review_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,review_num);

			rs=pstmt.executeQuery();
			
			if(rs.next()){
				dto = new ReviewDTO(); 
				dto.setReview_num(review_num);
				dto.setUser_id(rs.getString("user_id"));
				dto.setCar_num(rs.getString("car_num"));
				dto.setReview_star(rs.getString("review_star"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_date(rs.getTimestamp("review_date"));

			} else {
			}		
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return dto; 
	} //getReview()
	

	public void updatetReadcount(int review_num) {
			
		try {
			con = getConnection();
			
			String sql="update review set readcount=readcount+1 where review_num=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setInt(1,review_num);

			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();	
		}

	}//updatetReadcount() 嶺뚮∥�뾼�땻�슪�삕獄�占�
	
	public void updateReivew(ReviewDTO dto) {
		
		
		try {
			con = getConnection();
			
			String sql="update review set review_content=?, review_star=? where review_num=?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1,dto.getReview_content());
			pstmt.setString(2, dto.getReview_star());
			pstmt.setInt(3,dto.getReview_num());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	return;
	}//updateReview() 嶺뚮∥�뾼�땻�슪�삕獄�占�
	
	
	
	public void deleteReview(int review_num) {

		
		try {
			con=getConnection();
			
			String sql="delete from review where review_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,review_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return;
		
	}//deleteReview()
	
	
	
	
	public int getReviewCount(CarInfoDTO carDTO) {
		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) "
					+ "from carinfo car join review re "
					+ "on car.car_num = re.car_num "
					+ "where car.car_model=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,carDTO.getCar_model());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");  
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return count;
	}	
	
	public int getReviewCount(String user_id) {
		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from review where user_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,user_id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt("count(*)");  
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return count;
	}
	
	
public List<ReviewDTO> getCarReviewList(int startRow, int pageSize, String car_num) {
		
		List<ReviewDTO> carReviewList=new ArrayList<ReviewDTO>();
		
		try {
			con=getConnection();
			
			String sql="select c.car_num, r.review_content, r.user_id,  r.review_star, r.review_date\r\n"
					+ "  from review r join carinfo c\r\n"
					+ "   on r.car_num = c.car_num\r\n"
					+ " where c.car_model = (select car_model \r\n"
					+ "                  	 from carinfo \r\n"
					+ "                  	 where car_num=?)\r\n"
					+ " order by review_date desc limit ?,?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1,car_num);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setUser_id(rs.getString("user_id"));
				dto.setReview_star(rs.getString("review_star"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_date(rs.getTimestamp("review_date"));
				
				
				carReviewList.add(dto);
			}
			System.out.println();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return carReviewList;
	
	}//reivewList()	

public List<ReviewDTO> getMainReviewList() {
	
	List<ReviewDTO> carReviewList=new ArrayList<ReviewDTO>();
	
	try {
		con=getConnection();
		
		String sql="select r.review_star, r.user_id, r.review_content, c.car_model\r\n"
				 + "  from review r join carinfo c\r\n"
			 	 + "    on r.car_num = c.car_num\r\n"
				 + "order by r.review_date desc limit 5";
		pstmt=con.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			ReviewDTO dto = new ReviewDTO();
			dto.setUser_id(rs.getString("user_id"));
			dto.setReview_star(rs.getString("review_star"));
			dto.setReview_content(rs.getString("review_content"));
			dto.setCar_model(rs.getString("car_model"));
			
			
			carReviewList.add(dto);
		}
		System.out.println();
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		close();
	}
	return carReviewList;

}//reivewList()	
	
	
}