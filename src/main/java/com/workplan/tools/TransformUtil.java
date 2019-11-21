package com.workplan.tools;

import java.util.LinkedList;
import java.util.List;

public class TransformUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	/**
	 * 将String[]中的数据去重
	 * @param a
	 * @return
	 */
	public static String[] array_unique(String[] a) {  
	    // array_unique  
	    List<String> list = new LinkedList<String>();  
	    for(int i = 0; i < a.length; i++) {  
	        if(!list.contains(a[i])) {  
	            list.add(a[i]);  
	        }  
	    }  
	    return list.toArray(new String[list.size()]);  
	}  

}
