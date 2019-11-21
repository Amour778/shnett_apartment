package com.workplan.handler.controller;

import com.workplan.bean.apartment.ApartmentRoomBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.GetDateTimeNow;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ApartmentRoomController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentRoomController.class);
    List<ApartmentRoomBean> apartmentRoomList = new ArrayList<ApartmentRoomBean>();
    ApartmentRoomBean apartmentRoomBean = new ApartmentRoomBean();


    /**
     * 根据公寓ID获取该公寓下的所有房间信息
     *
     * @param apa_id
     * @param page
     * @param limit
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getApartmentRoomByApaId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getApartmentRoomByApaId(String apa_id, int page, int limit) throws Exception {
        apartmentRoomList = apartmentRoomDao.getApartmentBedByInputsToLayui(apa_id, page, limit);
        int count = apartmentRoomDao.getApartmentBedByInputsToLayui(apa_id);
        return ResultMessage.ListToLayuiTable(count, apartmentRoomList);
    }

    /**
     * 通过ID，修改房间信息
     *
     * @param roo_id    ID
     * @param col_name  列名
     * @param col_value 列值
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateColValueByRoomId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateColValueByRoomId(String roo_id, String col_name, String col_value) throws Exception {
        if (apartmentRoomDao.updatRoomColValueByRoomId(roo_id, col_name, col_value)) {
            return ResultMessage.MessageToJson(0, "更新成功");
        } else {
            return ResultMessage.MessageToJson(1, "更新失败");
        }
    }

    /**
     * 添加新的房间
     * @param apa_id 公寓ID
     * @param roo_name 房间名称
     * @param roo_floor 房间楼层
     * @param roo_people 几人间
     * @param roo_price 房间价格
     * @param roo_allocation 房间配置
     * @param roo_remarks 房间备注
     * @return
     */
    @RequestMapping(value = "/addNewRoomWithApaId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addNewRoomWithApaId(String apa_id,String roo_name,String roo_floor,String roo_people,String roo_price,String roo_allocation,String roo_remarks){
        try{
            String roo_id = "R" + GetDateTimeNow.getDateTimeRandomToID();
            if (apartmentRoomDao.addNewRoomWithApaId(apa_id,roo_id,roo_name,roo_floor,roo_people,roo_price,roo_allocation,roo_remarks)) {
                return ResultMessage.MessageToJson(0, "添加成功");
            } else {
                return ResultMessage.MessageToJson(1, "添加失败");
            }
        }catch (Exception e){
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "添加失败："+e.getMessage());
        }

    }

    /**
     * 删除房间
     *
     * @param roo_id
     * @return
     */
    @RequestMapping(value = "/deleteRoomByRoomId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteRoomByRoomId(String roo_id) {
        try {
            apartmentRoomDao.deleteRoomByRoomId(roo_id);
            return ResultMessage.MessageToJson(0, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "删除失败:" + e.getMessage());
        }
    }

    /**
     * 通过公寓ID获取该公寓下所有的房间
     * @param apa_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getAllApartmentRoomByApaId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllApartmentRoomByApaId(String apa_id) throws Exception {
        apartmentRoomList = apartmentRoomDao.queryAllApartmentRoomByApaIdToList(apa_id);
        if( apartmentRoomList.size()==0){
            return ResultMessage.MessageToJson(1,"该公寓下无房间数据");
        }
        String s = "";
        for (int v = 0; v < apartmentRoomList.size(); v++) {
            s += "{\"name\":\"" + apartmentRoomList.get(v).getRoo_name() + "\",\"value\":\"" + apartmentRoomList.get(v).getRoo_id() + "\",\"selected\":\"\",\"disabled\": false},";
        }
        return ResultMessage.ListToFormSelects(s);
    }



}
