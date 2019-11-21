package com.workplan.tools;

import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.workplan.bean.UserInfoBean;
import com.workplan.bean.WxMiniProjectBean;
import com.workplan.bean.wxTemp.AccessToken;
import com.workplan.bean.wxTemp.TemplateData;
import com.workplan.dao.BaseDao;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public class Jcode2SessionUtil implements BaseDao {
   private static String APP_ID = "wx2fbd9d9cf9e971c9";
    private static String APP_SECRET = "44eaf3f4c72b5cb3dabd4596b817a315";
    public Map OpenIdServlet(String code)
            throws IOException {
        Map map = new HashMap();

        String APP_GRANT_TYPE = "authorization_code";
        String requestUrl = "https://api.weixin.qq.com/sns/jscode2session";
        Gson gson = new Gson();
        String json = HttpRequestUtil.sendGet(requestUrl, "appid=" + APP_ID
                + "&secret=" + APP_SECRET + "&js_code=" + code + "&grant_type="
                + APP_GRANT_TYPE);
        System.out.println("json=" + json);
        WxMiniProjectBean result = gson.fromJson(json, WxMiniProjectBean.class);
        if (result.getErrcode() == null) {
            String OPENID = result.getOpenid();
            System.out.println("openid=" + OPENID);

            List<UserInfoBean> userInfoList =userinfoDao.querySimpleUserSimpleInfoByOPENID(OPENID);
            if (userInfoList.size()==0) {
                System.out.println("MESSAGE=用户未绑定");
                map.put("code", 1);
                map.put("userid", "");
                map.put("info", "BIND");
                map.put("openid", OPENID);
            } else if (userInfoList.size()==1) {
                if(userInfoList.get(0).getSta()==0){
                    System.out.println("MESSAGE=正常获取用户信息，但是用户被禁用");
                    map.put("code", 1);
                    map.put("userid", userInfoList.get(0).getUser_id());
                    map.put("info", "DISABLED");
                    map.put("openid", OPENID);
                }else{
                    System.out.println("MESSAGE=正常获取用户信息");
                    map.put("code", 0);
                    map.put("userid", userInfoList.get(0).getUser_id());
                    map.put("info","正常获取用户信息" );
                    map.put("openid", OPENID);
                }

            } else{
                map.put("code", 1);
                map.put("userid", "");
                map.put("info", "用户OPENID存在多个绑定工号");
                map.put("openid", OPENID);
                System.out.println("MESSAGE=用户OPENID存在多个绑定工号");
            }
        } else {
            map.put("code", 1);
            map.put("userid", "");
            map.put("info", "获取用户OPENID失败");
            map.put("openid", "");
            System.out.println("MESSAGE=获取用户OPENID失败");
        }
        return map;
    }


    /**
     * 请求微信后台获取用户数据
     * @param code wx.login获取到的临时code
     * @return 请求结果
     * @throws Exception
     */
    public static String jscode2session(String appid,String secret,String code,String grantType)throws Exception{
        //定义返回的json对象
        JSONObject result = new JSONObject();
        //创建请求通过code换取session等数据
        HttpPost httpPost = new HttpPost(WeChatUrl.JS_CODE_2_SESSION.getUrl());
        List<NameValuePair> params=new ArrayList<NameValuePair>();
        //建立一个NameValuePair数组，用于存储欲传送的参数
        params.add(new BasicNameValuePair("appid",appid));
        params.add(new BasicNameValuePair("secret",secret));
        params.add(new BasicNameValuePair("js_code",code));
        params.add(new BasicNameValuePair("grant_type",grantType));
        //设置编码
        httpPost.setEntity(new UrlEncodedFormEntity(params));//添加参数
        return EntityUtils.toString(new DefaultHttpClient().execute(httpPost).getEntity());
    }
    /**
     * 获取微信接口调用凭证
     * @param appid
     * @param secret
     * @return 返回String 可转JSON
     */
    public static String getAccessToken(String appid,String secret){
        JSONObject params = new JSONObject();
        params.put("grant_type","client_credential");//获取接口调用凭证
        params.put("appid",appid);
        params.put("secret",secret);
        return HttpUtil.sendGet(WeChatUrl.GET_ACCESS_TOKEN.getUrl()+"?grant_type=client_credential&appid=" + appid + "&secret=" + secret);
    }

    /**
     * 发送模板消息
     * //@param access_token      接口调用凭证
     * @param touser            接收者（用户）的 openid
     * @param template_id       所需下发的模板消息id
     * @param page              点击模版卡片后跳转的页面，仅限本小程序内的页面。支持带参数，（eg：index?foo=bar）。该字段不填则模版无法跳转
     * @param form_id           表单提交场景下，为submit事件带上的formId；支付场景下，为本次支付的 prepay_id
     * @param data              模版内容，不填则下发空模版。具体格式请参照官网示例
     * @param emphasis_keyword  模版需要放大的关键词，不填则默认无放大
     * @return                  返回String可转JSON
     */
    public static String sendTemplateMessage( String touser, String template_id, String page, String form_id, Map<String, TemplateData> data, String emphasis_keyword){
        String getAccessToken = Jcode2SessionUtil.getAccessToken(APP_ID,APP_SECRET);
        String  access_token = GsonUtil.parseJsonWithGson(getAccessToken, AccessToken.class).getAccess_token();//接口调用凭证
        JSONObject params = new JSONObject();
        params.put("touser",touser);
        params.put("template_id",template_id);
        if (null != page && !"".equals(page)){
            params.put("page",page);
        }
        params.put("form_id",form_id);
        params.put("data",data);
        if (null != emphasis_keyword && !"".equals(emphasis_keyword)){
            params.put("emphasis_keyword",emphasis_keyword);
        }
        //发送请求
        return HttpUtil.sendPost(WeChatUrl.SEND_TEMPLATE_MESSAGE.getUrl() + "?access_token=" + access_token,params.toString());
    }

    /**
     * 发送订阅消息
     * @param touser            接收者（用户）的 openid
     * @param template_id       所需下发的模板消息id
     * @param page              点击模版卡片后跳转的页面，仅限本小程序内的页面。支持带参数，（eg：index?foo=bar）。该字段不填则模版无法跳转
     * @param data              模板内容，格式形如 { "key1": { "value": any }, "key2": { "value": any } }
     * @return                  返回String可转JSON
     */
    public static String sendSubscribeMessage( String touser, String template_id, String page, Map<String, String> data){
        String getAccessToken = Jcode2SessionUtil.getAccessToken(APP_ID,APP_SECRET);
        String  access_token = GsonUtil.parseJsonWithGson(getAccessToken, AccessToken.class).getAccess_token();//接口调用凭证
        JSONObject params = new JSONObject();
        params.put("touser",touser);
        params.put("template_id",template_id);
        if (null != page && !"".equals(page)){
            params.put("page",page);
        }
        params.put("data",data);
        //发送请求
        return HttpUtil.sendPost(WeChatUrl.SEND_SUBSCRIBE_MESSAGE.getUrl() + "?access_token=" + access_token,params.toString());
    }

    public static String sendSubscribeMessage( String touser, String template_id, String page, JSONObject  data){
        String getAccessToken = Jcode2SessionUtil.getAccessToken(APP_ID,APP_SECRET);
        String  access_token = GsonUtil.parseJsonWithGson(getAccessToken, AccessToken.class).getAccess_token();//接口调用凭证
        System.out.println("access_token="+access_token);

        JSONObject params = new JSONObject();
        params.put("touser",touser);
        params.put("template_id",template_id);
        if (null != page && !"".equals(page)){
            params.put("page",page);
        }
        params.put("data",data);
        //发送请求
        return HttpUtil.sendPost(WeChatUrl.SEND_SUBSCRIBE_MESSAGE.getUrl() + "?access_token=" + access_token,params.toString());
    }

    public static String sendSubscribeMessage( String touser, String template_id, String page, String data){
        String getAccessToken = Jcode2SessionUtil.getAccessToken(APP_ID,APP_SECRET);
        String  access_token = GsonUtil.parseJsonWithGson(getAccessToken, AccessToken.class).getAccess_token();//接口调用凭证
        JSONObject params = new JSONObject();
        params.put("touser",touser);
        params.put("template_id",template_id);
        if (null != page && !"".equals(page)){
            params.put("page",page);
        }
        params.put("data",data);
        //发送请求
        return HttpUtil.sendPost(WeChatUrl.SEND_SUBSCRIBE_MESSAGE.getUrl() + "?access_token=" + access_token,params.toString());
    }

}