package com.workplan.bean.apartment;

public class ApartmentRoomBean extends ApartmentBedBean {
    //公寓房间
    private  int id;

    //公寓ID
    private  String apa_id;

    //房间唯一ID
    private  String roo_id;

    //房间名称
    private  String roo_name;

    //楼层
    private  String roo_floor;

    //几人间
    private  String roo_people;

    //房间备注
    private  String roo_remarks;

    //房间价格
    private  String roo_price;

    //房间配置
    private  String roo_allocation;

    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    public String getApa_id() {
        return apa_id;
    }

    public void setApa_id(String apa_id) {
        this.apa_id = apa_id;
    }

    @Override
    public String getRoo_id() {
        return roo_id;
    }

    @Override
    public void setRoo_id(String roo_id) {
        this.roo_id = roo_id;
    }

    public String getRoo_name() {
        return roo_name;
    }

    public void setRoo_name(String roo_name) {
        this.roo_name = roo_name;
    }

    public String getRoo_floor() {
        return roo_floor;
    }

    public void setRoo_floor(String roo_floor) {
        this.roo_floor = roo_floor;
    }

    public String getRoo_people() {
        return roo_people;
    }

    public void setRoo_people(String roo_people) {
        this.roo_people = roo_people;
    }

    public String getRoo_remarks() {
        return roo_remarks;
    }

    public void setRoo_remarks(String roo_remarks) {
        this.roo_remarks = roo_remarks;
    }

    public String getRoo_price() {
        return roo_price;
    }

    public void setRoo_price(String roo_price) {
        this.roo_price = roo_price;
    }

    public String getRoo_allocation() {
        return roo_allocation;
    }

    public void setRoo_allocation(String roo_allocation) {
        this.roo_allocation = roo_allocation;
    }
}
