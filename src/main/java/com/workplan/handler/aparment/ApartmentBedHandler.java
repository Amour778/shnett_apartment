package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/wx")
public class ApartmentBedHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentBedHandler.class);
    List<ApartmentBedBean> apartmentBedList = new ArrayList<ApartmentBedBean>();
    ApartmentBedBean apartmentBedBean = new ApartmentBedBean();


    /**
     * 通过房间ID获取该公寓下所有的床位
     * @param roo_id
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/getAllApartmentBedByRoomId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllApartmentBedByRoomId(String roo_id) throws Exception {
        apartmentBedList = apartmentBedDao.queryAllApartmentBedByApaIdToList(roo_id);
        if( apartmentBedList.size()==0){
            return ResultMessage.MessageToJson(1,"该房间下无床位数据");
        }
        String s = "";
        int isPeopleFull=0;
        for (int v = 0; v < apartmentBedList.size(); v++) {
            if(apartmentBedList.get(v).getBed_people()!=null && !apartmentBedList.get(v).getBed_people().equals("")){
                isPeopleFull++;
                s += "{\"value\": \"" + apartmentBedList.get(v).getBed_name() + "\",\"id\": \"" + apartmentBedList.get(v).getBed_id() + "\",\"disabled\": true},";
            }else {
                s += "{\"value\": \"" + apartmentBedList.get(v).getBed_name() + "\",\"id\": \"" + apartmentBedList.get(v).getBed_id() + "\",\"disabled\": false},";
            }
        }
        if( isPeopleFull==apartmentBedList.size()){
            return ResultMessage.MessageToJson(1,"该房间下无空床位");
        }
        return ResultMessage.ListToFormSelects(s);
    }


    /**
     * 提交入住
     * @param bed_id  入住的床位ID
     * @param user_id 入住人工号
     * @param apply_id 更新审批申请的入住状态
     * @return
     */
    @Authorization
    @RequestMapping(value = "/checkInWithUserIdAndBedId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String checkInWithUserIdAndBedId(String bed_id,String user_id,String apply_id) {

        try{
            apartmentBedDao.checkInWithUserIdAndBedId(bed_id,user_id,apply_id);
            return ResultMessage.MessageToJson(0,"提交入住信息成功");
        }catch (Exception e){
            e.printStackTrace();
            return ResultMessage.MessageToJson(1,"提交入住信息异常:"+e.getMessage());
        }
    }

    /**
     * 获取床位入住数据
     * @return
     */
    @Authorization
    @RequestMapping(value = "/getBedCheckInCounts", method = RequestMethod.POST)
    @ResponseBody
    public String getBedCheckInCounts() {
        return "{\"series\":[{\"name\":\"已入住\",\"data\":"+apartmentBedDao.getBedCheckInCounts(false)+"},{\"name\":\"未入住\",\"data\":"+apartmentBedDao.getBedCheckInCounts(true)+"}]}";
    }




}