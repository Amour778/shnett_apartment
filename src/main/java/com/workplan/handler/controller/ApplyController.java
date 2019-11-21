package com.workplan.handler.controller;

import com.workplan.bean.UserInfoBean;
import com.workplan.bean.apartment.ApartmentApplyBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.aparment.SendWxTemplateMessageHandler;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ApplyController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApplyController.class);
    ApartmentApplyBean apartmentApplyBean = new ApartmentApplyBean();
    List<ApartmentApplyBean> apartmentApplyList = new ArrayList<ApartmentApplyBean>();
    SendWxTemplateMessageHandler sendWxTemplateMessageHandler = new SendWxTemplateMessageHandler();


    /**
     * 通过以下条件获取符合的数据列表
     * @param user_id
     * @param sta
     * @param apply_type
     * @param create_date
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/queryApplyInfo")
    @ResponseBody
    public String queryApplyInfo(String user_id, int sta,int apply_type,int is_check,String create_date ,int page,int limit) {
        String StartDate=null, EndDate=null;
        if(create_date!=null && create_date!=""){
            StartDate=create_date.substring(0,10);
            EndDate=create_date.substring(13,23);
        }
        if(user_id.equals("")){
            user_id=null;
        }
        try {
            apartmentApplyList = apartmentApplyDao.queryApplyInfoToLayuiList(user_id, sta, apply_type, is_check,StartDate, EndDate, page, limit);
            int count = apartmentApplyDao.queryApplyInfoToLayuiList(user_id, sta, apply_type, is_check,StartDate, EndDate);
            return ResultMessage.ListToLayuiTable(count, apartmentApplyList);
        } catch (Exception e) {
             logger.info(e.getMessage());
            return ResultMessage.ListToLayuiTableWithErr("获取数据异常");
        }
    }

    /**
     * 通过申请ID获取数据
     * @param id
     * @return
     */
    @RequestMapping(value = "/queryApplyInfoById")
    @ResponseBody
    public String queryApplyInfoById(String id,String apply_type) {
        try {
            if(apply_type.equals("0")){//入住申请
                apartmentApplyList =apartmentApplyDao.queryCheckInApplyInfoById(id);
            }else if(apply_type.equals("1")){
                apartmentApplyList =apartmentApplyDao.queryCheckOutApplyInfoById(id);
            }else{
                return ResultMessage.MessageToJson(1, "获取申请类型数据异常");
            }
            return ResultMessage.ListToJson(0,apartmentApplyList);
        } catch (Exception e) {
            e.printStackTrace();
             logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }

    /**
     * 审批入住申请
     * @param id
     * @param sta
     * @param apply_remarks
     * @param admin_arrange
     * @param date_check_in
     * @param date_move_out
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/applicationForExaminationAndApprovalByApplyIdToCheckIn")
    @ResponseBody
    public ResultMessage applicationForExaminationAndApprovalByApplyId(String id, String sta, String apply_remarks, String admin_arrange, String date_check_in, String date_move_out) throws Exception {
        if (sta.equals("1")) {
            apply_remarks = null;
        } else if (sta.equals("2")) {
            admin_arrange = null;
        }
        if (apartmentApplyDao.updateApplyStaById(id, sta, apply_remarks, admin_arrange, date_check_in, date_move_out)) {
            try {
                String apply_sta = null;
                if (sta.equals("1")) {
                    apply_sta = "同意";
                } else {
                    apply_sta = "驳回";
                }
                String user_id = apartmentApplyDao.queryCheckInApplyInfoById(id).get(0).getUser_id();
                List<UserInfoBean> userList = userinfoDao.queryForInfoList(user_id);
                String user_openid = userList.get(0).getUser_wechat_apartment();
                String user_name = userList.get(0).getUser_name();
                logger.info("审批入住申请，发送订阅消息");
                logger.info("user_id: " + user_id +",user_name: " + user_name + ",apply_type：入住申请,  apply_sta： " + apply_sta + ", user_openid： " + user_openid);
                String returnMessage = sendWxTemplateMessageHandler.sendApplyCheckSubscribeMessage(user_name, "入住申请", apply_sta, user_openid);
                logger.info("发送回执:" + returnMessage);
            } catch (Exception e) {
                logger.info("审批入住申请:申请流程ID" + id + "。发送订阅消息失败：" + e.getMessage());
                e.printStackTrace();
            }
            return new ResultMessage(0, "审批成功");
        } else {
            return new ResultMessage(1, "审批失败");
        }
    }

    /**
     * 审批退租申请
     * @param id
     * @param user_id
     * @param bed_id
     * @param sta
     * @param apply_remarks
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/applicationForExaminationAndApprovalByApplyIdToCheckout")
    @ResponseBody
    public ResultMessage applicationForExaminationAndApprovalByApplyId(String id, String user_id, String bed_id, String sta, String apply_remarks) throws Exception {
        try {
            if (sta.equals("1")) {
                apply_remarks = null;
            }
            apartmentApplyDao.updateApplyStaById(id, user_id, bed_id, sta, apply_remarks);
            try {
                String apply_sta = null;
                if (sta.equals("1")) {
                    apply_sta = "同意";
                } else {
                    apply_sta = "驳回";
                }
                List<UserInfoBean> userList = userinfoDao.queryForInfoList(user_id);
                String user_openid = userList.get(0).getUser_wechat_apartment();
                String user_name = userList.get(0).getUser_name();
                logger.info("审批退租申请，发送订阅消息");
                logger.info("user_id: " + user_id + ",user_name: " + user_name + ",apply_type：退租申请,  apply_sta： " + apply_sta + ", user_openid： " + user_openid);
                String returnMessage = sendWxTemplateMessageHandler.sendApplyCheckSubscribeMessage(user_name, "退租申请", apply_sta, user_openid);
                logger.info("发送回执:" + returnMessage);
            } catch (Exception e) {
                logger.info("审批退租申请:申请流程ID" + id + "。发送订阅消息失败：" + e.getMessage());
                e.printStackTrace();
            }
            return new ResultMessage(0, "审批成功");
        } catch (Exception e) {
e.printStackTrace();
            logger.info(e.getMessage());
            return new ResultMessage(1, "审批失败");
        }
    }

}
