package com.workplan.tools;

import java.util.List;

/**
 * 2019年9月25日
 * 修改了下，返回的数据可以直接用bean的形式了
 */
public class ResultMessage {
    private static GsonUtil gsonUtil;

    String userid;
    int code;
    String message;
    String info;
    List<?> list;

    String msg;
    int count;
    String data;
    String openid;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public List<?> getList() {
        return list;
    }

    public void setList(List<?> list) {
        this.list = list;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    /**
     * 微信小程序登陆用返回信息
     *
     * @param code   状态码：0成功，1失败
     * @param userid 用户工号
     * @param info   信息
     * @param openid openid
     */
    public ResultMessage(int code, String userid, String info, String openid) {
        this.code = code;
        this.userid = userid;
        this.info = info;
        this.openid = openid;
    }


    /**
     * 单信息
     *
     * @param code    状态码：0成功，1失败
     * @param message 状态信息：成功、获取数据失败...之类的
     */
    public ResultMessage(int code, String message) {
        this.code = code;
        this.message = message;
    }

    /**
     * 多信息
     *
     * @param code    状态码：0成功，1失败
     * @param message 状态信息：成功、获取数据失败...之类的
     * @param info    状态信息：成功、获取数据失败...之类的
     */
    public ResultMessage(int code, String message, String info) {
        this.code = code;
        this.message = message;
        this.info = info;
    }

    /**
     * LayuiTable专用
     *
     * @param code  状态码：0成功，1失败
     * @param msg   状态信息：成功、获取数据失败...之类的
     * @param count 数据条数
     * @param list  List
     */
    public ResultMessage(int code, String msg, int count, List<?> list) {
        this.code = code;
        this.msg = msg == null ? "" : msg;
        this.count = count;
        this.data = gsonUtil.List2Json(list);
    }


    /**
     * LayuiTable专用
     *
     * @param Counts
     * @param list
     * @return
     */
    public static String ListToLayuiTable(int Counts, List<?> list) {
        String MESSAGE = "{\"code\": 0,\"msg\": \"\",\"count\":" + Counts
                + ",\"data\":" + gsonUtil.List2Json(list) + "}";
        return MESSAGE;
    }

    /**
     * LayuiTable专用
     *
     * @param msg
     * @return
     */
    public static String ListToLayuiTableWithErr(String msg) {
        String MESSAGE = "{\"code\": 0,\"msg\": \""+msg+"\",\"count\":0,\"data\":[]}";
        return MESSAGE;
    }


    /**
     * 将String数据转成(伪)Json数据所需要的格式
     *
     * @param code
     * @param info
     * @return
     */
    public static String MessageToJson(int code, String info) {
        String MESSAGE = "{\"code\":" + code + ",\"info\": \"" + info + "\"}";
        //System.out.println(ResultMessage.class+"-MessageToJson-MESSAGE="+MESSAGE);
        return MESSAGE;
    }

    /**
     * 信息转json，多消息
     *
     * @param code 状态码
     * @param msg  信息
     * @param info 消息
     * @return
     */
    public static String MessageToJson(int code, String msg, String info) {
        String MESSAGE = "{\"code\":" + code + ",\"msg\": \"" + msg + "\",\"info\": \"" + info + "\"}";
        return MESSAGE;
    }

    /**
     * 消息转json，单消息
     *
     * @param code 状态码
     * @param info 消息
     * @return
     */
    public static String MessageToJson(int code, int info) {
        String MESSAGE = "{\"code\":" + code + ",\"info\": " + info + "}";
        return MESSAGE;
    }

    /**
     * List转json
     *
     * @param code 状态码
     * @param list 数据列表
     * @return
     */
    public static String ListToJson(int code, List<?> list) {
        String MESSAGE = "{\"code\":" + code + ",\"info\": " + GsonUtil.List2Json(list) + "}";
        return MESSAGE;
    }


    /**
     * List转json
     *
     * @param code    状态码
     * @param listOne 数据列表
     * @param listTwo 数据列表
     * @return
     */
    public static String ListsToJson(int code, List<?> listOne, List<?> listTwo) {
        String MESSAGE = "{\"code\":" + code + ",\"infoOne\": " + gsonUtil.List2Json(listOne) + ",\"infoTwo\": " + gsonUtil.List2Json(listTwo) + "}";
        return MESSAGE;
    }

    /**
     * 下拉选择框专用
     *
     * @param dataString
     * @return
     */
    public static String ListToFormSelects(String dataString) {
        dataString = ListToFormSelectsStringSplit(dataString);
        String MESSAGE = "{\"code\":0,\"msg\":\"success\",\"data\":[" + dataString + "]}";
        return MESSAGE;
    }

    /**
     * 下拉选择框专用：列表循环取值
     *
     * @param MESSAGE
     * @return
     */
    public static String ListToFormSelectsStringSplit(String MESSAGE) {
        if (MESSAGE.length() != 0 && MESSAGE.substring(MESSAGE.length() - 1, MESSAGE.length()).equals(",")) {
            MESSAGE = MESSAGE.substring(0, MESSAGE.length() - 1);
        }
        return MESSAGE;
    }

}
