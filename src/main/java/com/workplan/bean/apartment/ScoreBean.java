package com.workplan.bean.apartment;

public class ScoreBean  extends ApartmentInfoBean {
    //公寓入住申请表
    private int sid;

    //公寓ID
    private String apa_id;

    //评价人工号
    private String user_id;

    //分数
    private int score;

    //数据添加日期
    private String create_date;

    //备注(非必填)
    private String remark;

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public String getApa_id() {
        return apa_id;
    }

    public void setApa_id(String apa_id) {
        this.apa_id = apa_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
