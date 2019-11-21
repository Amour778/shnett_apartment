package com.workplan.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import com.workplan.bean.MailBean;
import com.workplan.dao.BaseDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.workplan.bean.UserInfoBean;
import com.workplan.tools.SendEMailUtil;
import com.workplan.tools.StringReplaceUtil;

@Controller
public class MailHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(MailHandler.class);
    List<MailBean> mailList = new ArrayList<MailBean>();
    StringReplaceUtil strReplace = new StringReplaceUtil();

    /**
     * 调用通用发送邮件工具类发送邮件
     *
     * @param mail_type         邮件类型ID
     * @param mail_templateid   邮件模板ID
     * @param mail_message      邮件内容
     * @param user_mail_address 收件人地址
     * @return Map<String, String>
     */
    private Map<String, String> sendMail(int mail_type, int mail_templateid, String[] mail_message, List<String> user_mail_address) {
        Map<String, String> MESSAGE = new HashMap<String, String>();
        List<MailBean> mailList = mailDao.queryMailByType(mail_type, mail_templateid);
        System.out.println("获取到的邮件模板数据长度为" + mailList.size());
        String mail_protocol;
        String mail_host;
        int mail_port;
        String mail_auth;
        String mail_ssl;
        String mail_debug;
        String mail_from;
        String mail_password;
        String mail_title;
        String mail_template;
        try {
            mail_protocol = mailList.get(0).getMail_protocol();
            mail_host = mailList.get(0).getMail_host();
            mail_port = mailList.get(0).getMail_port();
            mail_auth = mailList.get(0).getMail_auth();
            mail_ssl = mailList.get(0).getMail_ssl();
            mail_debug = mailList.get(0).getMail_debug();
            mail_from = mailList.get(0).getMail_from();
            mail_password = mailList.get(0).getMail_password();
            mail_title = mailList.get(0).getMail_title();
            mail_template = mailList.get(0).getMail_template();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            MESSAGE.put("code", "1");
            MESSAGE.put("info", "获取发件模板错误：" + e.getMessage());
            return MESSAGE;
        }
        try {
            MESSAGE = SendEMailUtil.sendMail(mail_protocol, mail_host, mail_port, mail_auth, mail_ssl, mail_debug, mail_from, mail_password, mail_title, mail_template, user_mail_address, mail_message);
            return MESSAGE;
        } catch (AddressException e) {
            e.printStackTrace();
            MESSAGE.put("code", "1");
            MESSAGE.put("info", "发送邮件时发生错误：" + e.getMessage());
            return MESSAGE;
        } catch (MessagingException e) {
            e.printStackTrace();
            MESSAGE.put("code", "1");
            MESSAGE.put("info", "发送邮件时发生错误：" + e.getMessage());
            return MESSAGE;
        }
    }

    /**
     * 发送入住申请邮件
     *
     * @param user_id
     * @param user_intention
     * @param in_reason
     * @param check_in_type
     * @param apply_type
     * @param date_check_in
     * @param date_move_out
     * @return
     */
    public Map<String, String> sendInMail(String user_id, String user_intention, String in_reason, String check_in_type,
                                            String apply_type, String date_check_in, String date_move_out) {
        if(check_in_type.equals("0")){
            check_in_type="新住";
        }else if(check_in_type.equals("1")){
            check_in_type="续租";
        }
        Map<String, String> MESSAGE = new HashMap<String, String>();
        //获取所有拥有1001权限的用户邮箱地址
        List<UserInfoBean> userList =new ArrayList<UserInfoBean>();
        userList = userinfoDao.queryUserMailByUserRoleIsOneZeroZeroOne();
        if (userList.size() == 0) {
            logger.info("获取到的邮箱地址为空，故未发送邮件。申请类型: " + apply_type + ",用户工号: " + user_id + ",入住类型=" + check_in_type + ",用户意向公寓ID：" + user_intention + ",入住日期: " + date_check_in + ",退租日期: " + date_move_out + ",理由: " + in_reason);
        }
        List<String> user_mail_address = new ArrayList<String>();
        for (int a = 0; a < userList.size(); a++) {
            if (!userList.get(a).getUser_mail().equals("") && userList.get(a).getUser_mail() != null)
                user_mail_address.add(userList.get(a).getUser_mail());
        }
        if (user_mail_address.size() == 0) {
            logger.info("解析后的邮箱地址为空，故未发送邮件。申请类型: " + apply_type + ",用户工号: " + user_id + ",入住类型=" + check_in_type + ",用户意向公寓ID：" + user_intention + ",入住日期: " + date_check_in + ",退租日期: " + date_move_out + ",理由: " + in_reason);
        }
        logger.info("邮件内容。申请类型: " + apply_type + ",用户工号: " + user_id + ",入住类型=" + check_in_type + ",用户意向公寓ID：" + user_intention + ",入住日期: " + date_check_in + ",退租日期: " + date_move_out + ",理由: " + in_reason);
        int mail_templateid = Integer.parseInt(apply_type);// 邮件模板编码
        String[] mail_message = { user_id, check_in_type, user_intention, date_check_in, date_move_out, in_reason};
        try {
            sendMail(1, mail_templateid, mail_message, user_mail_address);
            MESSAGE.put("code", "0");
            MESSAGE.put("info", "发送审核入住申请的邮件成功");
            return MESSAGE;
        } catch (Exception e) {
            logger.info("发送审核入住申请的邮件失败=>"+e.getMessage());
            MESSAGE.put("code", "1");
            MESSAGE.put("info", "发送审核入住申请的邮件失败=>"+e.getMessage());
            return MESSAGE;
        }
    }


    /**
     * 发送审核退租申请的邮件
     * @param user_id
     * @param out_reason
     * @param date_move_out
     * @param apply_type
     * @return
     */
    public Map<String, String> sendOutMail(String user_id, String out_reason, String date_move_out, String apply_type) {
        Map<String, String> MESSAGE = new HashMap<String, String>();
        //获取所有拥有1001权限的用户邮箱地址
        List<UserInfoBean> userList = userinfoDao.queryUserMailByUserRoleIsOneZeroZeroOne();
        if (userList.size() == 0) {
            logger.info("获取到的邮箱地址为空，故未发送邮件。申请类型: " + apply_type + ",用户工号: " + user_id +",退租日期: " + date_move_out + ",理由: " + out_reason);
        }
        List<String> user_mail_address = new ArrayList<String>();
        for (int a = 0; a < userList.size(); a++) {
            if (!userList.get(a).getUser_mail().equals("") && userList.get(a).getUser_mail() != null)
                user_mail_address.add(userList.get(a).getUser_mail());
        }
        if (user_mail_address.size() == 0) {
            logger.info("解析后的邮箱地址为空，故未发送邮件。申请类型: " + apply_type + ",用户工号: " + user_id +",退租日期: " + date_move_out + ",理由: " + out_reason);
        }
        logger.info("邮件内容，申请类型: " + apply_type + ",用户工号: " + user_id +",退租日期: " + date_move_out + ",理由: " + out_reason);
        int mail_templateid = Integer.parseInt(apply_type);// 邮件模板编码
        String[] mail_message = {user_id, date_move_out,out_reason};
        try {
            sendMail(1, mail_templateid, mail_message, user_mail_address);
            MESSAGE.put("code", "0");
            MESSAGE.put("info", "发送审核退租申请的邮件成功");
            return MESSAGE;
        } catch (Exception e) {
            logger.info("发送审核退租申请的邮件失败=>"+e.getMessage());
            MESSAGE.put("code", "1");
            MESSAGE.put("info", "发送审核退租申请的邮件失败=>"+e.getMessage());
            return MESSAGE;
        }
    }

}
