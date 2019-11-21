package com.workplan.tools;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * 时间相关操作工具
 * @author 01059101
 *
 */
public class GetDateTimeNow {
	/**
	 * 转换成标准日期时间
	 * 
	 * @return yyyy-MM-dd HH:mm:ss
	 * @throws ParseException
	 */
	public static String getDateTime() throws ParseException {
		Date d = new Date();
		//System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateNowStr = sdf.format(d);
		System.out.println("转换成标准日期时间：" + dateNowStr);

		return dateNowStr;
	}
	/**
	 * 转换成标准日期
	 * 
	 * @return yyyy-MM-dd
	 * @throws ParseException
	 */
	public static String getDate() throws ParseException {
		Date d = new Date();
		//System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr = sdf.format(d);
		System.out.println("转换成标准日期：" + dateNowStr);

		return dateNowStr;
	}

	/**
	 * 转换成标准日期
	 * @param addDate 几天后的日期 
	 * @return
	 * @throws ParseException
	 */
	public static String getDate(int addDate) throws ParseException {
		Date d=new Date();
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
		String dateNowStr=df.format(new Date(d.getTime() + addDate * 24 * 60 * 60 * 1000));
		System.out.println(addDate+"天后转换成标准日期：" + dateNowStr);
		return dateNowStr;
	}
	/**
	 * 转换成标准时间
	 * 
	 * @return HH:mm:ss
	 * @throws ParseException
	 */
	public static String getTime() throws ParseException {
		Date d = new Date();
		//System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String dateNowStr = sdf.format(d);
		System.out.println("转换成标准时间：" + dateNowStr);

		return dateNowStr;
	}
	/**
	 * 日期时间转换为唯一标签(String)
	 * 
	 * @return yyyyMMddHHmmss + 3位随机数
	 * @throws ParseException
	 */
	public static String getDateTimeRandomToID() throws ParseException {
		Date d = new Date();
		Random random=new Random();
		//System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String dateNowStr = sdf.format(d)+random.nextInt(999);
		System.out.println("日期时间转换为唯一标签：" + dateNowStr);
		return dateNowStr;
	}
	/**
	 * 日期时间转换为唯一标签(int)
	 * 
	 * @return yyyyMMddHHmmss + 3位随机数
	 * @throws ParseException
	 */
	public static int getDateTimeRandomToIDInt() throws ParseException {
		Date d = new Date();
		Random random=new Random();
		//System.out.println(d);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		int dateNowStr =Integer.parseInt(sdf.format(d)+random.nextInt(999));
		System.out.println("日期时间转换为唯一标签：" + dateNowStr);
		return dateNowStr;
	}
}
