package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.NetworkBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/wx")
public class ApartmentInfoHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentInfoHandler.class);
    List<ApartmentInfoBean> apartmentInfoList = new ArrayList<ApartmentInfoBean>();
    ApartmentInfoBean apartmentInfoBean = new ApartmentInfoBean();

    /**
     * 获取所有公寓
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/getAllApartmentInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllApartmentInfo() throws Exception {
        apartmentInfoList = apartmentInfoDao.queryAllApartmentInfoForList();
        return ResultMessage.ListToJson(0,apartmentInfoList);
    }

    /**
     * 获取所有公寓
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/queryAllApartmentInfoForList", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryAllApartmentInfoForList() throws Exception {
        apartmentInfoList = apartmentInfoDao.queryAllApartmentInfoForList();
        String mess="";
        for (int a= 0;a<apartmentInfoList.size();a++){
            mess+="{\"apa_name\":\""+apartmentInfoList.get(a).getApa_name()+"\",\"apa_id\":\""+apartmentInfoList.get(a).getApa_id()+"\",\"isShow\": true},";
        }
        return ResultMessage.ListToFormSelects(mess);
    }


    /**
     * 获取用户的入住信息
     * @param user_id
     * @return
     */
    @Authorization
    @RequestMapping(value = "/getUserCheckInInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getUserCheckInInfo(String user_id) {
        try{
            return ResultMessage.ListToJson(0,apartmentInfoDao.getUserCheckInInfo(user_id));
        }catch (Exception e){
            e.printStackTrace();
            return ResultMessage.MessageToJson(1,"获取入住信息异常:"+e.getMessage());
        }
    }



}