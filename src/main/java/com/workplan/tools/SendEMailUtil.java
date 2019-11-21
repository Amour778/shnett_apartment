package com.workplan.tools;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEMailUtil {

	/**
	 * 通用发送邮件工具类
	 * @param  mail_protocol 连接协议
	 * @param  mail_host 主机名
	 * @param  mail_port 端口号
	 * @param  mail_auth 是否认证
	 * @param  mail_ssl 设置是否使用ssl安全连接
	 * @param  mail_debug 是否显示debug信息
	 * @param  mail_from 发件人邮箱地址
	 * @param  mail_password 发件人邮箱授权码
	 * @param  mail_title 邮件主题
	 * @param  mail_template 邮件模板
	 * @param  user_mail_address 收件人地址
	 * @param  mail_message 替换模板中问号的实际内容
	 * @return Map<String, String> 
	 * @throws AddressException
	 * @throws MessagingException
	 */

	public static Map<String, String> sendMail(String mail_protocol,
			String mail_host, int mail_port, String mail_auth, String mail_ssl,
			String mail_debug, String mail_from, String mail_password,
			String mail_title, String mail_template,
			List<String> user_mail_address, String[] mail_message)
			throws AddressException, MessagingException {
		Map<String, String> MESSAGE = new HashMap<String, String>();
		Properties properties = new Properties();
		properties.put("mail.transport.protocol", mail_protocol);
		properties.put("mail.smtp.host", mail_host);
		properties.put("mail.smtp.port", mail_port);
		properties.put("mail.smtp.auth", mail_auth);
		properties.put("mail.smtp.ssl.enable", mail_ssl);
		properties.put("mail.debug", mail_debug);// 设置是否显示debug信息 true
		
		// 得到会话对象
		Session session = Session.getInstance(properties);
		// 获取邮件对象
		Message message = new MimeMessage(session);
		// 设置发件人邮箱地址
		message.setFrom(new InternetAddress(mail_from));
		// 循环收件人列表，对收件人地址数组进行赋值
		InternetAddress[] sendTo = new InternetAddress[user_mail_address.size()];
		System.out.println("收件人地址数量为:"+user_mail_address.size());
		int user_mail_address_have=0;
		for (int i = 0; i < user_mail_address.size(); i++) {
			System.out.println("第"+(i+1)+"个收件人的收件地址为："+user_mail_address.get(i));
			if (user_mail_address.get(i)!=null&&!user_mail_address.get(i).equals("")&&!user_mail_address.get(i).equals("null")) {
				sendTo[i] = new InternetAddress(user_mail_address.get(i));
				user_mail_address_have++;
			}
		}
		if(user_mail_address_have==0){
			MESSAGE.put("code", "1");
			MESSAGE.put("info", "邮件发送失败：无收件人地址");
			return MESSAGE;
		}
		message.setRecipients(Message.RecipientType.TO, sendTo);
		// 设置邮件标题
		message.setSubject(mail_title);
		// 设置邮件内容
		message.setText(StringReplaceUtil.replaceQuestionMark(mail_template, mail_message));
		// 得到邮差对象
		Transport transport = session.getTransport();
		// 连接自己的邮箱账户
		try {
			transport.connect(mail_from, mail_password);// 密码为开通stmp服务后得到的客户端授权码
			// 发送邮件
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
			MESSAGE.put("code", "0");
			MESSAGE.put("info", "邮件发送成功");
		} catch (Exception e) {
			MESSAGE.put("code", "1");
			MESSAGE.put("info", "邮件发送失败：" + e.getMessage());
			e.printStackTrace();

		}
		return MESSAGE;
	}
}
