package com.workplan.handler;

import com.workplan.bean.PermissionBean;
import com.workplan.bean.RoleBean;
import com.workplan.bean.UserInfoBean;
import com.workplan.dao.BaseDao;
import com.workplan.tools.ResultMessage;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;


@Controller
public class UserInfoHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(UserInfoHandler.class);

    private List<UserInfoBean> userinfoList = new ArrayList<UserInfoBean>();

    /**
     * 登陆-WEB端
     *
     * @param username
     * @param password
     * @param validateCode
     * @param request
     * @return
     */
    @RequestMapping(value = "/tologin", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String toLogin(@RequestParam("username") String username,
                          @RequestParam("password") String password,
                          @RequestParam("validateCode") String validateCode,
                          HttpServletRequest request) {
        HttpSession session = request.getSession();
        String validateCodeInSession = (String) session.getAttribute("VALIDATE_CODE");
        if (!(validateCode.equalsIgnoreCase(validateCodeInSession))) {
            return ResultMessage.MessageToJson(1, "验证码错误");
        } else {
            // 1.创建Subject
            Subject subject = SecurityUtils.getSubject();
            // 2.创建用户登录凭证
            UsernamePasswordToken token = new UsernamePasswordToken(username, password);
            token.setRememberMe(false);
            // 3.登录，如果登录失败会抛出不同的异常，根据异常输出失败原因
            try {
                subject.login(token);
                // 6.判断是否成功登录
                if (null != subject) {
                    Session ses = subject.getSession();
                    ses.setTimeout(1000 * 60 * 60 * 2);
                    //logger.info("修改Session超时时间为[" + ses.getTimeout() + "]毫秒");
                    ses.setAttribute("SESSION_USERNAME", subject.getPrincipals());
                     /*LoginLogHandler loginLog = new LoginLogHandler();
                    String user_id = username;
                    String ip_address = null;
                    //获取用户IP地址
                   try {
                        ip_address = InetAddress.getLocalHost().getHostAddress().toString();
                        logger.info("ip_address=" + ip_address);
                    } catch (UnknownHostException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    loginLog.addLoginLog(user_id, ip_address);*/
                }
                //验证是否登录成功
                if (!subject.isAuthenticated()) {
                    token.clear();
                }
                return ResultMessage.MessageToJson(0, "登录成功");

            } catch (IncorrectCredentialsException e) {
                logger.info("登录密码错误. Password for account " + token.getPrincipal() + " was incorrect.");
                return ResultMessage.MessageToJson(1, "登录密码错误");
            } catch (ExcessiveAttemptsException e) {
                logger.info("登录失败次数过多");
                return ResultMessage.MessageToJson(1, "登录失败次数过多");
            } catch (LockedAccountException e) {
                logger.info("帐号已被锁定. The account for username " + token.getPrincipal() + " was locked.");
                return ResultMessage.MessageToJson(1, "帐号已被锁定");
            } catch (DisabledAccountException e) {
                logger.info("帐号已被禁用. The account for username " + token.getPrincipal() + " was disabled.");
                return ResultMessage.MessageToJson(1, "帐号已被禁用");
            } catch (ExpiredCredentialsException e) {
                logger.info("帐号已过期. the account for username " + token.getPrincipal() + "  was expired.");
                return ResultMessage.MessageToJson(1, "帐号已过期");
            } catch (UnknownAccountException e) {
                logger.info("帐号不存在. There is no user with username of " + token.getPrincipal());
                return ResultMessage.MessageToJson(1, "帐号不存在");
            } catch (UnauthorizedException e) {
                logger.info("您没有得到相应的授权！" + e.getMessage());
                return ResultMessage.MessageToJson(1, "您没有得到相应的授权");
            }
        }
    }

    /**
     * 获取用户信息
     *
     * @param user_id
     * @param sta
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/get_user", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String queryUserInfoBySearchCondition(String user_id, int sta, int page, int limit) {
        userinfoList = userinfoDao.queryUserInfoWithSearchConditionToLayui(user_id, sta, page, limit);
        int Counts = userinfoDao.queryUserInfoCountWithSearchConditionToLayui(user_id, sta);
        return ResultMessage.ListToLayuiTable(Counts, userinfoList);
    }


    /**
     * 通过用户工号获取用户角色列表:List<String>
     *
     * @param user_id
     * @return
     */
    public List<String> getPermissionListByUserId(String user_id) {
        List<String> roleBean = getRoleListByUserId("id", user_id);
        String perString = "";
        for (String role : roleBean) {
            perString += role + ",";
        }
        List<String> permissions_List = new ArrayList<String>();
        if (perString.substring(perString.length() - 1, perString.length()).equals(","))
            perString = perString.substring(0, perString.length() - 1);
        List<PermissionBean> permissionBean = null;
        try {
            permissionBean = permissionDao.queryInfoListByMenuIds(perString);
        } catch (Exception e) {
            e.printStackTrace();
        }
        for (PermissionBean permission : permissionBean) {
            permissions_List.add(permission.getUrl());
        }
        return permissions_List;
    }

    /**
     * 通过用户工号获取用户角色名称/ID列表:List<String>
     *
     * @param role_type
     * @param user_id
     * @return
     */
    public List<String> getRoleListByUserId(String role_type, String user_id) {
        List<String> roles_List = new ArrayList<String>();
        UserInfoBean userinfoBean = null;
        try {
            userinfoBean = userinfoDao.queryForInfoBean(user_id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (userinfoBean != null) {
            List<RoleBean> roleBean = null;
            try {
                roleBean = roleDao.queryForFatherInfoListByRoleIds(userinfoBean.getUser_role());
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (role_type.equals("name")) {
                for (RoleBean role : roleBean) {
                    roles_List.add(role.getRole_nickname());
                }
            } else if (role_type.equals("id")) {
                for (RoleBean role : roleBean) {
                    roles_List.add(role.getRole_id());
                }
            }
        }
        return roles_List;
    }


    /**
     * 通过用户ID更新用户工号
     * @param user_id
     * @param pid
     * @return
     */
    @RequestMapping(value = "/changeUserIdByPid", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String changeUserIdByPid(String user_id, int pid) {
        if(userinfoDao.changeUserIdByPid(user_id, pid)){
            return ResultMessage.MessageToJson(0,"更新成功");
        }else{
            return ResultMessage.MessageToJson(0,"更新失败");
        }

    }

    /**
     * 通过列名和工号修改列名的值
     * @param column_names
     * @param column_value
     * @param user_id
     * @return
     */
    @RequestMapping(value = "/changeUserInfoByColumnNames", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String changeUserInfoByColumnNames(String column_names, String column_value, String user_id) {
        if(userinfoDao.changeUserInfoByColumnNames(column_names,column_value,user_id)){
            return ResultMessage.MessageToJson(0,"更新成功");
        }else{
            return ResultMessage.MessageToJson(0,"更新失败");
        }

    }



}
