package com.workplan.bean.apartment;

public class ApartmentInfoBean  extends ApartmentRoomBean  {
    //公寓信息
    private  int id;

    //公寓唯一ID
    private  String apa_id;

    //公寓名称
    private  String apa_name;

    //公寓地址：省
    private  String apa_province;

    //公寓地址：市
    private  String apa_city;

    //公寓地址：区
    private  String apa_area;

    //具体地址
    private  String apa_address;

    //公寓联系人
    private  String apa_user;

    //公寓联系方式
    private  String apa_tel;

    //公寓所在地址经纬度
    private  String apa_local;

    //备注
    private  String apa_remarks;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getApa_id() {
        return apa_id;
    }

    public void setApa_id(String apa_id) {
        this.apa_id = apa_id;
    }

    public String getApa_name() {
        return apa_name;
    }

    public void setApa_name(String apa_name) {
        this.apa_name = apa_name;
    }

    public String getApa_province() {
        return apa_province;
    }

    public void setApa_province(String apa_province) {
        this.apa_province = apa_province;
    }

    public String getApa_city() {
        return apa_city;
    }

    public void setApa_city(String apa_city) {
        this.apa_city = apa_city;
    }

    public String getApa_area() {
        return apa_area;
    }

    public void setApa_area(String apa_area) {
        this.apa_area = apa_area;
    }

    public String getApa_address() {
        return apa_address;
    }

    public void setApa_address(String apa_address) {
        this.apa_address = apa_address;
    }

    public String getApa_user() {
        return apa_user;
    }

    public void setApa_user(String apa_user) {
        this.apa_user = apa_user;
    }

    public String getApa_tel() {
        return apa_tel;
    }

    public void setApa_tel(String apa_tel) {
        this.apa_tel = apa_tel;
    }

    public String getApa_local() {
        return apa_local;
    }

    public void setApa_local(String apa_local) {
        this.apa_local = apa_local;
    }

    public String getApa_remarks() {
        return apa_remarks;
    }

    public void setApa_remarks(String apa_remarks) {
        this.apa_remarks = apa_remarks;
    }
}
