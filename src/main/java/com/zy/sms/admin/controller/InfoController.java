package com.zy.sms.admin.controller;

import com.zy.sms.Constant;
import com.zy.sms.admin.entity.InfoEntity;
import com.zy.sms.admin.service.InfoService;
import com.zy.sms.base.controller.BaseController;
import com.zy.sms.util.QueryHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/info")
public class InfoController extends BaseController {

    @Autowired
    private InfoService infoService;

    //列表页面
    @RequestMapping("/infoListUI.do")
    public ModelAndView listUI(HttpServletRequest request) throws Exception{
        ModelAndView model=new ModelAndView("admin/info/infoListUI");
        //查询
        QueryHelper queryHelper = new QueryHelper(InfoEntity.class, "i");
        try {
            String infoTitle=request.getParameter("infoTitle");
            if(!StringUtils.isEmpty(infoTitle)) {
                queryHelper.addCondition("i.title like ?0", "%" + infoTitle + "%");
            }
            //根据创建时间降序排序
            queryHelper.addOrderByProperty("i.createTime", QueryHelper.ORDER_BY_DESC);
            String page=request.getParameter("page"); //页数跳转
            if (!org.springframework.util.StringUtils.isEmpty(page)){
                int curreentPage=Integer.parseInt(page);
                pageResult=infoService.getPageResult(queryHelper,curreentPage,getPageSize());
            }else {
                pageResult = infoService.getPageResult(queryHelper, getCurrentPage(), getPageSize());
            }
            model.addObject("pageResult",pageResult);
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
        return model;
    }

    //跳转到新增页面
    @RequestMapping("/addInfoUI.do")
    public ModelAndView addUI(){
        //加载分类集合
        ModelAndView model=new ModelAndView("admin/info/addInfoUI");
        //设置日期
        Timestamp timestamp=new Timestamp(new Date().getTime());
        model.addObject("time",timestamp);

        model.addObject("infoTypeMap", InfoEntity.INFO_TYPE_MAP);
        return model;
    }

    //保存新增
    @ResponseBody
    @RequestMapping("/saveInfo.do")
    public Map<String, String> add(InfoEntity info) throws Exception{
        Map<String,String> map=new HashMap<String, String>();
        boolean title=(!"".equals(info.getTitle()));
        boolean conment=(!"".equals(info.getContent()));
        if(title && conment){
            infoService.save(info);
            map.put("msg","success");
            map.put("tip",Constant.publicInfoSuccess);
        }else {
            map.put("msg","failure");
            map.put("tip",Constant.publicInfoFailure);
        }
        return map;
    }

    //跳转到编辑页面
    @RequestMapping("/editInfoUI.do")
    public ModelAndView editUI(InfoEntity info){
        //加载分类集合
        ModelAndView model=new ModelAndView("admin/info/editInfoUI");
        model.addObject("infoTypeMap", InfoEntity.INFO_TYPE_MAP);;
        if (info != null && info.getInfoId() != null) {
            //解决查询条件覆盖的问题
            info = infoService.findObjectById(info.getInfoId());
            model.addObject("info",info);
        }
        return model;
    }

    //保存编辑
    @RequestMapping("/saveEditInfo.do")
    public @ResponseBody Map<String,String> saveEditInfo(InfoEntity info) throws Exception{
        Map<String,String> map=new HashMap<String, String>();
        boolean title=(info.getTitle()!=null);
        boolean conment=(info.getContent()!=null);
        if(title && conment){
            infoService.update(info);
            map.put("msg","success");
            map.put("tip",Constant.infoEditSuccess);
        }else{
            map.put("msg","failure");
            map.put("tip",Constant.infoEditFailure);
        }
        return map;
    }

    //删除
    @ResponseBody
    @RequestMapping("/deleteInfo.do")
    public Map delete(HttpServletRequest request) throws Exception{
        Map<String,String> map=new HashMap<String,String>();
        String infoId=request.getParameter("infoId");
        if(!StringUtils.isEmpty(infoId)){
            infoService.delete(infoId);
            map.put("tip","success");
            map.put("msg",Constant.deleteInfoSuccess);
        }else{
            map.put("tip","failure");
            map.put("msg", Constant.deleteInfoFailure);
        }
        return map;
    }

    //批量删除
    @ResponseBody
    @RequestMapping("/deleteSelectedInfo.do")
    public Map<String, String> deleteSelected(@RequestParam(value = "infoIds[]")String selectedRow[]){
        Map<String,String> map=new HashMap<String, String>();
        if(selectedRow != null){
            for(String id: selectedRow){
                infoService.delete(id);
            }
            map.put("tip","success");
            map.put("msg",Constant.deleteInfoSuccess);
        }else{
            map.put("tip","failure");
            map.put("msg",Constant.deleteInfoFailure);
        }
        return map;
    }

    //异步发布信息
    @ResponseBody
    @RequestMapping("/publicInfo.do")
    public Map publicInfo(InfoEntity info){
        Map<String,String> map=new HashMap<String,String>();
        try {
            if(info != null){
                //更新信息状态
                InfoEntity tem = infoService.findObjectById(info.getInfoId());
                String state=info.getState();
                tem.setState(state);
                infoService.update(tem);
                map.put("msg","success");
                if (InfoEntity.INFO_STATE_PUBLIC.equals(state)) {
                    map.put("tip",Constant.publicInfoSuccess);
                }else{
                    map.put("tip",Constant.stopInfoSuccess);
                }
                return map;
            }
            else{
                map.put("msg","failure");
                map.put("tip",Constant.operationInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}