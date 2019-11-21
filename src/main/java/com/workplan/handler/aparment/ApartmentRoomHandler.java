package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.ApartmentRoomBean;
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
public class ApartmentRoomHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentRoomHandler.class);
    List<ApartmentRoomBean> apartmentRoomList = new ArrayList<ApartmentRoomBean>();
    ApartmentRoomBean apartmentRoomBean = new ApartmentRoomBean();

    /**
     * 通过公寓ID获取该公寓下所有的房间
     * @param apa_id
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/getAllApartmentRoomByApaId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllApartmentRoomByApaId(String apa_id) throws Exception {
        apartmentRoomList = apartmentRoomDao.queryAllApartmentRoomByApaIdToList(apa_id);
        if( apartmentRoomList.size()==0){
            return ResultMessage.MessageToJson(1,"该公寓下无房间数据");
        }
        String s = "";
        for (int v = 0; v < apartmentRoomList.size(); v++) {
            s += "{\"value\":\"" + apartmentRoomList.get(v).getRoo_name() + "\",\"id\":\"" + apartmentRoomList.get(v).getRoo_id() + "\",\"disabled\": false},";
        }
        return ResultMessage.ListToFormSelects(s);
    }
}