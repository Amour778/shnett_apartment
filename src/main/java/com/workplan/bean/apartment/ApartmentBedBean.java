package com.workplan.bean.apartment;

import com.workplan.bean.UserInfoBean;

public class ApartmentBedBean extends UserInfoBean {
    //公寓床位
    private  int id;

    //房间ID
    private  String roo_id;

    //床位唯一ID
    private  String bed_id;

    //床位名称：对应实际的几号床
    private  String bed_name;

    //入住人工号
    private  String bed_people;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getBed_name() {
        return bed_name;
    }

    public void setBed_name(String bed_name) {
        this.bed_name = bed_name;
    }

    public String getBed_people() {
        return bed_people;
    }

    public void setBed_people(String bed_people) {
        this.bed_people = bed_people;
    }
}
