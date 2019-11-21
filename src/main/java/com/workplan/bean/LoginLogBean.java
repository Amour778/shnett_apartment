package com.workplan.bean;

public class LoginLogBean {

	// 用户工号
	private String user_id;

	// IP
	private String ip_address;
	
	// 登陆时间
	private String time;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String userId) {
		user_id = userId;
	}

	public String getIp_address() {
		return ip_address;
	}

	public void setIp_address(String ipAddress) {
		ip_address = ipAddress;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	
}
