package com.user.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.qna.db.QnaDTO;
import com.reservation.db.ReservationDTO;



public class UserDAO {
		Connection con = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		
		// DB占쎈쐻占쎈윥占쎈옘占쎈눇�뙼蹂��굲
		public Connection getConnection() throws Exception {
			Context init = new InitialContext();
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/Mysql");
			con = ds.getConnection();
			return con;
		}
		
		// 占쎈섀饔낅챸占쏙퐛�젂占쎈Ŋ�굲�뜝�럩沅뗰옙�쐻占쎈윥�댆戮⑸쐻占쎈윥占쎈뤅占쎈쐻占쎈윪占쎌졆
		public void close() {
			if(rs!=null) try{rs.close();} catch(SQLException ex) {}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex) {}
			if(pstmt1!=null) try{pstmt1.close();}catch(SQLException ex) {}
			if(con!=null) try{con.close();}catch(SQLException ex) {}
		}
		
		
		// insert
		public void insertUser(UserDTO dto) {
			try {
				con = getConnection();
				String sql1 = "select max(user_num) from userinfo";
				pstmt1 = con.prepareStatement(sql1);
				rs = pstmt1.executeQuery();
				
				//占쎈쐻占쎈윪占쎈쨧占쎈쐻占쎈윪占쎌맱占쎈탶�⑤베�맇�뜝�럡�돭占쎈쐻占쎈윥獒뺧옙 占쎈쨬占쎈즸占쎌굲占쎈쐻占쎈윪�굢占쏙옙�쐻占쎈윥筌띾맕�쐻占쎈윥�몴�떦異�占쎌뵯占쎌맄�뜝�럥�렡 1占쎈쐻占쎈윥占쎈윝 �뜝�럥�뒗占쎄콬鶯ㅼ룊�삕. 
				int num = 0; 
				if(rs.next()) {
					System.out.println(rs.getInt("max(user_num)"));
					num = rs.getInt("max(user_num)") + 1;
					System.out.println(num);
				}
				
				System.out.println(dto);
				System.out.println("占쎈쐻占쎈짗占쎌굲占쎈쐻占쎈윪占쎄텑占쎈쐻占쎈윥壤쏉옙 user_num : " + dto.getUser_num());
				
				String sql2="insert into userinfo(user_num, user_id , user_pass , user_name, user_hp, email, address, user_birth, license_num, license_type) values(?,?,?,?,?,?,?,?,?,?)";
				pstmt2 = con.prepareStatement(sql2);
				pstmt2.setInt(1, num);
				pstmt2.setString(2, dto.getUser_id());
				pstmt2.setString(3, dto.getUser_pass());
				pstmt2.setString(4, dto.getUser_name());
				pstmt2.setString(5, dto.getUser_hp());
				pstmt2.setString(6, dto.getEmail());
				pstmt2.setString(7, dto.getAddress());
				pstmt2.setString(8, dto.getUser_birth());
				pstmt2.setString(9, dto.getLicense_num());
				pstmt2.setString(10, dto.getLicense_type());
				pstmt2.executeUpdate();
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
			return;
		}
		
		public UserDTO UserCheck(String user_id, String user_pass) {
			
			UserDTO dto = null;
			
			try {
				con = getConnection();
				String sql="select * from userinfo where user_id=? and user_pass=?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setString(1, user_id);
				pstmt1.setString(2, user_pass);
				
				rs = pstmt1.executeQuery();
				
				if(rs.next()){
					dto = new UserDTO();
					//占쎈쐻占쎈윥占쎄틣�뜝�럥�몡�넭怨ｋ쳳占쎈군占쎈쐻占쎈윞占쎈쭓 占쎈쨬占쎈즸占쎌굲占쎈쐻占쎈윪雅뚎껊쐻占쎈윪亦낉옙 占쎈쐻占쎈윥占쎈ぅ占쎈쐻占쎈윪�얠±�쐻占쎈윞占쎈뙃占쎈쨬占쎈즴�뜝�뜫援�獄�占� dto占쎈쐻占쎈윥占쎈군 占쎈쐻占쎈윥�젆戮⑸쐻占쎈윥占쎈떋濚욌꼬�슦�굲.
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_pass(rs.getString("user_pass"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_hp(rs.getString("user_hp"));
					dto.setEmail(rs.getString("email"));
					dto.setAddress(rs.getString("address"));
					dto.setLicense_num(rs.getString("license_num"));
					dto.setLicense_type(rs.getString("license_type"));
					dto.setUser_pt(rs.getInt("user_pt"));
					
					System.out.println("�뜝�럥�뿰�뼨轅명�ｈ땻占� �뜝�럩�꼪�뜝�럩逾�: " + dto.getUser_name());
				}else{
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
			return dto;
		}
		
		public List<UserDTO> getUserList() {
			List<UserDTO> userList = new ArrayList<UserDTO>();
			try {
				con = getConnection();
				String sql="select * from userinfo";
				pstmt1 = con.prepareStatement(sql);
				rs = pstmt1.executeQuery();
				
				//�뜝�럥�맗�뜝�럥�땻�뜝�럥�돱 占쎈쐻占쎈윥�젆袁��쐻占쎈윥筌묕옙 占쎈눇�뙼�맪占쎌���삕亦끸궗琉놅옙猷딉옙�굲 占쎈쐻占쎈윥�뵳�띂夷배�占쎈쳮占쎌뼲�삕 dto占쎈쐻占쎈윥占쎈군 占쎈쐻占쎈윥�젆戮ル섀饔낅챸占쎌�⑤뼀占쎌뵛占쎌굲嶺뚮엪�삕.
				while(rs.next()){
					UserDTO dto = new UserDTO();
					dto.setUser_num(rs.getInt("user_num"));
					dto.setUser_id(rs.getString("user_id"));
					dto.setUser_pass(rs.getString("user_pass"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_hp(rs.getString("user_hp"));
					dto.setUser_birth(rs.getString("user_birth"));
					dto.setEmail(rs.getString("email"));
					dto.setAddress(rs.getString("address"));
					dto.setLicense_num(rs.getString("license_num"));
					dto.setLicense_type(rs.getString("license_type"));
					dto.setUser_pt(rs.getInt("user_pt"));
					userList.add(dto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
			}
			return userList;
		}public void updateUserinfo(UserDTO dto) {
			System.out.println("FirstDAO updateFirst");
			System.out.println("dto " + dto);
			
			try {
				con = getConnection();
				String sql = "update userinfo set user_name=? ,user_pass=? ,user_hp=?, email=?, address=?,license_num=?, license_type=?   where user_id =?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setString(1, dto.getUser_name());
				pstmt1.setString(2, dto.getUser_pass());
				pstmt1.setString(3, dto.getUser_hp());
				pstmt1.setString(4, dto.getEmail());
				pstmt1.setString(5, dto.getAddress());
				pstmt1.setString(6, dto.getLicense_num());
				pstmt1.setString(7, dto.getLicense_type());
				pstmt1.setString(8, dto.getUser_id());
				
				pstmt1.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
			return;
			
		} public void deleteUserinfo(UserDTO dto) {
			
			try {
				con = getConnection();
				
				String sql="delete from review where user_id=?";
				pstmt1=con.prepareStatement(sql);
				pstmt1.setString(1, dto.getUser_id());
				pstmt1.executeUpdate();
				
				String sql2="delete from reservation where user_id=?";
				pstmt1=con.prepareStatement(sql2);
				pstmt1.setString(1, dto.getUser_id());
				pstmt1.executeUpdate();
				
				String sql3="delete from qna_comment where user_id=?";
				pstmt1=con.prepareStatement(sql3);
				pstmt1.setString(1, dto.getUser_id());
				pstmt1.executeUpdate();
				
				String sql4 = "select * from qna where user_id=?";
				
				
				String sql5 = "delete from qna_comment where qna_num=?";
				
				
				String sql6 ="delete from qna where user_id=?";
				pstmt1=con.prepareStatement(sql6);
				pstmt1.setString(1, dto.getUser_id());
				pstmt1.executeUpdate();
				
				String sql7 ="delete from userinfo where user_id=?";
				pstmt1=con.prepareStatement(sql7);
				pstmt1.setString(1, dto.getUser_id());
				pstmt1.executeUpdate();
//				pstmt.setString(2, dto.getUser_pass());
//				pstmt.setString(3, dto.getUser_name());
//				pstmt.setString(4, dto.getUser_hp());
//				pstmt.setString(5, dto.getEmail());
//				pstmt.setString(6, dto.getAddress());
//				pstmt.setInt(7, dto.getUser_pt());
//				pstmt.setString(8, dto.getLicense_num());
//				pstmt.setString(9, dto.getLicense_type());
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
			return;
		} public List<QnaDTO> getMypageQnaList(String sessionId,int startRow,int pageSize) {
			List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
			try {
				con = getConnection();
				
				String sql=	"select * from (select ROW_NUMBER() OVER(ORDER BY qna_num) qna_index, qna_num, user_id,\r\n"
						+ "	qna_sub, qna_content, qna_date, qna_readcount, qna_secret, qna_image from qna) A \r\n";
						if(!sessionId.equals("admin")) {
							sql+= "where user_id = ? \r\n";
						}
						sql += "order by A.qna_index desc limit ?,?;";
				pstmt1=con.prepareStatement(sql);
				if(!sessionId.equals("admin")) {
					pstmt1.setString(1, sessionId);
					pstmt1.setInt(2, startRow-1);
					pstmt1.setInt(3, pageSize);
				}else {
					pstmt1.setInt(1, startRow-1);
					pstmt1.setInt(2, pageSize);
				}
				rs=pstmt1.executeQuery();
				
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
		public int getQnaCount(String sessionId) {
			int count=0;
			try {
				con = getConnection();
				String sql="select count(*) from qna ";
						if(!sessionId.equals("admin")) {
							sql+= "where user_id = ?";
						}
				pstmt1=con.prepareStatement(sql);
				if(!sessionId.equals("admin")) {
					pstmt1.setString(1, sessionId);
				}
				
				rs=pstmt1.executeQuery();
				if(rs.next()) {
					count=rs.getInt("count(*)"); 
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return count;
		} public boolean confirmId(String user_id) {
			boolean result = false;
			try {
				con = getConnection();
				String sql="select * from userinfo where user_id=?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setString(1, user_id);
				rs = pstmt1.executeQuery();
				
				if(rs.next()) {
					result = true;
					System.out.println(result);
				} else {
					result = false;
				}
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
			}
			return result;
			
		}
		
		public String FindID(String user_name, String user_email) {
			try {
				con = getConnection();
				String sql="select * from userinfo where user_name=? and email=?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setString(1, user_name);
				pstmt1.setString(2, user_email);
				
				rs = pstmt1.executeQuery();
				
				
				while(rs.next()){
					
					return rs.getNString("user_id");
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
		
			return null;
		}
		
		public String FindPass(String user_id, String user_email) {
			try {
				con = getConnection();
				String sql="select * from userinfo where user_id=? and email=?";
				pstmt1 = con.prepareStatement(sql);
				pstmt1.setString(1, user_id);
				pstmt1.setString(2, user_email);
				
				rs = pstmt1.executeQuery();
				
				
				while(rs.next()){
					
					return rs.getNString("user_pass");
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				
			}
		
			return null;
		} 
		// �솻洹ｋ샑�굢占� �솻洹ｋ쾴亦낆�⑦돦�뜝占�
//		public ReservationDTO getCarUserinfo(String user_id) {
//			ReservationDTO dto = null;
//			try {
//				con = getConnection();
//				String sql = "select r.user_id, r.res_num, r.res_car_num, r.res_stime, r.res_time, r.return_car from userinfo u join reservation r  on (u.user_id = r.user_id) where u.user_id=?";
//				pstmt1 = con.prepareStatement(sql);
//				pstmt1.setString(1, user_id);
////				pstmt.setInt(2, dto.getRes_num());
////				pstmt.setString(3, dto.getRes_car_num());
////				pstmt.setString(4, dto.getRes_stime());
////				pstmt.setInt(5, dto.getRes_time());
////				pstmt.setInt(6, dto.getReturn_car());
//
//				rs = pstmt1.executeQuery();
//
//				if (rs.next()) {
//					dto = new ReservationDTO();
//
//					dto.setUser_id(rs.getString("user_id"));
//					dto.setRes_num(rs.getInt("res_num"));
//					dto.setRes_car_num(rs.getString("res_car_num"));
//					dto.setRes_stime(rs.getString("res_stime"));
//					dto.setRes_time(rs.getInt("res_time"));
//					dto.setReturn_car(rs.getInt("return_car"));
////					dto.setReturn_car(rs.getInt("user_num"));
//
//				} else {
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//
//			} finally {
//
//			}
//			return dto;
			
			
			
			// list

				

				
				
				
		public List<ReservationDTO> getresList(String sessionId, int startRow, int pageSize) {

	         List<ReservationDTO> resList = new ArrayList<ReservationDTO>();
	         try {
	            // 1,2 �뜝�럥�렭�뜝�룞�삕   占쎌뼔占썬룗�몡�넭怨ｋ쳳占쎈옘占쎈눇�뜝占� 
	            con = getConnection();
	            // 3 sql
	            String sql = "select * from reservation \r\n";
	            		if(!sessionId.equals("admin")) {
							sql+= "where user_id = ? \r\n";
						}
	            		sql += "order by res_num desc limit ?,?;";
	            pstmt1 = con.prepareStatement(sql);
	            if(!sessionId.equals("admin")) {
	            	pstmt1.setString(1, sessionId);
	            	pstmt1.setInt(2, startRow - 1);
	  	            pstmt1.setInt(3, pageSize);
	            } else {
	            	pstmt1.setInt(1, startRow - 1);
	  	            pstmt1.setInt(2, pageSize);
	            }
	          
	            rs = pstmt1.executeQuery();
	            while (rs.next()) {
	               ReservationDTO dto = new ReservationDTO();
					dto.setUser_id(rs.getString("user_id"));
					dto.setRes_num(rs.getString("res_num"));
					dto.setRes_car_num(rs.getString("res_car_num"));
					dto.setRes_stime(rs.getString("res_stime"));
					dto.setRes_time(rs.getInt("res_time"));
					dto.setReturn_car(rs.getInt("return_car"));
					resList.add(dto);
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            close();
	         }
	         // 占쎈쎗占쎈즲占쏙퐟援℡뜝占� �뜝�럥爰� 占쎌뜏占쎌뒩占쎈땾�뜝�럡�떖 �뜝�럥�렓�뜝�럥肉わ옙�룈
	         return resList;
	      }// getBoardList()
		
		
			public List<UserDTO> getUserList2(int startRow, int pageSize) {

	         List<UserDTO> userList = new ArrayList<UserDTO>();
	         try {
	            // 1,2 �뜝�럥�렭�뜝�룞�삕   占쎌뼔占썬룗�몡�넭怨ｋ쳳占쎈옘占쎈눇�뜝占� 
	            con = getConnection();
	            // 3 sql
	            String sql = "select * from userinfo ";
	            sql += "order by user_num desc limit ?,?";
	            pstmt1 = con.prepareStatement(sql);
	            pstmt1.setInt(1, startRow - 1);
	            pstmt1.setInt(2, pageSize);
	            rs = pstmt1.executeQuery();
	            while (rs.next()) {
	               UserDTO dto = new UserDTO();
	               dto.setUser_num(rs.getInt("user_num"));
	               dto.setUser_id(rs.getString("user_id"));
	               dto.setUser_pass(rs.getString("user_pass"));
	               dto.setUser_name(rs.getString("user_name"));
	               dto.setUser_hp(rs.getString("user_hp"));
	               dto.setUser_birth(rs.getString("user_birth"));
	               dto.setEmail(rs.getString("email"));
	               dto.setAddress(rs.getString("address"));
	               dto.setLicense_num(rs.getString("license_num"));
	               dto.setLicense_type(rs.getString("license_type"));
	               dto.setUser_pt(rs.getInt("user_pt"));
	               userList.add(dto);
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            close();
	         }
	         // 占쎈쎗占쎈즲占쏙퐟援℡뜝占� �뜝�럥爰� 占쎌뜏占쎌뒩占쎈땾�뜝�럡�떖 �뜝�럥�렓�뜝�럥肉わ옙�룈
	         return userList;
	      }// getBoardList()
	      
	      
	      public int getUserCount2() {
	         int count = 0;
	         try {
	            // 1,2  占쎌뼔占썬룗�몡�넭怨ｋ쳳占쎈옘占쎈눇�뜝占� 
	            con = getConnection();
	            // 3 sql
	            String sql = "select count(*) from userinfo";
	            pstmt1 = con.prepareStatement(sql);
	            // 4  �뜝�럥�렡 嶺뚮쵓�삕 => 占쎈눇�뙼�맪占쎌���삕亦낉옙    �뜝�럩沅�
	            rs = pstmt1.executeQuery();
	            // 5 占쎈눇�뙼�맪占쎌���삕亦낉옙  �뜝�럩�젞占쎌쐺�뜝占�  占쎈섀�뜝占� 占쎈쨬占쎈즵獒뺣돍�삕占쎈묄 占쎈쨬�뜝占�  �댖怨ㅼ삕 �뜝�럡�뀞占쎈섀�뜝占� 
	            if (rs.next()) {
	               count = rs.getInt("count(*)");
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            close();
	         }
	         return count;
	      }
	
	      public int getUserPoint(String user_id) {
	    	  int user_pt = 0;
	    	  try {
	  			con = getConnection();
	  			String sql = "select user_pt from userinfo where user_id=?";
	  			PreparedStatement pstmt = con.prepareStatement(sql);
	  			
	  			pstmt.setString(1, user_id);
	  			
	  			pstmt.executeQuery();
	  			rs = pstmt.executeQuery();
	  			
	  			if(rs.next()) {
	  				user_pt = rs.getInt("user_pt");
	  			}
	  			
	  		} catch (Exception e) {
	  			e.printStackTrace();
	  		} finally {
	  			close();
	  		}
	    	  return user_pt;
	      }
		
		//todo
		public UserDTO getUserinfo(String user_id) {
		      UserDTO dto = null;
		      
		      try {
		         con = getConnection();
		         String sql="select * from userinfo where user_id=?";
		         pstmt1 = con.prepareStatement(sql);
		         pstmt1.setString(1, user_id);
//		         pstmt.setString(2, dto.getUser_pass());
//		         pstmt.setString(3, dto.getUser_name());
//		         pstmt.setString(4, dto.getUser_hp());
//		         pstmt.setString(5, dto.getEmail());
//		         pstmt.setString(6, dto.getAddress());
//		         pstmt.setInt(7, dto.getUser_pt());
//		         pstmt.setString(8, dto.getLicense_num());
//		         pstmt.setString(9, dto.getLicense_type());
		         
		         
		         
		         rs=pstmt1.executeQuery();
		         
		         if(rs.next()) {
		            
		            dto = new UserDTO();
		            
		            dto.setUser_id(rs.getString("user_id"));
		            dto.setUser_pass(rs.getString("user_pass"));
		            dto.setUser_name(rs.getString("user_name"));
		            
		         }else {
		            
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      
		      }finally {
		         
		      }
		      System.out.println(dto);
		      return dto;
		   }

		
}

