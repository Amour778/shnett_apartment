package com.workplan.bean.wxTemp;

public class WxTemplateMessageByUrl {
    //templateMessage.send返回的数据包
    //文档：https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/template-message/templateMessage.send.html#HTTPS%20%E8%B0%83%E7%94%A8
    //代码
    private int  errcode;
    //信息
    private String errmsg;

    public int getErrcode() {
        return errcode;
    }

    public void setErrcode(int errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }
}
