package com.workplan.dao;

import com.workplan.bean.UserInfoBean;
import com.workplan.tools.StringSubstringUtil;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserInfoDao{
    private JdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    String SQL = null;
    List<UserInfoBean> userinfoList = new ArrayList<UserInfoBean>();

    /**
     * 数据模板(所有数据)
     */

    class UserInfoAllInfoMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setPid(rs.getInt("pid"));
            info.setUser_id(rs.getString("user_id"));
            info.setUser_password(rs.getString("user_password"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_cardid(rs.getString("user_cardid"));
            info.setUser_tel(rs.getString("user_tel"));
            info.setUser_role(rs.getString("user_role"));
            info.setUser_wechat_apartment(rs.getString("user_wechat_apartment"));
            info.setUser_main(rs.getString("user_main"));
            info.setUser_point(rs.getString("user_point"));
            info.setCreate_date(rs.getString("create_date"));
            info.setSta(rs.getInt("sta"));
            info.setUser_sex(rs.getInt("user_sex"));
            info.setUser_integral(rs.getInt("user_integral"));
            info.setUser_bed(rs.getString("user_bed"));
            info.setDate_entry(rs.getString("date_entry"));
            info.setUser_type(rs.getInt("user_type"));
            return info;
        }
    }


    /**
     * 数据模板(排除密码)
     */

    class UserInfoExcludePasswordMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setPid(rs.getInt("pid"));
            info.setUser_id(rs.getString("user_id"));
            info.setUser_name(rs.getString("user_name"));
            info.setUser_cardid(rs.getString("user_cardid"));
            info.setUser_tel(rs.getString("user_tel"));
            info.setUser_role(rs.getString("user_role"));
            info.setUser_wechat_apartment(rs.getString("user_wechat_apartment"));
            info.setUser_main(rs.getString("user_main"));
            info.setUser_point(rs.getString("user_point"));
            info.setCreate_date(rs.getString("create_date"));
            info.setSta(rs.getInt("sta"));
            info.setUser_sex(rs.getInt("user_sex"));
            info.setUser_integral(rs.getInt("user_integral"));
            info.setUser_bed(rs.getString("user_bed"));
            info.setDate_entry(rs.getString("date_entry"));
            info.setUser_type(rs.getInt("user_type"));
            info.setUser_mail(rs.getString("user_mail"));
            return info;
        }
    }


    /**
     * 数据模板(用户工号 + 用户角色)
     */

    class UserInfoJustUserIdAndUserRoleMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_tel(rs.getString("user_tel"));
            return info;
        }
    }


    /**
     * 数据模板(用户工号 + 用户手机号 + 用户身份证号)
     */

    class UserInfoJustUserIdAndUserTelAndUserCardIdMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_cardid(rs.getString("user_cardid"));
            info.setUser_role(rs.getString("user_role"));
            return info;
        }
    }


    /**
     * 数据模板(用户工号 + 密码)
     */

    class UserInfoJustUserIdAndPasswordMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_password(rs.getString("user_password"));
            return info;
        }
    }


    /**
     * 数据模板(用户工号 + 智慧公寓OPENID)
     */

    class UserInfoJustUserIdAndWeChartApartmentMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_id(rs.getString("user_id"));
            info.setUser_wechat_apartment(rs.getString("user_wechat_apartment"));
            info.setSta(rs.getInt("sta"));
            return info;
        }
    }

    /**
     * 数据模板(用户发送申请审批的消息通知，从而获取用户角色为1001的人的 智慧公寓OPENID)
     */

    class UserInfoJustApartmentOpentIdMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_wechat_apartment(rs.getString("user_wechat_apartment"));
            return info;
        }
    }

    /**
     * 数据模板(用户申请时发送给户角色为1001的人邮件 智慧公寓OPENID)
     */

    class UserMailMapper implements RowMapper<UserInfoBean> {
        public UserInfoBean mapRow(ResultSet rs, int rowNum)
                throws SQLException {
            UserInfoBean info = new UserInfoBean();
            info.setUser_mail(rs.getString("user_mail"));
            return info;
        }
    }



    /**
     * 获取拥有某个角色的所有用户信息
     *
     * @param user_role
     * @return List<UserInfoBean>
     */

    public List<UserInfoBean> queryUserByUserRole(String user_role) {
        SQL = "SELECT * FROM userinfo WHERE FIND_IN_SET(?, user_role)";
        return jdbcTemplate.query(SQL, new Object[]{user_role}, new UserInfoJustUserIdAndUserRoleMapper());
    }


    /**
     * 用户发送申请审批的消息通知，从而获取用户角色为1001的人的 智慧公寓OPENID
     * @return
     */
    public List<UserInfoBean> queryApartmentOpentIdByUserRoleIsOneZeroZeroOne() {
        SQL = "SELECT user_wechat_apartment FROM userinfo WHERE user_role ='1001'";
        return jdbcTemplate.query(SQL,  new UserInfoJustApartmentOpentIdMapper());
    }

    /**
     * 用户发送申请审批的消息通知，从而获取用户角色为1001的人的 智慧公寓OPENID
     * @return
     */
    public List<UserInfoBean> queryUserMailByUserRoleIsOneZeroZeroOne() {
        SQL = "SELECT user_mail FROM userinfo WHERE user_role ='1001'";
        return jdbcTemplate.query(SQL,  new UserMailMapper());
    }
    /**
     * Layui表格：通过条件获取对应列表数据的总行数
     *
     * @param user_id
     * @return
     */

    public int queryUserInfoCountWithSearchConditionToLayui(String user_id, int sta) {
        if (user_id.equals("")) {
            SQL = "SELECT * FROM userinfo where sta = ?";
            userinfoList = jdbcTemplate.query(SQL, new Object[]{sta}, new UserInfoExcludePasswordMapper());
        } else {
            SQL = "SELECT * FROM userinfo  WHERE (user_id = ? OR user_name like '%" + user_id + "%') and sta = ?";
            userinfoList = jdbcTemplate.query(SQL, new Object[]{user_id, sta}, new UserInfoExcludePasswordMapper());
        }
        return userinfoList.size();
    }


    /**
     * Layui表格：通过条件获取对应列表数据
     * @param user_id
     * @param sta
     * @param page
     * @param limit
     * @return
     */
    public List<UserInfoBean> queryUserInfoWithSearchConditionToLayui(String user_id, int sta, int page, int limit) {
        if (user_id.equals("") && user_id != null) {
            SQL = "SELECT * FROM userinfo where sta = ? limit ? , ?";
            userinfoList= jdbcTemplate.query(SQL, new Object[]{sta, (page - 1) * limit, limit}, new UserInfoExcludePasswordMapper());
        } else {
            SQL = "SELECT * FROM userinfo  WHERE (user_id = ? OR user_name like '%" + user_id + "%') and sta = ? limit ? , ?";
            userinfoList=jdbcTemplate.query(SQL, new Object[]{user_id, sta, (page - 1) * limit, limit}, new UserInfoExcludePasswordMapper());
        }
        return userinfoList;
    }



    /**
     * 通过user_id获取单个用户的详细信息
     *
     * @param user_id
     * @return
     * @throws Exception
     */

    public UserInfoBean queryForInfoBean(String user_id) throws Exception {
        String sql = "select * from userinfo where user_id = ?";
        System.out.println(sql);
        UserInfoBean userInfoBean = jdbcTemplate.queryForObject(sql,
                new Object[]{user_id}, new UserInfoAllInfoMapper());
        return userInfoBean;
    }
    /**
     * 通过user_id获取单个用户的详细信息
     *
     * @param user_id
     * @return
     * @throws Exception
     */

    public List<UserInfoBean> queryForInfoList(String user_id) throws Exception {
        String sql = "select * from userinfo where user_id = ?";
        System.out.println(sql);
        userinfoList = jdbcTemplate.query(sql,new Object[]{user_id}, new UserInfoAllInfoMapper());
        return userinfoList;
    }

    /**
     * 根据 微信小程序OPENID 获取符合条件的用户信息，状态判断放在返回结果之后
     *
     * @param OPENID
     * @return
     */

    public List<UserInfoBean> querySimpleUserSimpleInfoByOPENID(String OPENID) {
        SQL = "select * from userinfo where user_wechat_apartment = ?";
        return jdbcTemplate.query(SQL, new Object[]{OPENID},
                new UserInfoJustUserIdAndWeChartApartmentMapper());
    }

    /**
     * 修改用户某个信息
     *
     * @param column_names
     * @param column_value
     * @param user_id
     * @return
     */

    public boolean changeUserInfoByColumnNames(String column_names, String column_value, String user_id) {
        SQL = "UPDATE userinfo set " + column_names + "=? where user_id = ? ";
        return jdbcTemplate.update(SQL, new Object[]{column_value, user_id}) == 1;
    }


    /**
     * 修改用户工号
     *
     * @param user_id
     * @param pid
     * @return
     */

    public boolean changeUserIdByPid(String user_id, int pid) {
        SQL = "UPDATE userinfo set user_id= ? where pid = ? ";
        return jdbcTemplate.update(SQL, new Object[]{user_id, pid}) == 1;
    }



    /**
     * 添加新用户基础信息:微信小程序
     *
     * @param user_id               用户工号
     * @param user_name             用户姓名
     * @param user_cardid           身份证号
     * @param user_tel              手机号码
     * @param user_wechat_apartment 微信OPENID
     * @param user_main             所属大区
     * @param user_point            所属网点
     * @param user_sex              用户性别：0女性，1男性
     * @param date_entry            入职日期
     * @param user_type             新工类型：0社招，1实习生
     * @return
     */
    public boolean insertNewUserBaseInfo(String user_id, String user_name, String user_cardid, String user_tel, String user_wechat_apartment, String user_main, String user_point, int user_sex, String date_entry, String user_type) {
        SQL = "INSERT INTO userinfo (user_id,user_name,user_cardid,user_tel,user_wechat_apartment,user_main,user_point,user_sex,date_entry,user_type)VALUES(?,?,?,?,?,?,?,?,?,?)";
        return jdbcTemplate.update(SQL, new Object[]{user_id, user_name, user_cardid, user_tel, user_wechat_apartment, user_main, user_point, user_sex, date_entry, user_type}) == 1;
    }

    /**
     * 获取入住和未入住人员的个数
     * @return
     */
    public int getUserCheckInCounts(Boolean isnull) {
        if(isnull)
            SQL = "SELECT * FROM userinfo WHERE user_bed IS NULL OR user_bed =''";
        else
            SQL = "SELECT * FROM userinfo WHERE user_bed IS NOT NULL AND user_bed !=''" ;

        return jdbcTemplate.query(SQL,new UserInfoJustUserIdAndWeChartApartmentMapper()).size();
    }

}