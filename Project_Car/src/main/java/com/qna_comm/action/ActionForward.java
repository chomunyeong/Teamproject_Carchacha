package com.qna_comm.action;

public class ActionForward {

	private String path;	// 이동경로
	private boolean isRedirect;	// 이동방식
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}
	
}
