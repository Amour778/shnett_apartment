package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentInfoBean;
import com.workplan.bean.apartment.SignInBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.GetDateTimeNow;
import com.workplan.tools.LocationUtils;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/wx")
public class SignInHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(SignInHandler.class);
    List<SignInBean> signInList = new ArrayList<SignInBean>();
    SignInBean signInBean = new SignInBean();


    /**
     * 通过用户工号，获取服务器日期和用户的签到数据
     * @param user_id
     * @return
     */
    @Authorization
    @RequestMapping(value = "/getDateAndSignInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getDateAndSignInfo(String user_id) {
        try {
            //获取当前年 //yyyy-MM-dd
            String sign_year = GetDateTimeNow.getDate().substring(0,4);
            //获取当前月
            String sign_month= GetDateTimeNow.getDate().substring(5,7);
            signInList=signInDao.querySignInInfoByUserIdAndYearAndMonth(user_id,sign_year,sign_month);
            logger.info("当前用户：" + user_id + ",在当前年：" + sign_year + ",当前月：" + sign_month+"，获取到的签到数据条数为："+signInList.size());
            if(signInList.size()==0){
                return "{\"code\":0,\"sign_year\":\""+sign_year+"\",\"sign_month\":\""+sign_month+"\",\"list\":[]}";
            }else{
                String s = "";
                for (int i = 0; i < signInList.size(); i++) {
                    s+="\""+signInList.get(i).getSign_day()+"\",";
                }
                s= ResultMessage.ListToFormSelectsStringSplit(s);
                return "{\"code\":0,\"sign_year\":\""+sign_year+"\",\"sign_month\":\""+sign_month+"\",\"list\":["+s+"]}";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultMessage.MessageToJson(1, "获取数据异常:" + e.getMessage());
        }
    }


    /**
     * 签到
     *
     * @param user_lat   纬度
     * @param user_lng  经度
     * @param user_id
     * @param sign_year
     * @param sign_month
     * @param sign_day
     * @return 经度longitude(- 180 ~ 180)|纬度latitude(-90~90)
     */
    @Authorization
    @RequestMapping(value = "/addSignInWithUserAndDate", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addSignInWithUserAndDate(double user_lat, double user_lng, String user_id, String sign_year, String sign_month, String sign_day) {
        try {
            String date_time= GetDateTimeNow.getDate();
            //获取当前年 //yyyy-MM-dd
            sign_year = date_time.substring(0,4);
            //获取当前月
            sign_month= date_time.substring(5,7);
            //获取当前日
            sign_day= date_time.substring(8,10);
            logger.info("当前年：" + sign_year+",当前月"+sign_month+",当前日="+sign_day);
            //通过用户工号获取用户所在的公寓经纬度
            List<ApartmentInfoBean> apartmentInfoBeanList = apartmentInfoDao.queryApartmentLocalAndUserIdMapper(user_id);
            logger.info("获取到用户所入住的公寓条数：" + apartmentInfoBeanList.size());
            if (apartmentInfoBeanList.size() == 0) {
                return ResultMessage.MessageToJson(1, "获取用户所在公寓数据失败");
            }else if(apartmentInfoBeanList.get(0).getApa_local() == null){
                return ResultMessage.MessageToJson(1, "获取用户入住公寓的位置信息失败");
            }
            String apa_local = apartmentInfoBeanList.get(0).getApa_local().replaceAll(" ","");
            String[] lat_lng = apa_local.split(",");
            logger.info("lat_lng：" + lat_lng + "，lat_lng.length=" + lat_lng.length);
            if (lat_lng.length == 0) {
                return ResultMessage.MessageToJson(1, "Split公寓位置信息异常");
            }else if(lat_lng[0].equals("") || lat_lng[1].equals("")){
                return ResultMessage.MessageToJson(1, "解析的公寓位置信息异常");
            }
            double Apa_lng = Double.parseDouble(lat_lng[0]);//经度longitude
            double Apa_lat = Double.parseDouble(lat_lng[1]);//纬度latitude
            logger.info("Apa_lng：" + Apa_lng + ",Apa_lat=" + Apa_lat);
            //通过经纬度判断用户距离公寓
            LocationUtils locationUtils = new LocationUtils();
            double distance = locationUtils.LantitudeLongitudeDist(user_lng,user_lat, Apa_lat,  Apa_lng);
            logger.info("公寓与用户的距离：" + distance+"米");
            double cha = 100;
            logger.info("相差距离" + sub(distance, cha));
            if (sub(distance, cha) > 0) {
                return ResultMessage.MessageToJson(1, "用户与公寓相距约" + String.format("%.0f", distance)+"米，距离过远不可签到");
            }
            if (signInDao.addSignIn(user_id, sign_year, sign_month, sign_day)) {
                return ResultMessage.MessageToJson(0, "签到成功");
            }else{
                return ResultMessage.MessageToJson(1, "签到失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResultMessage.MessageToJson(1, "签到失败:" + e.getMessage());
        }
    }

    /**
     * * 两个Double数相减 *
     *
     * @param v1 *
     * @param v2 *
     * @return Double
     */
    public static Double sub(Double v1, Double v2) {
        BigDecimal b1 = new BigDecimal(v1.toString());
        BigDecimal b2 = new BigDecimal(v2.toString());
        return new Double(b1.subtract(b2).doubleValue());
    }

}