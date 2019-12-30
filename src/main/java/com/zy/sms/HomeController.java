package com.zy.sms;

import com.zy.sms.admin.entity.ComplainEntity;
import com.zy.sms.admin.entity.ComplainReplyEntity;
import com.zy.sms.admin.entity.InfoEntity;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.service.ComplainService;
import com.zy.sms.admin.service.InfoService;
import com.zy.sms.admin.service.UserService;
import com.zy.sms.base.controller.BaseController;
import com.zy.sms.util.QueryHelper;
import org.apache.poi.util.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.*;


@Controller
@RequestMapping("/home")
public class HomeController extends BaseController {


    @Autowired
    private InfoService infoService;
    @Autowired
    private UserService userService;
    @Autowired
    private ComplainService complainService;

    @RequestMapping("/showComplainAndInfo.do")
    public String showComplainAndInfo(HttpServletRequest request){
        //1.加载我的投诉
        UserEntity user = (UserEntity) request.getSession().getAttribute(Constant.USER);
        QueryHelper queryHelper2 = new QueryHelper(ComplainEntity.class, "c");
        queryHelper2.addCondition("c.compName = ?0", user.getName());
        //根据投诉时间升序排序
        queryHelper2.addOrderByProperty("c.compTime", QueryHelper.ORDER_BY_ASC);
        //根据投诉状态降序排序
        queryHelper2.addOrderByProperty("c.state", QueryHelper.ORDER_BY_DESC);
        List<ComplainEntity> complainList = complainService.getPageResult(queryHelper2,
                DEFAULT_CURRENT_PAGE, DEFAULT_PAGE_SIZE).getItems();
        request.setAttribute("complainList",complainList);

        //2.加载所发布的信息
        QueryHelper queryHelper1 = new QueryHelper(InfoEntity.class, "i");
        //根据时间的降序排序
        queryHelper1.addOrderByProperty("i.createTime", QueryHelper.ORDER_BY_DESC);
        List<InfoEntity> infoList = infoService.getPageResult(queryHelper1,
                DEFAULT_CURRENT_PAGE, DEFAULT_PAGE_SIZE).getItems();
        request.setAttribute("infoList",infoList);

        return "home/home";
    }

    //查看信息
    @RequestMapping("/searchInfoUI.do")
    public String infoViewUI(HttpServletRequest request){
        //加载分类集合
        String id= (String) request.getParameter("infoId");
        if(!StringUtils.isEmpty(id)){
            InfoEntity info = infoService.findObjectById(id);
            request.getSession().setAttribute("info",info);
        }
        return "home/infoViewUI";
    }

    //查看投诉信息
    @RequestMapping(value = "/searchComplainUI.do",method = RequestMethod.GET)
    public String complainViewUI(HttpServletRequest request){
        String id= request.getParameter("compId");
        if (!StringUtils.isEmpty(id)) {
            ComplainEntity complainEntity = complainService.findObjectById(id);
            //获取投诉的类型
            String state=complainEntity.getState();
            Map<String,String> typeMap=ComplainEntity.COMPLAIN_STATE_MAP;
            String type="";
            switch (state){
                case "0":
                    type=typeMap.get(state);
                    break;
                case "1":
                    type=typeMap.get(state);
                    break;
                case "2":
                    type=typeMap.get(state);
                    break;
            }
            request.getSession().setAttribute("type",type);
            //是否匿名
            String isNm="1".equals(complainEntity.getIsNm())? "匿名":"不匿名";
            request.getSession().setAttribute("isNM",isNm);
            //投诉的实体
            request.getSession().setAttribute("complain", complainEntity);
            //投诉的回复
            Set<ComplainReplyEntity> complainReplies=complainEntity.getComplainReplies();
            request.setAttribute("complainReplies",complainReplies);
        }
        return "home/complainViewUI";
    }

    //跳转到增加投诉界面
    @RequestMapping("/addComplainUI.do")
    public String complainAddUI(){
        return "home/complainAddUI";
    }


    //获取投诉投诉人的信息
    @ResponseBody
    @RequestMapping("/getUserInfo.do")
    public Map getUserInfo(String deptName){
        Map userMap=new HashMap();
        try {
            //获取所要投诉的部门
            if(!StringUtils.isEmpty(deptName)){
                //查找
                QueryHelper queryHelper = new QueryHelper(UserEntity.class, "u");
                queryHelper.addCondition("u.deptName like ?0", "%" +deptName+"%");
                userMap.put("Msg","success");
                userMap.put("userList", userService.findObjects(queryHelper));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userMap;
    }

    //保存投诉
    @ResponseBody
    @RequestMapping("/saveComplain.do")
    public Map<String,String> complainAdd(ComplainEntity comp,HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        try {
            UserEntity user= (UserEntity) request.getSession().getAttribute(Constant.USER);
            if(comp != null){
                //设置投诉者的信息
                comp.setCompMoblie(user.getMobile());
                comp.setCompDept(user.getDeptName());
                comp.setCompName(user.getName());
                //设置默写投诉状态为 待受理
                comp.setState(ComplainEntity.COMPLAIN_STATE_UNDONE);
                comp.setCompTime(new Timestamp(new Date().getTime()));
                complainService.save(comp);
                //告诉用户投诉成功！
                map.put("msg","success");
                return map;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        map.put("msg","error");
        return map;
    }

    //首页
    @RequestMapping("/homeUI.do")
    public String homeUI(){
        return "redirect:/home/showComplainAndInfo.do";
    }

    //提示界面
    @RequestMapping("/noPermissionUI.do")
    public String noPermissionUI(){
        return "common/noPermissionUI";
    }

    //编辑用户的信息
    @RequestMapping("/editUserInfoUI.do")
    public String editUserInfoUI(HttpServletRequest request){
        String userId=request.getParameter("userId");
        UserEntity userEntity=userService.findObjectById(userId);
        if (userEntity!=null){
            request.setAttribute("user",userEntity);
        }
        return "home/editUserInfoUI";
    }

    //保存用户编辑
    @RequestMapping("/saveEditUserInfo")
    public String saveEditUserInfo(@RequestParam("userHeadImg") MultipartFile headImg,
                                   UserEntity userEntity, HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        if (!StringUtils.isEmpty(userEntity.getId())){
            if (saveHeadImg(userEntity,headImg,request)) {
                UserEntity user=userService.findObjectById(userEntity.getId());
                //替换
                if(!StringUtils.isEmpty(userEntity.getBrithday())) {
                    user.setBrithday(userEntity.getBrithday());
                }else {
                    user.setBrithday(null);
                }
                if (!StringUtils.isEmpty(userEntity.getHeadImg())) {
                    user.setHeadImg(userEntity.getHeadImg());
                }
                if (!StringUtils.isEmpty(userEntity))
                    user.setMobile(user.getMobile());
                user.setEmail(userEntity.getEmail());
                //更新
                userService.update(user);
                request.setAttribute("msg","编辑成功");
                request.setAttribute("user",user);
                request.getSession().setAttribute(Constant.USER,user);
            }
        }else {
            request.setAttribute("user",userService.findUserAndRoleByUserId(userEntity.getId()));
            request.setAttribute("msg", "编辑失败");
        }
        return "home/editUserInfoUI";
    }

    //保存用户头像
    private  boolean saveHeadImg(UserEntity user, MultipartFile headImg, HttpServletRequest request){
        if(user!=null){
            if(headImg!=null){
                try {
                    //获取绝对路径
                    String path = request.getServletContext().getRealPath("upload/user/");
                    //文件名
                    String fileName=headImg.getOriginalFilename();
                    //文件重命名
                    String fileReName = UUID.randomUUID().toString().replaceAll("-", "") + fileName;
                    //复制文件
                    String filePath=path+fileReName;
                    IOUtils.copy(headImg.getInputStream(),new FileOutputStream(filePath));
                    user.setHeadImg("upload/user/"+fileReName);
                    return true;
                }catch (IOException e){
                    throw new RuntimeException(e);
                }
            }
        }
        return false;
    }

}
