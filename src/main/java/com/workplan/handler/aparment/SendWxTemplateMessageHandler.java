package com.workplan.handler.aparment;

import com.alibaba.fastjson.JSONObject;
import com.workplan.bean.wxTemp.SubscribeMessageTemplateDate;
import com.workplan.bean.wxTemp.TemplateData;
import com.workplan.tools.GetDateTimeNow;
import com.workplan.tools.Jcode2SessionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SendWxTemplateMessageHandler {

    private static Logger logger = LoggerFactory.getLogger(SendWxTemplateMessageHandler.class);

    /**
     * 发送新申请通知模板
     *
     * @param apply_type    入住申请/退租申请
     * @param user_id       用户工号
     * @param user_name     用户名称
     * @param user_tel      用户手机
     * @param user_point    用户网点
     * @param date_check_in 入住日期(如果是退租申请，则此条数据为"-")
     * @param date_move_out 退租日期
     * @param reason        理由
     * @param user_openid   接收人的openid
     * @param form_id       表单ID
     * @return
     */
    public String sendNewApply(String apply_type, String user_id, String user_name, String user_tel
            , String user_point, String date_check_in, String date_move_out, String reason, String user_openid, String form_id) {
        Map<String, TemplateData> data = new HashMap<>();
        data.put("keyword1", new TemplateData(apply_type));
        data.put("keyword2", new TemplateData(user_id));
        data.put("keyword3", new TemplateData(user_name));
        data.put("keyword4", new TemplateData(user_tel));
        data.put("keyword5", new TemplateData(user_point));
        data.put("keyword6", new TemplateData(date_check_in));
        data.put("keyword7", new TemplateData(date_move_out));
        data.put("keyword8", new TemplateData(reason));
        data.put("keyword9", new TemplateData(GetDateTimeNow.getDateTime()));
        String returnMessage = Jcode2SessionUtil.sendTemplateMessage(user_openid, "itTQeQUb4ku-qerCnDRsTT9PQ_CcmYbT79wklX77nLo",
                "", form_id, data, "/pages/applyList/applyList");
        logger.info(returnMessage);
        return returnMessage;
    }

    /**
     * 审批结果通知模板
     *
     * @param user_id     用户工号
     * @param apply_typy  申请类型
     * @param apply_sta   审批结果
     * @param user_openid 接收人的openid
     * @param form_id     表单ID
     * @return
     */
    public String sendApplyCheck(String user_id, String apply_typy, String apply_sta, String user_openid, String form_id) {
        Map<String, TemplateData> data = new HashMap<>();
        data.put("keyword1", new TemplateData(user_id));//申请人
        data.put("keyword2", new TemplateData(apply_typy));//审批类型(申请类型
        data.put("keyword3", new TemplateData(apply_sta));//审批结果
        data.put("keyword4", new TemplateData(GetDateTimeNow.getDateTime()));//审批时间
        String returnMessage = Jcode2SessionUtil.sendTemplateMessage(user_openid, "zxJe6_O-yf-bKjLOsbNVBze6ScL7pJTpEJ8K8O05Pgo",
                "", form_id, data, "/pages/applyList/applyList");
        logger.info(returnMessage);
        System.out.println(returnMessage);
        return returnMessage;
    }

    /**
     * 审批进度订阅模板通知
     *
     * @param user_name
     * @param apply_type
     * @param apply_sta
     * @param user_openid
     * @return
     */
    public String sendApplyCheckSubscribeMessage(String user_name, String apply_type, String apply_sta, String user_openid) {
        SubscribeMessageTemplateDate subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        JSONObject objData = new JSONObject();
        logger.info("name2="+apply_type+",name3="+user_name+",phrase5="+apply_sta);
        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(apply_type);
        Object json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("name2", json);

        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(user_name);
        json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("name3", json);

        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(apply_sta);
        json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("phrase5", json);

        System.out.println(objData.toString());


        String returnMessage = Jcode2SessionUtil.sendSubscribeMessage(user_openid, "JS2pyrbT1miKHnSfHbLwtha0GbioKnqtkA2cJ-ksEf4",
                "/pages/applyList/applyList", objData);
        System.out.println(returnMessage);
        return returnMessage;
    }

    /**
     * 新申请审批订阅模板通知
     *
     * @param user_id
     * @param apply_typy
     * @param date_check_in
     * @param date_move_out
     * @param user_openid
     * @return
     */
    public String sendNewApplySubscribeMessage(String user_id, String apply_typy, String date_check_in, String date_move_out, String user_openid) {
        SubscribeMessageTemplateDate subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        logger.info("character_string1="+user_id+",phrase2="+apply_typy+",date3="+date_check_in);
        JSONObject objData = new JSONObject();
        //工号
        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(user_id);
        Object json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("character_string1", json);

        //申请类型
        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(apply_typy);
        json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("phrase2", json);

        //入住日期
        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(date_check_in);
        json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("date3", json);

        //退租日期
        subscribeMessageTemplateDate = new SubscribeMessageTemplateDate();
        subscribeMessageTemplateDate.setValue(date_move_out);
        json = JSONObject.toJSON(subscribeMessageTemplateDate);
        objData.put("date4", json);

        System.out.println(objData.toString());
        String returnMessage = Jcode2SessionUtil.sendSubscribeMessage(user_openid, "38N5GXPckavbb3F1bIXf8jiOJZYdfW6PSAcLncs3LhA",
                "/pages/applyList/applyList", objData);
        System.out.println(returnMessage);
        return returnMessage;
    }

}
