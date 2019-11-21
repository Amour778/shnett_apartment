package com.workplan.dao;

import com.workplan.dao.apartment.*;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public interface BaseDao {

    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    UserInfoDao userinfoDao = (UserInfoDao) context.getBean("UserInfoDao");
    RoleDao roleDao = (RoleDao) context.getBean("RoleDao");
    PermissionDao permissionDao = (PermissionDao) context.getBean("PermissionDao");
    MenuDao menuDao = (MenuDao) context.getBean("MenuDao");
    LoginLogDao loginLogDao = (LoginLogDao) context.getBean("LoginLogDao");
    MailDao mailDao = (MailDao) context.getBean("MailDao");
    NetworkDao networkDao = (NetworkDao) context.getBean("NetworkDao");


    ApartmentApplyDao apartmentApplyDao = (ApartmentApplyDao) context.getBean("ApartmentApplyDao");
    ApartmentInfoDao apartmentInfoDao = (ApartmentInfoDao) context.getBean("ApartmentInfoDao");
    ApartmentRoomDao apartmentRoomDao = (ApartmentRoomDao) context.getBean("ApartmentRoomDao");
    ApartmentBedDao apartmentBedDao = (ApartmentBedDao) context.getBean("ApartmentBedDao");
    NoticeDao noticeDao = (NoticeDao) context.getBean("NoticeDao");
    ScoreDao scoreDao = (ScoreDao) context.getBean("ScoreDao");
    SignInDao signInDao = (SignInDao) context.getBean("SignInDao");
}
