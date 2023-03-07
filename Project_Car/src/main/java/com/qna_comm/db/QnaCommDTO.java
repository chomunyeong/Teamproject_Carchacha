package com.qna_comm.db;

public class QnaCommDTO {
	private int qna_num;
	private int comm_num;
	private String comm_content;
	private String comm_date;
	private String user_id;
	private int comm_index;
	
	public int getQna_num() {
		return qna_num;
	}
	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
	}
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	public String getComm_date() {
		return comm_date;
	}
	public void setComm_date(String comm_date) {
		this.comm_date = comm_date;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getComm_index() {
		return comm_index;
	}
	public void setComm_index(int comm_index) {
		this.comm_index = comm_index;
	}
	
}
