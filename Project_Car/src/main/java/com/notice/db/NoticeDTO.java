package com.notice.db;

public class NoticeDTO {
	//멤버변수
	private int notice_num;
	private String user_id;
	private String notice_sub;
	private String notice_content;
	private int notice_readcount;
	private String notice_date;
	private String notice_image;
	private String notice_rownum;
	
	

	public String getNotice_rownum() {
		return notice_rownum;
	}
	public void setNotice_rownum(String notice_rownum) {
		this.notice_rownum = notice_rownum;
	}
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}

	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getNotice_sub() {
		return notice_sub;
	}
	public void setNotice_sub(String notice_sub) {
		this.notice_sub = notice_sub;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public int getNotice_readcount() {
		return notice_readcount;
	}
	public void setNotice_readcount(int notice_readcount) {
		this.notice_readcount = notice_readcount;
	}
	public String getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(String notice_date) {
		this.notice_date = notice_date;
	}
	public String getNotice_image() {
		return notice_image;
	}
	public void setNotice_image(String notice_image) {
		this.notice_image = notice_image;
	}
	


	
}
