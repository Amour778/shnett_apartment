package com.workplan.tools;

import com.aliyuncs.exceptions.ClientException;

public class SendShortMessage {
	/**
	 * 
	 * @param UserPhone
	 * @param ItemName
	 * @param MessageType ： 
	 * 			NewItemTemplateCode=>新事项  GeneratePasswordTemplateCode=>重置密码
	 * @return
	 * @throws ClientException
	 */
	public String sendShortMessage(String UserPhone,String ItemName,String MessageType) throws ClientException {
		/*//读取配置文件
		sqlHelper sqlHelper=new sqlHelper();
		
		String isenable="false";
		String accessKeyId=null;
		String accessKeySecret=null;
		//短信签名
		String SignName=null;
		//短信模板
		String TemplateCode=null;
		isenable = com.workplan.tools.sqlHelper.getIsenable();
		accessKeyId = com.workplan.tools.sqlHelper.getAccessKeyId();
		accessKeySecret = com.workplan.tools.sqlHelper.getAccessKeySecret();
		SignName = com.workplan.tools.sqlHelper.getSignName();
		if (MessageType.equals("NewItemTemplateCode"))// 新事项
			TemplateCode = com.workplan.tools.sqlHelper.getNewItemTemplateCode();
		else if (MessageType.equals("GeneratePasswordTemplateCode"))// 重置密码
			TemplateCode = com.workplan.tools.sqlHelper.getGeneratePasswordTemplateCode();


		System.out.println("isenable="+isenable+"，Boolean.valueOf(isenable)="+Boolean.valueOf(isenable));
		System.out.println("accessKeyId="+accessKeyId);
		System.out.println("accessKeySecret="+accessKeySecret);
		System.out.println("SignName="+SignName);
		System.out.println("TemplateCode="+TemplateCode);
		if(Boolean.valueOf(isenable)){
			String sendCodeString = null;
			// 设置超时时间-可自行调整
			System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
			System.setProperty("sun.net.client.defaultReadTimeout", "10000");
			// 初始化ascClient需要的几个参数
			final String product = "Dysmsapi";// 短信API产品名称（短信产品名固定，无需修改）
			final String domain = "dysmsapi.aliyuncs.com";// 短信API产品域名（接口地址固定，无需修改）
			// 替换成你的AK
			// accessKeyId = "LTAIlRtwhQfyKlgD";//你的accessKeyId,参考本文档步骤2
			accessKeyId = accessKeyId;// "LTAIlRtwhQfyKlgD";
			// accessKeySecret =
			// "CsLPmc9h4Qg9mMNByVzX0VfEG2Ml6z";//你的accessKeySecret，参考本文档步骤2
			accessKeySecret = accessKeySecret;
			// 初始化ascClient,暂时不支持多region（请勿修改）
			IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou",
					accessKeyId, accessKeySecret);
			DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product,
					domain);
			IAcsClient acsClient = new DefaultAcsClient(profile);
			// 组装请求对象
			SendSmsRequest request = new SendSmsRequest();
			// 使用post提交
			request.setMethod(MethodType.POST);
			// 必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式；发送国际/港澳台消息时，接收号码格式为00+国际区号+号码，如“0085200000000”
			request.setPhoneNumbers(UserPhone);
			// 必填:短信签名-可在短信控制台中找到
			// request.setSignName("盛海科技");
			request.setSignName(SignName);
			// 必填:短信模板-可在短信控制台中找到，发送国际/港澳台消息时，请使用国际/港澳台短信模版
			// request.setTemplateCode("SMS_145500661");
			request.setTemplateCode(TemplateCode);
			// 可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
			// 友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
			request.setTemplateParam("{\"itemName\":\"" + ItemName + "\"}");
			// 可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
			// request.setSmsUpExtendCode("90997");
			// 可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
			// request.setOutId("yourOutId");
			// 请求失败这里会抛ClientException异常
			SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
			if (sendSmsResponse.getCode() != null
					&& sendSmsResponse.getCode().equals("OK")) {
				sendCodeString = "0";
			} else {
				sendCodeString = sendSmsResponse.getCode();
			}
			return sendCodeString;
		} else {
			return "短信功能在配置上为'禁用'状态";
		}*/
		return "短信功能在配置上为'禁用'状态";
	}
}
