package com.workplan.bean;


import com.workplan.tools.StringSubstringUtil;

public class UserInfoBean {
    //ID
    private  int pid;

    //用户工号
    private  String user_id;

    //用户密码
    private  String user_password;

    //用户姓名
    private  String user_name;

    //身份证号
    private  String user_cardid;

    //手机号码
    private  String user_tel;

    //用户角色
    private  String user_role;

    //微信OPENID
    private  String user_wechat_apartment;

    //所属大区
    private  String user_main;

    //所属网点
    private  String user_point;

    //数据添加日期
    private String create_date;

    //账号状态:0禁用，1启用
    private  int sta ;

    //用户性别：0女性，1男性
    private  int user_sex ;

    //用户积分
    private  int user_integral ;

    //员工床位ID
    private  String user_bed;

    //入职日期
    private  String date_entry;

    //用工类型：0社招，1实习生，2非新工
    private  int user_type ;

    //用户邮箱
    private  String user_mail ;

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_password() {
        return user_password;
    }

    public void setUser_password(String user_password) {
        this.user_password = user_password;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_cardid() {
        return user_cardid;
    }

    public void setUser_cardid(String user_cardid) {
        this.user_cardid = user_cardid;
    }

    public String getUser_tel() {
        return user_tel;
    }

    public void setUser_tel(String user_tel) {
        this.user_tel = user_tel;
    }

    public String getUser_role() {
        return user_role;
    }

    public void setUser_role(String user_role) {
        this.user_role = user_role;
    }

    public String getUser_wechat_apartment() {
        return user_wechat_apartment;
    }

    public void setUser_wechat_apartment(String user_wechat_apartment) {
        this.user_wechat_apartment = user_wechat_apartment;
    }

    public String getUser_main() {
        return user_main;
    }

    public void setUser_main(String user_main) {
        this.user_main = user_main;
    }

    public String getUser_point() {
        return user_point;
    }

    public void setUser_point(String user_point) {
        this.user_point = user_point;
    }

    public String getCreate_date() {
        return create_date;
    }

    public void setCreate_date(String create_date) {
        if(create_date.equals("")||create_date==null){
            this.create_date = create_date;
        }else{
            this.create_date = create_date.substring(0,19);
        }

    }

    public int getSta() {
        return sta;
    }

    public void setSta(int sta) {
        this.sta = sta;
    }

    public int getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(int user_sex) {
        this.user_sex = user_sex;
    }

    public int getUser_integral() {
        return user_integral;
    }

    public void setUser_integral(int user_integral) {
        this.user_integral = user_integral;
    }

    public String getUser_bed() {
        return user_bed;
    }

    public void setUser_bed(String user_bed) {
        this.user_bed = user_bed;
    }

    public String getDate_entry() {
        return date_entry;
    }

    public void setDate_entry(String date_entry) {
        this.date_entry = date_entry;
    }

    public int getUser_type() {
        return user_type;
    }

    public void setUser_type(int user_type) {
        this.user_type = user_type;
    }

    public String getUser_mail() {
        return user_mail;
    }

    public void setUser_mail(String user_mail) {
        this.user_mail = user_mail;
    }
}

