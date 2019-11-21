package com.workplan.bean;

public class MenuBean {

	private long ID;

	// 是否是主菜单：0不是，1是
	private long isfather;

	// 菜单ID
	private String title_id;

	// 菜单名称
	private String title;

	// 图标
	private String icon;

	// 路径
	private String href;

	// 是否默认展开
	private String spread = "0";

	// 子菜单
	private String children = "";

	public long getID() {
		return this.ID;
	};

	public void setID(long ID) {
		this.ID = ID;
	}

	public long getIsfather() {
		return this.isfather;
	};

	public void setIsfather(long isfather) {
		this.isfather = isfather;
	}

	public String getTitleId() {
		return this.title_id;
	};

	public void setTitleId(String title_id) {
		this.title_id = title_id;
	}

	public String getTitle() {
		return this.title;
	};

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIcon() {
		return this.icon;
	};

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getHref() {
		return this.href;
	};

	public void setHref(String href) {
		this.href = href;
	}

	public String getSpread() {
		return this.spread;
	};

	public void setSpread(String spread) {
		this.spread = spread;
	}

	public String getChildren() {
		return this.children;
	};

	public void setChildren(String children) {
		this.children = children;
	}
}
