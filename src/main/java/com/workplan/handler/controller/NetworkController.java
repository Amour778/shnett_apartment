package com.workplan.handler.controller;

import com.workplan.bean.apartment.NetworkBean;
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
public class NetworkController implements BaseDao {
    private static Logger logger = LoggerFactory.getLogger(NetworkController.class);
    List<NetworkBean> networkList = new ArrayList<NetworkBean>();
    NetworkBean networkBean = new NetworkBean();

    /**
     * 新增网点信息
     *
     * @param mainId
     * @param main_name
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addNetworkMainInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addNetworkMainInfo(String mainId, String main_name) throws Exception {
		mainId = mainId.replaceAll(" ","").toUpperCase();
        logger.info(mainId);
        logger.info(main_name);
        networkList= networkDao.queryAllNetworkMainInfo(mainId);
        if (networkList.size() != 0) {
            return ResultMessage.MessageToJson(1,"区部ID已存在");
        }
        if (networkDao.addNetworkMainInfo(mainId, main_name)) {
            return  ResultMessage.MessageToJson(0, "区部信息添加成功");
        } else {
            return  ResultMessage.MessageToJson(1, "区部信息添加失败");
        }
    }

    /**
     * 新增点部信息
     *
     * @param mainId
     * @param pointId
     * @param point_name
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addNetworkPointInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String addNetworkPointInfo(String mainId,
                                             String pointId,
                                             String point_name) throws Exception {
        mainId = mainId.replaceAll(" ","").toUpperCase();
        pointId = pointId.replaceAll(" ","").toUpperCase();
        networkList = networkDao.queryNetworkPointInfoByMainId(mainId,pointId);
        if (networkList.size() != 0) {
            return ResultMessage.MessageToJson(1, "点部ID已存在");
        }
        if (networkDao.addNetworkPointInfo(mainId, pointId, point_name)) {
            return ResultMessage.MessageToJson(0, "点部信息添加成功");
        } else {
            return ResultMessage.MessageToJson(1, "点部信息添加失败");
        }
    }

    /**
     * 删除区部信息，将同时删除点部信息、对应的用户。考虑到如果删除了用户，床位需要置空的情况，故此方法前端暂未使用
     *
     * @param mainId
     * @return
     */
    @RequestMapping(value = "/deleteNetworkMainInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteNetworkMainInfo(String mainId) {
        try {
            networkDao.deleteNetworkMainAndPointInfoByMainId(mainId);
            return ResultMessage.MessageToJson(0, "区部信息删除成功");
        } catch (Exception e) {
            return ResultMessage.MessageToJson(1, "区部信息删除失败");
        }
    }

    /**
     * 删除点部信息，将同时删除对应的用户。考虑到如果删除了用户，床位需要置空的情况，故此方法前端暂未使用
     *
     * @param pointId
     * @return
     */
    @RequestMapping(value = "/deleteNetworkPointInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteNetworkPointInfo(String pointId) {
        try {
            networkDao.deleteNetworkMainAndPointInfoByMainId(pointId);
            return ResultMessage.MessageToJson(0, "点部信息删除成功");
        } catch (Exception e) {
            return ResultMessage.MessageToJson(1, "点部信息删除失败");
        }
    }

    /**
     * 删除区部信息，同时删除点部信息，但是不会删除用户信息
     * @param mainId
     * @return
     */
    @RequestMapping(value = "/deleteNetworkMainInfoNotWithUserInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteNetworkMainInfoNotWithUserInfo(String mainId) {
        try {
            networkDao.deleteNetworkMainInfoNotWithUserInfo(mainId);
            return ResultMessage.MessageToJson(0, "区部信息删除成功");
        } catch (Exception e) {
            return ResultMessage.MessageToJson(1, "区部信息删除失败");
        }
    }
    /**
     * 删除点部信息，但是不会删除用户信息
     * @param pointId
     * @return
     */
    @RequestMapping(value = "/deleteNetworkPointInfoNotWithOtherInfo", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String deleteNetworkPointInfoNotWithOtherInfo(String pointId) {
        try {
            networkDao.deleteNetworkPointInfoNotWithOtherInfo(pointId);
            return ResultMessage.MessageToJson(0, "点部信息删除成功");
        } catch (Exception e) {
            return ResultMessage.MessageToJson(1, "点部信息删除失败");
        }
    }



    /**
     * 获取所有区部
     *
     * @return
     */
    @RequestMapping(value = "/getAllNetworkMainInfoToFormSelect", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllNetworkMainInfoToFormSelect() {
        networkList = networkDao.queryAllNetworkMainInfo();
        String reString = "";
        for (int a = 0; a < networkList.size(); a++) {
            reString += "{\"name\": \"" + networkList.get(a).getMainId() + "-" + networkList.get(a).getMain_name() + "\", \"value\": \"" + networkList.get(a).getMainId() + "\"},";
        }
        return ResultMessage.ListToFormSelects(reString);
    }


    /**
     * 获取所有区部
     *
     * @return
     */
    @RequestMapping(value = "/getAllNetworkMainInfoToLayuiList", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllNetworkMainInfoToLayuiList(String input,int page,int limit) {
        if(input.equals("")){
            input=null;
        }
        networkList = networkDao.getAllNetworkMainInfoToLayuiList(input,page,limit);
        int count = networkDao.getAllNetworkMainInfoToLayuiList(input);
        return ResultMessage.ListToLayuiTable(count,networkList);
    }
    /**
     * 获取所有点部
     *
     * @return
     */
    @RequestMapping(value = "/getAllNetworkpointInfoToLayuiList", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getAllNetworkpointInfoToLayuiList(String mainId,String input,int page,int limit) {
        if(input.equals("")){
            input=null;
        }
        networkList = networkDao.getAllNetworkpointInfoToLayuiList(mainId,input,page,limit);
        int count = networkDao.getAllNetworkpointInfoToLayuiList(mainId,input);
        return ResultMessage.ListToLayuiTable(count,networkList);
    }

    /**
     * 通过mainId获取点部信息
     *
     * @param mainId
     * @return
     */
    @RequestMapping(value = "/getNetworkPointInfoByMainId", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public String getNetworkPointInfoByMainId(String mainId) {
        networkList = networkDao.queryNetworkPointInfoByMainId(mainId);
        String reString = "";
        for (int a = 0; a < networkList.size(); a++) {
            reString += "{\"name\": \"" + networkList.get(a).getMainId() + "-" + networkList.get(a).getMain_name() + "\", \"value\": \"" + networkList.get(a).getMainId() + "\"},";
        }
        return ResultMessage.ListToFormSelects(reString);
    }

	/**
	 * 通过mainId更新区部名称
	 * @param mainId
	 * @param main_name
	 * @return
	 */
	@RequestMapping(value = "/updateNetworkMainName", produces = "text/html;charset=UTF-8")
	@ResponseBody
    public String updateNetworkMainName(String mainId, String main_name) {
        if (networkDao.updateNetworkMainInfo(mainId, main_name)) {
            return ResultMessage.MessageToJson(0, "更新信息成功");
        } else {
            return ResultMessage.MessageToJson(1, "更新信息失败");
        }
    }

    /**
     * 根据pointId修改点部信息
     *
     * @param pointId
     * @param point_name
     * @return
     */
	@RequestMapping(value = "/updateNetworkPointInfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
    public String updateNetworkPointInfo(String pointId, String point_name) {
        if (networkDao.updateNetworkPointInfo( pointId,  point_name)) {
            return ResultMessage.MessageToJson(0, "更新信息成功");
        }else{
            return ResultMessage.MessageToJson(1, "更新信息失败");
        }
    }

}
