package com.qna_comm.db;

import java.sql.Connection;
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

import com.qna.db.QnaDTO;


public class QnaCommDAO {
	
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

	public void insertQnaComm(QnaCommDTO dto) {
		try {
			con = getConnection();
			String sql2 = "select max(comm_num) from qna_comment where qna_num=?";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1, dto.getQna_num());
			
			rs=pstmt2.executeQuery();
			
			int comm_num=0;
			if(rs.next()) {
				comm_num=rs.getInt("max(comm_num)")+1;
			}
			String sql="insert into qna_comment (qna_num ,comm_num, comm_content, comm_date, user_id) values(?,?,?,?,?)";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, dto.getQna_num());
			pstmt.setInt(2, comm_num);
			pstmt.setString(3, dto.getComm_content());
			pstmt.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(5, dto.getUser_id());
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public List<QnaCommDTO> getCommList(int startRow,int pageSize,int qna_num) {
		List<QnaCommDTO> commList = new ArrayList<QnaCommDTO>();
		try {
			con = getConnection();
			String sql="select * from (select ROW_NUMBER() OVER(ORDER BY comm_num) comm_index, comm_num, user_id, comm_content, comm_date from qna_comment where qna_num=?) A order by A.comm_index limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while (rs.next()) {
				QnaCommDTO dto=new QnaCommDTO();
				dto.setComm_index(rs.getInt("comm_index"));
				dto.setComm_num(rs.getInt("comm_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setComm_content(rs.getString("comm_content"));
				dto.setComm_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("comm_date")));
				
				commList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return commList;
		
	}
	
	public QnaCommDTO getQnaComm(int qna_num ,int comm_num) {
		QnaCommDTO dto=null;
		try {
			con = getConnection();
			String sql="select * from qna_comment where qna_num=? and comm_num=? ";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.setInt(2, comm_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new QnaCommDTO();
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setComm_num(rs.getInt("comm_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setComm_content(rs.getString("comm_content"));
				dto.setComm_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("comm_time")));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}
	
	public void updateComm(QnaCommDTO dto) {
		try {
			con = getConnection();
			
			String sql="update qna_comment set comm_content=? where qna_num=? and comm_num=?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, dto.getComm_content());
			pstmt.setInt(2, dto.getQna_num());
			pstmt.setInt(3, dto.getComm_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return;
	}	
	
	public void deleteComm(int qna_num, int comm_num) {
		try {
			con = getConnection();
			
			String sql="delete from qna_comment where qna_num = ? and comm_num = ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
			pstmt.setInt(2, comm_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}	
		return;
	}
	
	public int getQnaCommCount(int qna_num) {
		int count=0;
		try {
			con = getConnection();
			String sql="select count(*) from qna_comment where qna_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna_num);
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
	
	
	
}
