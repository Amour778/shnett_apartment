package com.workplan.bean.apartment;

import com.workplan.bean.UserInfoBean;

public class ApartmentApplyBean extends UserInfoBean {
    //公寓入住申请表
    private int id;

    //用户工号
    private String user_id;
    //用户工号
    private String user_name;

    //员工意向宿舍ID
    private String user_intention;

    //管理员安排宿舍ID
    private String admin_arrange;

    //入住事由
    private String in_reason;

    //申请类型：0新住，1续住
    private int check_in_type;

    //申请类型：0入住，1退租
    private int apply_type;

  /*  //提交申请时间
    private String update_time;

    //审批时间
    private String apply_time;*/

    //入住日期
    private String date_check_in;

    //搬出日期
    private String date_move_out;

    //公寓ID
    private String apa_id;

    //房间ID
    private String roo_id;

    //床位ID
    private String bed_id;

    //公寓名称
    private String apa_name;

    //房间名称
    private String roo_name;

    //床位名称
    private String bed_name;

    //退租事由
    private String out_reason;

    //审批状态:0待审批，1通过，2驳回
    private int sta;

    //审批备注
    private String apply_remarks;

    //数据添加日期
    private String create_date;

    //入住状态：0未入住，1已入住
    private int is_check;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_intention() {
        return user_intention;
    }

    public void setUser_intention(String user_intention) {
        this.user_intention = user_intention;
    }

    public String getAdmin_arrange() {
        return admin_arrange;
    }

    public void setAdmin_arrange(String admin_arrange) {
        this.admin_arrange = admin_arrange;
    }

    public String getIn_reason() {
        return in_reason;
    }

    public void setIn_reason(String in_reason) {
        this.in_reason = in_reason;
    }

    public int getCheck_in_type() {
        return check_in_type;
    }

    public void setCheck_in_type(int check_in_type) {
        this.check_in_type = check_in_type;
    }

    public int getApply_type() {
        return apply_type;
    }

    public void setApply_type(int apply_type) {
        this.apply_type = apply_type;
    }

    public String getDate_check_in() {
        return date_check_in;
    }

    public void setDate_check_in(String date_check_in) {
        this.date_check_in = date_check_in;
    }

    public String getDate_move_out() {
        return date_move_out;
    }

    public void setDate_move_out(String date_move_out) {
        this.date_move_out = date_move_out;
    }

    public String getApa_id() {
        return apa_id;
    }

    public void setApa_id(String apa_id) {
        this.apa_id = apa_id;
    }

    public String getRoo_id() {
        return roo_id;
    }

    public void setRoo_id(String roo_id) {
        this.roo_id = roo_id;
    }

    public String getBed_id() {
        return bed_id;
    }

    public void setBed_id(String bed_id) {
        this.bed_id = bed_id;
    }

    public String getOut_reason() {
        return out_reason;
    }

    public void setOut_reason(String out_reason) {
        this.out_reason = out_reason;
    }

    public int getSta() {
        return sta;
    }

    public void setSta(int sta) {
        this.sta = sta;
    }

    public String getApply_remarks() {
        return apply_remarks;
    }

    public void setApply_remarks(String apply_remarks) {
        this.apply_remarks = apply_remarks;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public String getApa_name() {
        return apa_name;
    }

    public void setApa_name(String apa_name) {
        this.apa_name = apa_name;
    }

    public String getRoo_name() {
        return roo_name;
    }

    public void setRoo_name(String roo_name) {
        this.roo_name = roo_name;
    }

    public String getBed_name() {
        return bed_name;
    }

    public void setBed_name(String bed_name) {
        this.bed_name = bed_name;
    }

    public int getIs_check() {
        return is_check;
    }

    public void setIs_check(int is_check) {
        this.is_check = is_check;
    }
}
