package com.workplan.handler.aparment;

import com.workplan.bean.UserInfoBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.JwtConfig;
import com.workplan.handler.wx.jwtToken.JwtTokenBuilder;
import com.workplan.handler.wx.jwtToken.Token;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.handler.wx.jwtToken.manager.TokenManager;
import com.workplan.tools.Jcode2SessionUtil;
import com.workplan.tools.RandomStringUtil;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/wx")
public class WxLoginHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(WxLoginHandler.class);

    UserInfoBean userinfoBean = new UserInfoBean();
    List<UserInfoBean> userInfoList = new ArrayList<UserInfoBean>();


    @Autowired
    private JwtConfig jwtConfig;

    @Autowired
    private JwtTokenBuilder jwtTokenBuilder;

    @Autowired
    private TokenManager tokenManager;

    Jcode2SessionUtil jcode2SessionUtil = new Jcode2SessionUtil();

    /**
     * 登录-普通用户
     *
     * @param wxcode
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login/user", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage login(@RequestParam(value = "wxcode") String wxcode) throws Exception {
        Map stringMap = jcode2SessionUtil.OpenIdServlet(wxcode);
        logger.info(stringMap.toString());
        int code = Integer.parseInt(stringMap.get("code").toString());
        String userid = stringMap.get("userid").toString();
        String info = stringMap.get("info").toString();
        String openid = stringMap.get("openid").toString();

        switch (code) {
            case 1:
                return new ResultMessage(code, userid, info, openid);
            case 0:
                Map map = new HashMap();
                map.put("username", userid);
                String subject = JwtTokenBuilder.buildSubject(map);
                String accessToken = jwtTokenBuilder.buildToken(subject, jwtConfig.getExpiresSecond(), jwtConfig.getBase64Secret());
                //存储到redis
                tokenManager.createRelationship(userid, accessToken);
                //return ResultMessage.MessageToJson(code,message,accessToken);
                return new ResultMessage(code, userid, accessToken, openid);
            default:
                //return ResultMessage.MessageToJson(2,"错误：未知CODE");
                return new ResultMessage(1, userid, "错误：未知CODE", openid);
        }
    }

    /**
     * 生成一个临时工号给到用户
     *
     * @return
     */
    @RequestMapping(value = "/getTemporaryGenerationUserId", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage getTemporaryGenerationUserId() {
        return new ResultMessage(0, "LS" + RandomStringUtil.generateString(4, 4, 1));
    }

    /**
     * 微信小程序用户添加绑定
     *
     * @param user_id               用户工号
     * @param user_name             用户姓名
     * @param user_cardid           用户身份证号码
     * @param user_tel              用户手机号码
     * @param user_wechat_apartment 用户智能公寓的openid
     * @param user_main             用户所属大区
     * @param user_point            用户所属点部
     * @param user_sex              用户性别
     * @param date_entry            用户入职日期
     * @param user_type             用户岗位类型
     * @return
     */
    @RequestMapping(value = "/bindUserInfoByUserInputs", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage bindUserInfoByUser(@RequestParam String user_id, @RequestParam String user_name, @RequestParam String user_cardid, @RequestParam String user_tel,
                                            @RequestParam String user_wechat_apartment, @RequestParam String user_main, @RequestParam String user_point,
                                            @RequestParam int user_sex, @RequestParam String date_entry, @RequestParam String user_type) throws Exception {
        if(user_main.equals("")){
            user_main="571Y";
        }
        List<UserInfoBean> userInfoBeanList =userinfoDao.queryForInfoList(user_id);
        if(userInfoBeanList.size()!=0){
            return new ResultMessage(1, "此工号已绑定过微信");
        }
        user_point = user_point.toUpperCase();
        if (userinfoDao.insertNewUserBaseInfo(user_id, user_name, user_cardid, user_tel, user_wechat_apartment, user_main, user_point, user_sex, date_entry, user_type)) {
            return new ResultMessage(0, "绑定成功");
        } else {
            return new ResultMessage(1, "绑定失败");
        }
    }

    /**
     * 登录-管理员
     *
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/login/admin")
    @ResponseBody
    public ResultMessage loginadmin(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password) throws Exception {

        logger.info("username=" + username);
        logger.info("password=" + password);
        //用户名密码验证
        try {
            userInfoList = userinfoDao.queryForInfoList(username);
            if (userInfoList.size() != 0) {
                if (!userInfoList.get(0).getUser_password().equals(password)) {
                    return new ResultMessage(1, "账号或密码错误");//实际为密码错误，防止用户猜测故前端显示账号或密码错误
                    //return ResultMessage.MessageToJson(1,"账号或密码错误");//实际为密码错误，防止用户猜测故前端显示账号或密码错误
                }
                if (userInfoList.get(0).getSta() == 0) {
                    return new ResultMessage(1, "账号已被禁用");
                    //return ResultMessage.MessageToJson(1,"账号已被禁用");
                }
                Map map = new HashMap();
                map.put("username", userInfoList.get(0).getUser_name());
                String subject = JwtTokenBuilder.buildSubject(map);
                String accessToken = jwtTokenBuilder.buildToken(subject, jwtConfig.getExpiresSecond(), jwtConfig.getBase64Secret());
                //存储到redis
                tokenManager.createRelationship(username, accessToken);
                return new ResultMessage(0, username, accessToken, userInfoList.get(0).getUser_main());
                //return ResultMessage.MessageToJson(0,username,accessToken);
            } else {
                return new ResultMessage(1, "账号或密码错误");
                //return ResultMessage.MessageToJson(1,"账号或密码错误");//实际为账号错误，防止用户猜测故前端显示账号或密码错误
            }
        } catch (Exception e) {
            logger.info(e.getMessage());
            return new ResultMessage(1, "异常错误:" + e.getMessage());
        }

    }

    /**
     * 登录
     *
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Token login(@RequestParam(value = "username") String username, @RequestParam(value = "password") String password, @RequestParam(value = "captcha", required = false) String captcha) throws Exception {
        //验证码校验

        //用户名密码验证
        UserInfoBean user = userinfoDao.queryForInfoBean(username);

        if (user != null) {
            Map map = new HashMap();
            map.put("username", user.getUser_name());
            String subject = JwtTokenBuilder.buildSubject(map);

            String accessToken = jwtTokenBuilder.buildToken(subject, jwtConfig.getExpiresSecond(), jwtConfig.getBase64Secret());
            String refreshToken = jwtTokenBuilder.buildToken(subject, jwtConfig.getRefreshExpiresSecond(), jwtConfig.getRefreshBase64Secret());

            Token token = new Token();
            token.setAccess_token(accessToken);
            token.setRefresh_token(refreshToken);
            token.setToken_type("bearer");
            token.setExpires_in(jwtConfig.getExpiresSecond());

            //存储到redis
            tokenManager.createRelationship(username, accessToken);

            return token;
        } else {
            //throw new ApplicationException(SystemError.LOGIN_FAILED.getCode(), SystemError.LOGIN_FAILED.getMessage());
            return null;
        }
    }

    /**
     * 刷新token，获取新的token
     *
     * @param wxcode
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/refreshToken", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage refreshToken(String wxcode, String username, String password) throws Exception {
        if (wxcode != null && !wxcode.equals("")) {
            return login(wxcode);
        } else if (username != null && !username.equals("") && password != null && !password.equals("")) {
            return loginadmin(username, password);
        }
        return new ResultMessage(1, "提供的认证信息异常，获取新的令牌失败");
    }

    /**
     * 注销
     *
     * @return
     */
    public Integer logout(@RequestHeader(value = "Authorization") String token) {
        //TODO 操蛋的JWT不能从服务端destroy token， logout目前只能在客户端的cookie 或 localStorage/sessionStorage  remove token
        //TODO 准备用jwt生成永久的token，再结合redis来实现Logout。具体是把token的生命周期交给redis来管理，jwt只负责生成token

        try {
            //多端登录，会有多个同一用户名但token不一样的键值对在redis中存在，所以只能通过token删除
//        tokenManager.delRelationshipByKey(user.getUsername());
            tokenManager.delRelationshipByToken(token);//注销成功
            return 1;
        } catch (Exception e) {
            logger.info(e.getMessage());
            return -1;
        }
    }

    /**
     * 测试token验证
     *
     * @return
     */
    @Authorization
    @RequestMapping(value = "/test", method = RequestMethod.POST)
    @ResponseBody
    public String getuser() {
        logger.info("进来了");
        return ResultMessage.MessageToJson(0, "成功进入！");
    }


    /**
     * 获取人员和床位的入住率
     *
     * @return
     */
    @Authorization
    @RequestMapping(value = "/getUserAndBedCheckInCounts", method = RequestMethod.POST)
    @ResponseBody
    public String getUserAndBedCheckInCounts() {
        try {
            String retString = "{\"code\": 0,\"user\":[" +
                    "{\"series\":[{\"name\":\"已入住\",\"data\":" + userinfoDao.getUserCheckInCounts(false) + "},{\"name\":\"未入住\",\"data\":" + userinfoDao.getUserCheckInCounts(true) + "}]}]," +
                    "\"bed\":[" +
                    "{\"series\":[{\"name\":\"已入住\",\"data\":" + apartmentBedDao.getBedCheckInCounts(false) + "},{\"name\":\"未入住\",\"data\":" + apartmentBedDao.getBedCheckInCounts(true) + "}]}]}";
            return retString;

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"code\": 1,\"info\":\"获取数据异常：" + e.getMessage() + "\"}";

        }
    }
}
