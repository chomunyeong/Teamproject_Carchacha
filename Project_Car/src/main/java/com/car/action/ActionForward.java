package com.car.action;

public class ActionForward {

	private String path;	// ?��?��경로
	private boolean isRedirect;	// ?��?��방식
	
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
