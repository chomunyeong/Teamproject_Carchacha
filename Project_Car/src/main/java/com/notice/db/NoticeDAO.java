package com.notice.db;

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

public class NoticeDAO {

	Connection con = null;
	PreparedStatement pstmt2 = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 디비연결하는 메서드 1,2단계
	public Connection getConnection() throws Exception {
		// 예외처리를 함수 호출하는 곳으로 전달

//			//1단계 JDBC 프로그램 가져오기
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			//2단계 JDBC 프로그램 이용해서 데이터베이스 연결
//			String dbUrl="jdbc:mysql://localhost:3306/jspdb2?serverTimezone=Asia/Seoul";
//			String dbUser="root";
//			String dbPass="1234";
//			con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
//			return con;

		// Connection Pool : 서버에서 드라이버로더, 디비연결을
		// 미리하고 그 디비연결 자원의 이름을 부여해서
		// DAO에서 자원의 이름을 호출해서 사용
		// 1. 속도 향상
		// 2. 디비연결정보 수정을 최소화(한 번 만 수정)

		// 설치 : 웹서버에 DBCP(DataBase Connection Pool) 프로그램 설치
		// META-INF 폴더에 context.xml 파일을 만들고
		// 디비연결정보(1,2단계)를 저장 => 자원 이름으로 정의
		// DAO에서 자원 이름을 호출해서 사용

		// Context 객체 생성
		// import javax.naming.Context;
		// import javax.naming.InitialContext;
		Context init = new InitialContext();
		// 자원이름호출("자원위치/자원이름") => DataSource 에 저장
		// import javax.sql.DataSource;
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/Mysql");
		// DataSource => con 에 저장
		con = ds.getConnection();
		return con;

	}

	public void close() {
		// 마무리=> 내장객체 => 기억장소 해제
		// con pstmt pstmt2 rs => 기억장소 해제
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		if (pstmt2 != null)
			try {
				pstmt2.close();
			} catch (SQLException ex) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException ex) {
			}
		if (con != null)
			try {
				con.close();
			} catch (SQLException ex) {
			}
	}

// 리턴할형 없음 insertBoard(BoardDTO 주소값 저장하는 변수) 메서드 정의
	public void insertNotice(NoticeDTO dto) {

		System.out.println("NoticeDAO insertNotice()");
		System.out.println("NoticeDTO 주소값 :" + dto);
		System.out.println("NoticeDTO name :" + dto.getUser_id());
		System.out.println("NoticeDTO subject :" + dto.getNotice_sub());
		System.out.println("NoticeDTO content :" + dto.getNotice_content());
		System.out.println("NoticeDTO readcount :" + dto.getNotice_readcount());
		System.out.println("NoticeDTO date :" + dto.getNotice_date());
		System.out.println("NoticeDTO image :" + dto.getNotice_image());
		try {
			// 1,2 메서드호출
			con = getConnection();
			// 게시판 글번호 구하기 가장 큰번호 +1 => 이번에 입력할 글번호
			// 3. select max(num) from board;
			String sql2 = "select max(notice_num) as maxnum from notice";
			pstmt2 = con.prepareStatement(sql2);
			// 4. 실행 => 결과 저장
			rs = pstmt2.executeQuery();
			// 5. 결과접근 max(num)가져와서 +1
			int num = 0;
			if (rs.next()) {
				num = rs.getInt("maxnum") + 1;
			}
			// 3 sql구문 만들기
			String sql = "insert into notice(notice_num,user_id,notice_sub,notice_content,notice_readcount,notice_date,notice_image) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			// 게시판 글번호
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getNotice_sub());
			pstmt.setString(4, dto.getNotice_content());
			pstmt.setInt(5, dto.getNotice_readcount());
			pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
			pstmt.setString(7, dto.getNotice_image());
			// 4 sql구문 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}// insertBoard()

	// List<BoardDTO> 리턴할형 getBoardList()메서드 정의
	public List<NoticeDTO> getNoticeList(int startRow, int pageSize, String searchField, String searchText) {

		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			// 1,2단계 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select * from notice ";
			if (searchText != null && !searchText.equals("")) {
				sql += "where " + searchField + " LIKE '%" + searchText.trim() + "%'";
			}
			sql += "order by notice_num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4 실행=> 결과저장
			rs = pstmt.executeQuery();
			// 5 while 결과 접근
			// => BoardDTO 객체생성 set호출 디비에서 가져온 값저장
			// => 글하나를 배열한칸에 저장
			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setNotice_sub(rs.getString("notice_sub"));
				dto.setNotice_content(rs.getString("notice_content"));
				dto.setNotice_readcount(rs.getInt("notice_readcount"));
//			dto.setnotice_date(rs.getTimestamp("notice_date"));
				dto.setNotice_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("notice_date")));
				// 배열 한칸에 글한개 저장
				noticeList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		// 배열의 주소 리턴
		return noticeList;
	}// getBoardList()

	// List<BoardDTO> 리턴할형 getBoardList()메서드 정의
	public List<NoticeDTO> MaingetNoticeList(int startRow, int pageSize) {

		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			// 1,2단계 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select * from notice order by notice_num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			// 4 실행=> 결과저장
			rs = pstmt.executeQuery();
			// 5 while 결과 접근
			// => BoardDTO 객체생성 set호출 디비에서 가져온 값저장
			// => 글하나를 배열한칸에 저장
			while (rs.next()) {
				NoticeDTO dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_sub(rs.getString("notice_sub"));
				dto.setNotice_date(new SimpleDateFormat("yyyy-MM-dd").format(rs.getTimestamp("notice_date")));
				// 배열 한칸에 글한개 저장
				noticeList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		// 배열의 주소 리턴
		return noticeList;
	}// getBoardList()


	public NoticeDTO getNotice(int num) {

		NoticeDTO dto = null;
		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select * from (select row_number() OVER(ORDER BY notice_date) notice_rownum,"
					+ " notice_num, user_id, notice_sub, notice_image, notice_content, notice_date, notice_readcount from notice) a "
					+ "where notice_num = ? order by a.notice_rownum desc;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// 5 결과 있으면 => BoardDTO 객체생성
			// =>set메서드호출=> 디비에서 가져온값 저장
			if (rs.next()) {
				// 결과 있으면 =>num에 대한 글있음
				dto = new NoticeDTO();
				dto.setNotice_rownum(rs.getString("notice_rownum"));
				dto.setNotice_num(num);
				dto.setUser_id(rs.getString("user_id"));
				dto.setNotice_sub(rs.getString("notice_sub"));
				dto.setNotice_content(rs.getString("notice_content"));
				dto.setNotice_readcount(rs.getInt("notice_readcount"));
//				dto.setnotice_date(rs.getTimestamp("notice_date"));
				dto.setNotice_date(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(rs.getTimestamp("notice_date")));
				dto.setNotice_image(rs.getString("notice_image")); // 이미지 작업중
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}//

	// -------------------------------------------------------------------------------------------------------------------------------------

	public NoticeDTO nextNotice(int num) {

		NoticeDTO dto = null;
		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select * from (select * from notice "
					+ " where notice_num between ? and (select max(notice_num) from notice) "
					+ "order by notice_num limit 2) a " + "order by a.notice_num desc limit 1; ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// 5 결과 있으면 => BoardDTO 객체생성
			// =>set메서드호출=> 디비에서 가져온값 저장
			if (rs.next()) {
				// 결과 있으면 =>num에 대한 글있음
				dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_sub(rs.getString("notice_sub"));
				dto.setNotice_content(rs.getString("notice_content"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}//

	public NoticeDTO backNotice(int num) {

		NoticeDTO dto = null;
		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select * " + "from(select * " + "	 from notice "
					+ "     where notice_num between (select min(notice_num) from notice) and ? "
					+ "order by notice_num desc limit 2) a " + "order by a.notice_num limit 1;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// 5 결과 있으면 => BoardDTO 객체생성
			// =>set메서드호출=> 디비에서 가져온값 저장
			if (rs.next()) {
				// 결과 있으면 =>num에 대한 글있음
				dto = new NoticeDTO();
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setNotice_sub(rs.getString("notice_sub"));
				dto.setNotice_content(rs.getString("notice_content"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return dto;
	}//

//-------------------------------------------------------------------------------------------------------------------------------------	

	// update board set readcount=readcount+1 where num=?
	// 리턴할형없음 updateReadcount(int num) 메서드 정의
	public void updateReadcount(int num) {

		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "update notice set notice_readcount=notice_readcount+1 where notice_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}//
		// 리턴할형없음 updateBoard(BoardDTO 변수)메서드 정의

	public void updateNotice(NoticeDTO dto) {
		System.out.println("updateNotice -NoticeDTO image " + dto.getNotice_image());

		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
//					String sql="update notice set notice_sub=?,notice_content=? where notice_num=?";
			String sql = "update notice set notice_sub=?,notice_content=? ";
			if (dto.getNotice_image() != "") {
				sql += ", notice_image =? ";
			}
			sql += " where notice_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getNotice_sub());
			pstmt.setString(2, dto.getNotice_content());
			pstmt.setInt(3, dto.getNotice_num());
			if (dto.getNotice_image() != "") {
				pstmt.setString(3, dto.getNotice_image());
				pstmt.setInt(4, dto.getNotice_num());
			} else {
				pstmt.setInt(3, dto.getNotice_num());
			}
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}//

	// 리턴할형없음 deleteBoard(int num)메서드 정의
	public void deleteNotice(int num) {

		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "delete from notice where notice_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}//

	public int getNoticeCount(String searchField, String searchText) {
		int count = 0;
		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select count(*) from notice";
			if (searchText != null && !searchText.equals("")) {
				sql += " where " + searchField.trim() + " LIKE '%" + searchText.trim() + "%'";
			}
			pstmt = con.prepareStatement(sql);
			// 4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// 5 결과 접근 글개수 가져오기
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

	public int MaingetNoticeCount() {
		int count = 0;
		try {
			// 1,2 디비연결
			con = getConnection();
			// 3 sql
			String sql = "select count(*) from notice";
			pstmt = con.prepareStatement(sql);
			// 4 실행 => 결과 저장
			rs = pstmt.executeQuery();
			// 5 결과 접근 글개수 가져오기
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


}// class
