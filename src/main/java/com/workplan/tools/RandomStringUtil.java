package com.workplan.tools;

import java.util.Random;

public class RandomStringUtil {

    public static final String allChar = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String letterChar = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    public static final String numberChar = "0123456789";


    /**
     *  返回指定长度的随机字符串(数字、英文大小写)
     * @param length 整个字符串的长度
     * @return
     */
    public static String generateString(int length)
    {
        StringBuffer sb = new StringBuffer();
        Random random = new Random();
        for (int i = 0; i < length; i++)
        {
            sb.append(allChar.charAt(random.nextInt(allChar.length())));
        }
        return sb.toString();
    }

    /**
     * 返回指定长度的随机字符串
     * @param length_letter 英文大小写长度
     * @param length_number 数字长度
     * @param type 排列方式：0-英文在前，1-数字在前
     * @return
     */
    public static String generateString(int length_letter,int length_number,int type)
    {
        StringBuffer sb = new StringBuffer();
        Random random = new Random();
        switch (type) {
            case 0:
                for (int i = 0; i < length_letter; i++)
                {
                    sb.append(letterChar.charAt(random.nextInt(letterChar.length())));
                }
                for (int i = 0; i < length_number; i++)
                {
                    sb.append(numberChar.charAt(random.nextInt(numberChar.length())));
                }
                break;
            case 1:
                for (int i = 0; i < length_number; i++)
                {
                    sb.append(numberChar.charAt(random.nextInt(numberChar.length())));
                }
                for (int i = 0; i < length_letter; i++)
                {
                    sb.append(letterChar.charAt(random.nextInt(letterChar.length())));
                }
                break;
            default:
                break;
        }
        return sb.toString();
    }

}
