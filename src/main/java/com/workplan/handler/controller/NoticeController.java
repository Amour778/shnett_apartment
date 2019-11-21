package com.workplan.handler.controller;

import com.workplan.bean.apartment.NoticeBean;
import com.workplan.dao.BaseDao;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class NoticeController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(NoticeController.class);
    List<NoticeBean> noticeList = new ArrayList<NoticeBean>();
    NoticeBean noticeBean = new NoticeBean();

    /**
     * 搜索通知
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value = "/queryAllNoticeInfoByLimit")
    @ResponseBody
    public String queryAllNoticeInfoByLimit(int page, int limit) {
        try {
            noticeList = noticeDao.queryAllNoticeInfoByLimit(page,limit);
            int count=noticeDao.queryAllNoticeInfoCount();
            return ResultMessage.ListToLayuiTable(count,noticeList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.ListToLayuiTableWithErr("获取数据错误:"+e.getMessage());
        }
    }

    /**
     * 添加新的通知
     * @param info
     * @return
     */
    @RequestMapping(value = "/addNewNotice")
    @ResponseBody
    public String addNewNotice(String info) {
        if(noticeDao.addApplyInfoToIn(info)){
            return ResultMessage.MessageToJson(0,"添加成功");
        }else{
            return ResultMessage.MessageToJson(1,"添加失败");
        }
    }

    /**
     * 删除通知
     * @param nid
     * @return
     */
    @RequestMapping(value = "/deleteNoticeInfoToIn")
    @ResponseBody
    public String deleteNoticeInfoToIn(int nid) {
        if(noticeDao.deleteNoticeInfoToIn(nid)){
            return ResultMessage.MessageToJson(0,"删除成功");
        }else{
            return ResultMessage.MessageToJson(1,"删除失败");
        }
    }



}