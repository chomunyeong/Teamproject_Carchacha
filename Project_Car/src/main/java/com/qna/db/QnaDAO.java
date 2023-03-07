package com.qna.db;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class QnaDAO {
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
		if(con!=null) try{con.close();}catch(SQLException ex) {}
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex) {}
		if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
		if(rs!=null) try{rs.close();}catch(SQLException ex) {}
	}

	public void insertQna(QnaDTO dto) {
		try {
			con = getConnection();
			String sql2 = "select max(qna_num) from qna";
			pstmt2 = con.prepareStatement(sql2);
			rs=pstmt2.executeQuery();
			
			int qna_num=0;
			if(rs.next()) {
				qna_num=rs.getInt("max(qna_num)")+1;
			}
			String sql="insert into qna(qna_num, user_id, qna_sub, qna_content, qna_readcount, qna_date, qna_secret, qna_image) value(?,?,?,?,?,?,?,?)";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getQna_sub());
			pstmt.setString(4, dto.getQna_content());
			pstmt.setInt(5, dto.getQna_readcount());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(7, dto.getQna_secret());
			pstmt.setString(8, dto.getQna_image());
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
	}
	
	public List<QnaDTO> getQnaList(int startRow,int pageSize) {
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();
			String sql="select * from (select ROW_NUMBER() OVER(ORDER BY qna_num) qna_index, qna_num, user_id, qna_sub, qna_content, qna_date, qna_readcount, qna_secret, qna_image from qna) A order by A.qna_index desc limit ?,? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				QnaDTO dto=new QnaDTO();
				dto.setQna_index(rs.getInt("qna_index"));
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setQna_sub(rs.getString("qna_sub"));
				dto.setQna_content(rs.getString("qna_content"));
				dto.setQna_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("qna_date")));
				dto.setQna_readcount(rs.getInt("qna_readcount"));
				dto.setQna_secret(rs.getString("qna_secret"));
				dto.setQna_image(rs.getString("qna_image"));
				
				qnaList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return qnaList;
	}// getBoardList
	
	public QnaDTO getQna(int qna_num) {
		QnaDTO dto=null;
		try {
			con = getConnection();
			String sql="select * from qna where qna_num=? ";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new QnaDTO();
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setQna_sub(rs.getString("qna_sub"));
				dto.setQna_content(rs.getString("qna_content"));
				dto.setQna_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("qna_date")));
				dto.setQna_readcount(rs.getInt("qna_readcount"));
				dto.setQna_secret(rs.getString("qna_secret"));
				dto.setQna_image(rs.getString("qna_image"));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}

	public void updateQnaReadcount(int qna_num) {
		try {
			con = getConnection();
			
			String sql="update qna set qna_readcount=qna_readcount+1 where qna_num=? ";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

	}
	
	public void updateQna(QnaDTO dto, boolean imageChange, String filepath) {
		QnaDTO dto2 = getQna(dto.getQna_num());
		try {
			if(imageChange) {
				String deleteImage = dto2.getQna_image();
				File deleteImageName = new File (filepath + "\\" + deleteImage);
				
				deleteImageName.delete();
			}
			con = getConnection();
			String sql="update qna set qna_sub=?, qna_content=?, qna_secret=?, qna_image=? where qna_num=?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, dto.getQna_sub());
			pstmt.setString(2, dto.getQna_content());
			pstmt.setString(3, dto.getQna_secret());

			if(imageChange) {
				pstmt.setString(4, dto.getQna_image());
			} else {
				pstmt.setString(4, dto2.getQna_image());
			}
			pstmt.setInt(5, dto.getQna_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return;
	}	
	
	
	public void deleteQna(int qna_num, String filepath) {
		QnaDTO dto = getQna(qna_num);
		try {
			String deleteImage = dto.getQna_image();
			File deleteImageName = new File (filepath + "\\" + deleteImage);
			
			deleteImageName.delete();
			con = getConnection();
			
			String sql="delete from qna_comment where qna_num = ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			
			pstmt.executeUpdate();
			
			String sql2="delete from qna where qna_num = ?";
			pstmt2 =con.prepareStatement(sql2);
			pstmt2.setInt(1, qna_num);
			
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return;
	}
	
	public int getQnaCount() {
		int count=0;
		try {
			con = getConnection();
			String sql="select count(*) from qna";
			pstmt=con.prepareStatement(sql);
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
	
	public int getNextQna(int qna_num) {
		int nextQnaNum =0;
		try {
			con = getConnection();
			String sql="select *\r\n"
					+ "from (select *\r\n"
					+ "	       from qna\r\n"
					+ "	      where qna_num between ? and (select max(qna_num)\r\n"
					+ "									     from qna)\r\n"
					+ "order by qna_num limit 2) A\r\n"
					+ "order by A.qna_num desc limit 1;";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				nextQnaNum=rs.getInt("qna_num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return nextQnaNum;
	}
	public int getBeforeQna(int qna_num) {
		int beforeQnaNum =0;
		try {
			con = getConnection();
			String sql="select *\r\n"
					+ "from (select *\r\n"
					+ "	    from qna\r\n"
					+ "	   where qna_num between (select min(qna_num) from qna) and ?\r\n"
					+ "order by qna_num desc limit 2) A\r\n"
					+ "order by A.qna_num limit 1";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				beforeQnaNum = rs.getInt("qna_num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return beforeQnaNum;
	}
	
}
