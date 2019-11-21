package com.workplan.bean;

public class RoleBean {

	//角色ID
	private String role_id;
	//角色名称
	private String role_nickname;
	//角色昵称
	private String role_name;
	//角色所拥有的权限
	private String role_per;
	
	public String getRole_id() {
		return role_id;
	}
	public void setRole_id(String roleId) {
		role_id = roleId;
	}
	
	public String getRole_nickname() {
		return role_nickname;
	}
	public void setRole_nickname(String roleNickname) {
		role_nickname = roleNickname;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String roleName) {
		role_name = roleName;
	}
	public String getRole_per() {
		return role_per;
	}
	public void setRole_per(String rolePer) {
		role_per = rolePer;
	}
	

}
