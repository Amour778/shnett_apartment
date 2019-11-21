package com.workplan.bean;

/**
 * 微信小程序，通过code与腾讯服务器换取openid后的返回数据类
 * 文档：https://developers.weixin.qq.com/miniprogram/dev/api-backend/open-api/login/auth.code2Session.html
 */
public class WxMiniProjectBean {
    private String session_key;
    private String openid;
    private String errcode;
    private String errmsg;

    public String getSession_key() {
        return this.session_key;
    }

    public void setSession_key(String sessionKey) {
        this.session_key = sessionKey;
    }

    public String getOpenid() {
        return this.openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getErrcode() {
        return this.errcode;
    }

    public void setErrcode(String errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return this.errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }
}
