package com.reservation.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ReservationDAO {
	
	private Connection con = null;
	private String sql = "";
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private Connection getConnect() {
		try {
			Context init = new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Mysql");
			con = ds.getConnection();

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public Map<String, List<Integer>> getResCarDate(String car_model) {
		Map<String, List<Integer>> car_res = new HashMap<String, List<Integer>>();
		try {
			con = getConnect();
			sql = "select  CONCAT('\"',DATE_FORMAT(r.res_stime,'%Y%m%d'),'\"')  as res_date, DATE_FORMAT(r.res_stime,'%h') as stime, r.res_time as res_time "
				+ "from carinfo c join reservation r "
				+ "on c.car_num = r.res_car_num "
				+ "where c.car_model = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, car_model);
			System.out.println(car_model);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String date = rs.getString("res_date");
				int stime =  Integer.parseInt(rs.getString("stime"));
				
				car_res.put(date, new ArrayList<Integer>());
				System.out.println("date : " + date);
				System.out.println("stime : " + stime);
				for(int i = 0; i < rs.getInt("res_time"); i++) {
					if(!car_res.get(date).contains(stime+i)) {
						car_res.get(date).add(stime + i);
					}
				}
				System.out.println(car_res.get(date));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return car_res;
	}
	
	public void insertReservation(String uid, String carNum, String stime, int time, String userId) {
		try {
			con = getConnect();
			sql = "insert into reservation(res_num, res_car_num, res_stime, res_time, user_id)"
				+ "values(?, ?, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, uid);
			pstmt.setString(2, carNum);
			pstmt.setString(3, stime.split(" ~ ")[0]);
			pstmt.setInt(4, time);
			pstmt.setString(5, userId);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	public void plusPoint(int price, String user_id) {
		try {
			con = getConnect();
			sql = "update userinfo set user_pt=user_pt+? where user_id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, price/10);
			pstmt.setString(2, user_id);
			
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	public void minusPoint(int point, String user_id) {
		try {
			con = getConnect();
			sql = "update userinfo set user_pt=user_pt-? where user_id=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, point);
			pstmt.setString(2, user_id);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public void returnRes(String res_num) {
		try {
			con = getConnect();
			sql = "update reservation set return_car=1 where res_num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, res_num);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	private void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
