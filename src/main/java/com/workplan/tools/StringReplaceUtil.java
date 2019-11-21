package com.workplan.tools;

/**
 * 字符串替换工具类
 * @author 01059101
 *
 */
public class StringReplaceUtil {
	public static void main(String[] args) {
	    String temp=" aaa ? ccc ? eee ?;";
	    String[] arr={"bbb","ddd","f"};
		System.out.println(replaceQuestionMark(temp,arr));
	}
	
	/**
	 * 根据用户传入的str(str中需要替换的字符为问号'?')，和传入的替换数组，返回替换结果
	 * 需要用户先判断需要替换的数量是否一致
	 * @param str
	 * @param arr
	 * @return
	 */
	public static String replaceQuestionMark(String str,String[] arr) {
		try {
			for(int i = 0 ; i<arr.length; i++){
				str=str.replaceFirst("\\?", arr[i].toString());
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println("替换字符?完成！替换结果为："+str);
		return str;
		
	}
}
