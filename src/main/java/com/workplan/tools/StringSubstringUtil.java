package com.workplan.tools;

/**
 * 号码隐藏工具类
 */
public class StringSubstringUtil {

    /**
     * 手机号码数据隐藏
     *  非11位号码，则返回NULL
     * 12345123451 ==>123****5123
     * @param phone
     * @return
     */
    public static String phoneNumber(String phone){
        int pL = phone.length();
        if(pL!=11){
            return null;
        }
        return phone.substring(0, 3) + "****" + phone.substring(7, pL);
    }

    /**
     * 身份证号码数据隐藏
     * 非15位或非18位号码，则返回NULL
     * 123451234512345 ==>123451****2345
     * 123451234512345123 ==>123451****5123
     * @param idCard
     * @return
     */
    public static String idCardNumber(String idCard){
        int icL = idCard.length();
        if(icL!=15 || icL!=18){
            return null;
        }
        if(icL==15){
            return idCard.substring(0, 6) + "****" + idCard.substring(11, icL);
        }else{
            return idCard.substring(0, 6) + "****" + idCard.substring(14, icL);
        }
    }
}
