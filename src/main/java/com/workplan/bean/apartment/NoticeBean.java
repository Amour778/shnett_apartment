package com.workplan.bean.apartment;

public class NoticeBean {
    //ID
    private int nid;

    //数据添加日期
    private String create_date;

    //通知内容
    private String info;

    public int getNid() {
        return nid;
    }

    public void setNid(int nid) {
        this.nid = nid;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
