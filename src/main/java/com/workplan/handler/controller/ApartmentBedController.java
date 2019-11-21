package com.workplan.handler.controller;

import com.workplan.bean.UserInfoBean;
import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.aparment.ApartmentBedHandler;
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
public class ApartmentBedController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApartmentBedController.class);
    List<ApartmentBedBean> apartmentBedList = new ArrayList<ApartmentBedBean>();
    ApartmentBedBean apartmentBedBean = new ApartmentBedBean();


    /**
     * 根据公寓ID获取该公寓下的所有房间信息
     *
     * @param roo_id
     * @param page
     * @param limit
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getApartmentBedByApaId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getApartmentBedByApaId(String roo_id, int page, int limit) throws Exception {
        if (roo_id.replaceAll(" ", "").equals("")) {
            roo_id = null;
        }
        apartmentBedList = apartmentBedDao.getApartmentBedByInputsToLayui(roo_id, page, limit);
        int count = apartmentBedDao.getApartmentBedByInputsToLayui(roo_id);
        return ResultMessage.ListToLayuiTable(count, apartmentBedList);
    }

    /**
     * 根据公寓ID获取该公寓下的所有房间信息
     *
     * @param roo_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/getApartmentBedByApaIdNoLimit", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getApartmentBedByApaId(String roo_id) throws Exception {
        if (roo_id.replaceAll(" ", "").equals("")) {
            roo_id = null;
        }
        apartmentBedList = apartmentBedDao.getApartmentBedByInputsToLayuiNoLimit(roo_id);
        return ResultMessage.ListToLayuiTable(apartmentBedList.size(), apartmentBedList);
    }

    /**
     * 添加新的床位
     *
     * @param bed_name
     * @param roo_id
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addNewBedByRoomId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addNewBedByRoomId(String bed_name, String roo_id) throws Exception {
        //生成新的床位ID
        String bed_id = "B" + GetDateTimeNow.getDateTimeRandomToID();
        if (apartmentBedDao.addNewBedByRoomId(roo_id, bed_id, bed_name)) {
            return ResultMessage.MessageToJson(0, "添加成功");
        } else {
            return ResultMessage.MessageToJson(1, "添加失败");
        }
    }

    /**
     * 删除床位
     *
     * @param bed_id
     * @return
     */
    @RequestMapping(value = "/deleteBedByBedId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteBedByBedId(String bed_id) {
        try {
            apartmentBedDao.deleteBedByBedId(bed_id);
            return ResultMessage.MessageToJson(0, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "删除失败:" + e.getMessage());
        }
    }

    /**
     * 根据床位ID修改床位所在员工
     *
     * @param bed_people_new 新的员工号
     * @param bed_people_old 旧的员工号
     * @param bed_id         床位号
     * @return
     */
    @RequestMapping(value = "/updateBedPeopleByRoomId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String updateBedPeopleByRoomId(String bed_people_new, String bed_people_old, String bed_id) {
        try {
            if (bed_people_new.replaceAll(" ", "").equals("")) {
                bed_people_new = null;
            }
            if (bed_people_old.replaceAll(" ", "").equals("")) {
                bed_people_old = null;
            }
            //先判断用户工号是否存在
            //其中因为bed_people_old(旧的员工号)因为存在可能员工离职数据删除的情况，所以允许不存在
            //故此处只判断新的员工工号是否存在
            if (bed_people_new != null) {
                List<UserInfoBean> userInfoBeanList = userinfoDao.queryForInfoList(bed_people_new);
                if (userInfoBeanList.size() == 0) {
                    return ResultMessage.MessageToJson(1, "更新的数据未同步:用户输入的工号不存在");
                }
            }
            apartmentBedDao.updateBedPeopleByRoomId(bed_people_new, bed_people_old, bed_id);
            return ResultMessage.MessageToJson(0, "更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "更新失败:" + e.getMessage());
        }
    }


    /**
     * 通过房间ID获取该公寓下所有的床位
     * @param roo_id
     * @return
     * @throws Exception
     */
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
                s += "{\"name\": \"" + apartmentBedList.get(v).getBed_name() + "\",\"value\": \"" + apartmentBedList.get(v).getBed_id() + "\",\"disabled\": true},";
            }else {
                s += "{\"name\": \"" + apartmentBedList.get(v).getBed_name() + "\",\"value\": \"" + apartmentBedList.get(v).getBed_id() + "\",\"disabled\": false},";
            }
        }
        if( isPeopleFull==apartmentBedList.size()){
            return ResultMessage.MessageToJson(1,"该房间下无空床位");
        }
        return ResultMessage.ListToFormSelects(s);
    }

    /**
     * 提交入住信息
     * @param bed_id
     * @param user_id
     * @param apply_id
     * @return
     */
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

}
