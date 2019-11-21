package com.workplan.handler.aparment;

import com.workplan.bean.UserInfoBean;
import com.workplan.bean.apartment.ApartmentApplyBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.MailHandler;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/wx")
public class ApplyHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(ApplyHandler.class);
    ApartmentApplyBean apartmentApplyBean = new ApartmentApplyBean();
    List<ApartmentApplyBean> apartmentApplyList = new ArrayList<ApartmentApplyBean>();
    SendWxTemplateMessageHandler sendWxTemplateMessageHandler = new SendWxTemplateMessageHandler();
    MailHandler mailHandler = new MailHandler();


    /**
     * 添加入住申请
     *
     * @param user_id        用户工号
     * @param user_intention 公寓意向
     * @param check_in_type  申请类型：0新住，1续住
     * @param in_reason      入住原因
     * @param date_check_in  入住日期
     * @param date_move_out  结束日期
     * @param apply_type     申请类型：0入住，1搬出
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/addApplyInfoToIn")
    @ResponseBody
    public ResultMessage addApplyInfoToIn(String user_id, String user_intention, String in_reason, String check_in_type, String apply_type, String date_check_in, String date_move_out) throws Exception {
        if (apartmentApplyDao.addApplyInfoToIn(user_id, user_intention, in_reason, check_in_type, apply_type, date_check_in, date_move_out) == 1) {
            /*因微信小程序订阅服务未开放长期订阅到办公类型的小程序，故暂时取消此通知，改为邮箱通知
            try {
                UserInfoBean userInfoBean = userinfoDao.queryForInfoBean(user_id);
                String user_open_id = userinfoDao.queryApartmentOpentIdByUserRoleIsOneZeroZeroOne().get(0).getUser_wechat_apartment();
                logger.info("apply_type: " + "入住申请,user_id: " + user_id + ",user_name: " + userInfoBean.getUser_name() + ",user_tel: " + userInfoBean.getUser_tel() + ",user_point: " + userInfoBean.getUser_point() + ",date_check_in: " + date_check_in + ",date_move_out: " + date_move_out + ",reason: " + in_reason + ",user_openid: " + user_open_id);
                logger.info("提交入住申请，发送订阅消息");
                String returnMessage = sendWxTemplateMessageHandler.sendNewApplySubscribeMessage(user_id, "入住申请", date_check_in, date_move_out, user_open_id);
               //因微信小程序通知模板只能对对应form_id生成者的openid发送消息，故取消此方法 sendWxTemplateMessageHandler.sendNewApply("入住申请", user_id, userInfoBean.getUser_name(), userInfoBean.getUser_tel(), userInfoBean.getUser_point(), date_check_in, date_move_out, in_reason, user_open_id, formId);
                logger.info("发送回执:" + returnMessage);
            } catch (Exception e) {
                logger.info("提交入住申请:申请人" + user_id + "。发送订阅消息失败：" + e.getMessage());
                e.printStackTrace();
            }
            */
            try {
                Map<String, String> MESSAGE = new HashMap<String, String>();
                MESSAGE= mailHandler.sendInMail(user_id, user_intention, in_reason, check_in_type, apply_type, date_check_in, date_move_out);
                logger.info("提交入住申请:" + MESSAGE);
            } catch (Exception e) {
                logger.info("提交入住申请:申请人" + user_id + "。发送邮件失败：" + e.getMessage());
                e.printStackTrace();
            }
            return new ResultMessage(0, "申请成功");
        } else {
            return new ResultMessage(1, "申请失败");
        }
    }

    /**
     * 添加退租宿舍申请
     *
     * @param user_id       用户工号
     * @param apa_id        公寓ID
     * @param roo_id        房间ID
     * @param bed_id        床位ID
     * @param out_reason    退租理由
     * @param date_move_out 退租日期
     * @param apply_type    申请类型：1搬出
     * @return
     */
    @Authorization
    @RequestMapping(value = "/addApplyInfoToOut")
    @ResponseBody
    public ResultMessage addApplyInfoToOut(String user_id, String apa_id, String roo_id, String bed_id, String out_reason, String date_move_out, String apply_type
    ) throws Exception {
        if (apartmentApplyDao.addApplyInfoToOut(user_id, apa_id, roo_id, bed_id, out_reason, date_move_out, apply_type) == 1) {
            /*因微信小程序订阅服务未开放长期订阅到办公类型的小程序，故暂时取消此通知，改为邮箱通知
            try {
                UserInfoBean userInfoBean = userinfoDao.queryForInfoBean(user_id);
                String user_open_id = userinfoDao.queryApartmentOpentIdByUserRoleIsOneZeroZeroOne().get(0).getUser_wechat_apartment();
                logger.info("apply_type: " + "退租申请,user_id: " + user_id + ",user_name: " + userInfoBean.getUser_name() + ",user_tel: " + userInfoBean.getUser_tel() + ",user_point: " + userInfoBean.getUser_point() + ",date_check_in: - ,date_move_out: " + date_move_out + ",reason: " + out_reason + ",user_openid: " + user_open_id);
                logger.info("提交退租申请，发送订阅消息");
                String returnMessage = sendWxTemplateMessageHandler.sendNewApplySubscribeMessage(user_id, "退租申请", "", date_move_out, user_open_id);
                logger.info("发送回执:" + returnMessage);

                sendWxTemplateMessageHandler.sendApplyCheckSubscribeMessage(user_id,"入住申请",apply_sta,user_openid);

            } catch (Exception e) {
                logger.info("提交退租申请:申请人" + user_id + "。发送订阅消息失败：" + e.getMessage());
                e.printStackTrace();
            }
            */
            try {
                Map<String, String> MESSAGE = new HashMap<String, String>();
                MESSAGE = mailHandler.sendOutMail(user_id, out_reason, date_move_out, apply_type);
                logger.info("提交退租申请:" + MESSAGE);
            } catch (Exception e) {
                logger.info("提交退租申请:申请人" + user_id + "。发送邮件失败：" + e.getMessage());
                e.printStackTrace();
            }
            return new ResultMessage(0, "申请成功");
        } else {
            return new ResultMessage(1, "申请失败");
        }
    }

    /**
     * 审批申请:入住
     *
     * @param id            流程ID
     * @param sta           审批结果
     * @param apply_remarks 审批备注
     * @param admin_arrange 管理员分配的宿舍ID
     * @param date_check_in (管理员要求的)入住日期
     * @param date_move_out (管理员要求的)退租日期
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/applicationForExaminationAndApprovalByApplyIdToCheckIn")
    @ResponseBody
    public ResultMessage applicationForExaminationAndApprovalByApplyId(String id, String sta, String apply_remarks, String admin_arrange, String date_check_in, String date_move_out
    ) throws Exception {
        if (sta.equals("1")) {
            apply_remarks = "";
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
     * 审批申请:退租
     *
     * @param id            流程ID
     * @param user_id       用户工号
     * @param bed_id        床位ID
     * @param sta           审批结果
     * @param apply_remarks 审批备注
     * @return
     * @throws Exception
     */
    @Authorization
    @RequestMapping(value = "/applicationForExaminationAndApprovalByApplyIdToCheckout")
    @ResponseBody
    public ResultMessage applicationForExaminationAndApprovalByApplyId(String id, String user_id, String bed_id, String sta, String apply_remarks) throws Exception {
        try {
            if (sta.equals("1")) {
                apply_remarks = "";
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
            return new ResultMessage(1, "审批失败");
        }
    }

    /**
     * 普通用户：通过用户工号和page，limit获取数据
     *
     * @param user_id
     * @param page
     * @param limit
     * @return
     */
    @Authorization
    @RequestMapping(value = "/queryApplyInfoByLimitAndUserIdWithRoleUser")
    @ResponseBody
    public String queryApplyInfoByLimitAndUserIdWithRoleUser(String user_id, int page, int limit, String apply_type, String apply_sta) {
        try {
            apartmentApplyList = apartmentApplyDao.queryApplyInfoByLimitAndUserIdWithRoleUser(user_id, page, limit, apply_type, apply_sta);
            logger.info("apartmentApplyList.size()=" + apartmentApplyList.size());
            return ResultMessage.ListToLayuiTable(apartmentApplyList.size(), apartmentApplyList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }

    /**
     * 管理员：通过用户所属大区和page，limit获取数据
     *
     * @param user_main
     * @param page
     * @param limit
     * @return
     */
    @Authorization
    @RequestMapping(value = "/queryApplyInfoByLimitAndUserIdWithRoleAdmin")
    @ResponseBody
    public String queryApplyInfoByLimitAndUserIdWithRoleAdmin(String user_main, int page, int limit, String apply_type, String apply_sta) {
        try {
            apartmentApplyList = apartmentApplyDao.queryApplyInfoByLimitAndUserIdWithRoleAdmin(user_main, page, limit, apply_type, apply_sta);
            logger.info("apartmentApplyList.size()=" + apartmentApplyList.size());
            return ResultMessage.ListToLayuiTable(apartmentApplyList.size(), apartmentApplyList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }

    /**
     * 通过申请ID获取数据
     *
     * @param id
     * @return
     */
    @Authorization
    @RequestMapping(value = "/queryApplyInfoById")
    @ResponseBody
    public String queryApplyInfoById(String id, String apply_type) {
        try {
            if (apply_type.equals(0) || apply_type.equals("0")) {//入住申请
                apartmentApplyList = apartmentApplyDao.queryCheckInApplyInfoById(id);
            } else if (apply_type.equals(1) || apply_type.equals("1")) {
                apartmentApplyList = apartmentApplyDao.queryCheckOutApplyInfoById(id);
            } else {
                return ResultMessage.MessageToJson(1, "获取申请类型数据异常");
            }
            return ResultMessage.ListToJson(0, apartmentApplyList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }

    /**
     * 通过用户工号判断用户是否存在未审批的申请
     *
     * @param user_id
     * @return
     */
    @Authorization
    @RequestMapping(value = "/checkUserIsHaveAApplyNotAdopt")
    @ResponseBody
    public String checkUserIsHaveAApplyNotAdopt(String user_id) {
        try {
            int count = apartmentApplyDao.checkUserIsHaveAApplyNotAdopt(user_id);
            return ResultMessage.MessageToJson(0, count);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.MessageToJson(1, "获取数据异常");
        }
    }


}