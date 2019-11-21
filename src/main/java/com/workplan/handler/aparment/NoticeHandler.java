package com.workplan.handler.aparment;

import com.workplan.bean.apartment.ApartmentBedBean;
import com.workplan.bean.apartment.NoticeBean;
import com.workplan.dao.BaseDao;
import com.workplan.handler.wx.jwtToken.annotation.Authorization;
import com.workplan.tools.ResultMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/wx")
public class NoticeHandler implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(NoticeHandler.class);
    List<NoticeBean> noticeList = new ArrayList<NoticeBean>();
    NoticeBean noticeBean = new NoticeBean();

    /**
     * 搜索通知
     * @param page
     * @param limit
     * @return
     */
    @Authorization
    @RequestMapping(value = "/queryAllNoticeInfoByLimit")
    @ResponseBody
    public String queryAllNoticeInfoByLimit(int page, int limit) {
        try {
            noticeList = noticeDao.queryAllNoticeInfoByLimit(page, limit);
            int count = noticeDao.queryAllNoticeInfoCount();
            return ResultMessage.ListToLayuiTable(count,noticeList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.info(e.getMessage());
            return ResultMessage.ListToLayuiTableWithErr("获取数据失败："+e.getMessage());
        }
    }

}