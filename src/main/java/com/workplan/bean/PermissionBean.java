package com.workplan.bean;

public class PermissionBean {

	//菜单ID,如果菜单ID为2位则表示为父菜单，4位则表示为子菜单（界面），6位为界面按钮
	//其中前2位是皆为父菜单ID，前4位是皆为子菜单（界面）ID
	private String menuId;
	//菜单名称
	private String name;
	//路径：'javascript:;'或者'/user'
	private String url;
	//实际路径
	private String path;
	//图标
	private String icon;
	
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	
	
	
}
