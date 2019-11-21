package com.workplan.tools;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

/*
 * 操作数据库的工具类(dao)
 * 此工具类包含：
 * 1，读取配置文件并建立数据库的连接
 * 2，执行数据库的搜索语句，用户用户登录验证
 * 3，关闭资源
 * 4，获得ct,ps,rs的静态资源
 */
public class sqlHelper {
	private static Connection ct = null;
	private static PreparedStatement ps = null;
	private static ResultSet rs = null;
	private static CallableStatement cs = null;
	// 连接数据库的参数
	private static String url = "";
	private static String username = "";
	private static String password = "";
	private static String driver = "";
	// 读取配置文件
	private static Properties pp = null;
	private static InputStream fis = null;
	
	// 短信模板信息
	private static String isenable=null;
	private static String accessKeyId=null;
	private static String accessKeySecret=null;
	//短信签名
	private static String SignName=null;
	//短信模板
	private static String NewItemTemplateCode=null;
	private static String GeneratePasswordTemplateCode=null;
	

	//#盛海工作全景：提前多久提醒用户事件即将过期。单位：天
	private static String completion_time = "";
	//#盛海工作全景：时间过期多久提醒用户事件已经过期。单位：天
	private static String completion_time_timeout = "";

	//#微信小程序-易点租-上传图片压缩质量,取值0~1范围，越大图片质量越好
	private static String wechat_edianzu_qality = "1";
	//#微信小程序-易点租-是否进行中文转码new String(request.getParameter("info").getBytes("ISO8859-1"), "UTF-8");
	private static String wechat_edianzu_transcoding="";


	static {
		try {
			// 从配置文件中读取配置信息
			pp = new Properties();
			// fis = new InputStream("info.properties");
			// 当使用javaweb项目时，读取文件要使用类加载器(随便哪个类都可以,此处使用SQLHelper类,因为类加载器读取资源时，默认的主目录就是src目录)
			fis = sqlHelper.class.getClassLoader().getResourceAsStream(
					"info.properties");
			pp.load(fis);
			url = pp.getProperty("jdbc.url");
			username = pp.getProperty("jdbc.username");
			password = pp.getProperty("jdbc.password");
			driver = pp.getProperty("jdbc.driverClassName");
			
			isenable=pp.getProperty("isenable");
			accessKeyId = pp.getProperty("accessKeyId");
			accessKeySecret = pp.getProperty("accessKeySecret");
			SignName = new String(pp.getProperty("SignName").getBytes("ISO-8859-1"), "UTF-8");
			//新事项
			NewItemTemplateCode = pp.getProperty("NewItemTemplateCode");
			//重置密码
			GeneratePasswordTemplateCode = pp.getProperty("GeneratePasswordTemplateCode");

			// 盛海工作全局过期的提醒时间
			completion_time = pp.getProperty("completion_time");
			// 盛海工作过期多久的提醒时间
			completion_time_timeout = pp.getProperty("completion_time_timeout");

			// 微信小程序-易点租-上传图片压缩质量,取值0~1范围，越大图片质量越好
			wechat_edianzu_qality = pp.getProperty("wechat_edianzu_qality");
			//#微信小程序-易点租-是否进行中文转码new String(request.getParameter("info").getBytes("ISO8859-1"), "UTF-8");
			wechat_edianzu_transcoding= pp.getProperty("wechat_edianzu_transcoding");;
			Class.forName(driver);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fis.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			fis = null;
		}
	}

	
	public static String getWechat_edianzu_transcoding() {
		return wechat_edianzu_transcoding;
	}


	public static void setWechat_edianzu_transcoding(String wechatEdianzuTranscoding) {
		wechat_edianzu_transcoding = wechatEdianzuTranscoding;
	}


	public static String getIsenable() {
		return isenable;
	}


	public static void setIsenable(String isenable) {
		sqlHelper.isenable = isenable;
	}


	public static String getAccessKeyId() {
		return accessKeyId;
	}


	public static void setAccessKeyId(String accessKeyId) {
		sqlHelper.accessKeyId = accessKeyId;
	}


	public static String getAccessKeySecret() {
		return accessKeySecret;
	}


	public static void setAccessKeySecret(String accessKeySecret) {
		sqlHelper.accessKeySecret = accessKeySecret;
	}


	public static String getSignName() {
		return SignName;
	}


	public static void setSignName(String signName) {
		SignName = signName;
	}


	public static String getNewItemTemplateCode() {
		return NewItemTemplateCode;
	}


	public static void setNewItemTemplateCode(String newItemTemplateCode) {
		NewItemTemplateCode = newItemTemplateCode;
	}


	public static String getGeneratePasswordTemplateCode() {
		return GeneratePasswordTemplateCode;
	}


	public static void setGeneratePasswordTemplateCode(
			String generatePasswordTemplateCode) {
		GeneratePasswordTemplateCode = generatePasswordTemplateCode;
	}


	public static String getCompletion_time() {
		return completion_time;
	}


	public static void setCompletion_time(String completionTime) {
		completion_time = completionTime;
	}


	public static String getCompletion_time_timeout() {
		return completion_time_timeout;
	}


	public static void setCompletion_time_timeout(String completionTimeTimeout) {
		completion_time_timeout = completionTimeTimeout;
	}


	public static String getWechat_edianzu_qality() {
		return wechat_edianzu_qality;
	}


	public static void setWechat_edianzu_qality(String wechatEdianzuQality) {
		wechat_edianzu_qality = wechatEdianzuQality;
	}


	// 得到连接
	public static Connection getConnection() {
		try {
			ct = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ct;
	}
	

	// 关闭资源的方法
	public static void close(ResultSet rs, Statement ps, Connection ct) {
		// 关闭资源(先开后关)
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				//e.printStackTrace();
			}
			rs = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (SQLException e) {
				//e.printStackTrace();
			}
			ps = null;
		}
		if (null != ct) {
			try {
				ct.close();
			} catch (SQLException e) {
				//e.printStackTrace();
			}
			ct = null;
		}
	}

	public static Connection getCt() {
		return ct;
	}

	public static PreparedStatement getPs() {
		return ps;
	}

	public static ResultSet getRs() {
		return rs;
	}
	
}