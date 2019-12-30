package com.zy.sms.admin.controller;

import com.zy.sms.Constant;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.entity.UserRoleEntityPK;
import com.zy.sms.admin.service.RoleService;
import com.zy.sms.admin.service.UserService;
import com.zy.sms.base.controller.BaseController;
import com.zy.sms.util.MessageBuilder;
import com.zy.sms.util.QueryHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;

    //列表页面
    @RequestMapping("/userListUI.do")
    public ModelAndView listUI(HttpServletRequest request)throws Exception{
        ModelAndView modelAndView=new ModelAndView("admin/user/userListUI");
        QueryHelper queryHelper=new QueryHelper(UserEntity.class,"u"); //查询
        try {
            int index=0;
            String userName=request.getParameter("usrName"); //查询条件
            if (!StringUtils.isEmpty(userName)){
                if (!StringUtils.isEmpty(userName)){
                    queryHelper.addCondition("u.name like ?"+index,"%"+userName+"%");
                    index++;
                }
            }
            String className=request.getParameter("className"); //查询条件
            if (!StringUtils.isEmpty(className)){
                if (!StringUtils.isEmpty(className)){
                    queryHelper.addCondition("u.className like ?"+index,"%"+className+"%");
                }
            }
            String page=request.getParameter("page"); //页数跳转
            if (!StringUtils.isEmpty(page)){
                int curreentPage=Integer.parseInt(page);
                pageResult=userService.getPageResult(queryHelper,curreentPage,getPageSize());
            }else{
                pageResult=userService.getPageResult(queryHelper,getCurrentPage(),getPageSize());  //页面结果对象（继承父类的）
            }
            modelAndView.addObject("pageResult",pageResult);
        }catch (Exception e){
            throw new Exception(e.getMessage());
        }
        return modelAndView;
    }

    //跳转到增加人员的页面
    @RequestMapping("/addUserUI.do")
    public ModelAndView addUI(){
        ModelAndView model=new ModelAndView("admin/user/addUserUI");
        //把所有的角色查询出来，带过去给JSP页面显示
        Map<String,String> roleMap=new HashMap<String, String>();
        findRoles(roleService.findObjects(),roleMap);
        model.addObject("roleMap",roleMap);
        return model;
    }

    //保存（增加的学生）
    @ResponseBody
    @RequestMapping("/addUser.do")
    public Map add(UserEntity user, HttpServletRequest request){
        Map<String,String> map=new HashMap<String, String>();
        String[] userRolePKs=request.getParameterValues("userRolePKs");
        if (userRolePKs!=null && user.getState()!=null){
            user.setId(user.getAccount());
            userService.saveUserAndRole(user,userRolePKs);
            return MessageBuilder.buildBackMap(Constant.success, Constant.addUserSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.failure,Constant.addUserFailure);
    }

    //跳转到编辑界面
    @RequestMapping("/editUserUI.do")
    public ModelAndView editUI(UserEntity user){
        //加载角色列表
        ModelAndView model=new ModelAndView("admin/user/editUserUI");
        if (user!=null && user.getId()!=null){
            user=userService.findObjectById(user.getId());
            Map<String,String> userRole=new HashMap<String, String>();
            //回显学生的对应的角色
            List<UserRoleEntity> list=userService.findUserAndRoleByUserId(user.getId());
            List<String> userRoles=new ArrayList<String>();
            if (list!=null && list.size()>0){
                for(int i = 0; i < list.size(); i++){
                    UserRoleEntityPK userRolePk=list.get(i).getUserRoleEntityPk();
                    String roleName=userRolePk.getRole().getName();
                    String roleId=userRolePk.getRole().getRoleId();
                    userRole.put(roleId,roleName); //传递到界面
                    userRoles.add(roleName); //用于移除重复的角色
                }
                model.addObject("userRole",userRole);//学生所拥有的角色
            }
            model.addObject("user",user);
            Map<String,String> roles=findRoleName(userRoles,roleService.findObjects());
            model.addObject("roles",roles); //学生没有用的角色
        }
        return model;
    }

    //保存编辑（学生信息）
    @ResponseBody
    @RequestMapping("/saveEditUser.do")
    public Map edit(UserEntity user,HttpServletRequest request) throws Exception{
        Map<String,String> map=new HashMap<String, String>();
        java.sql.Date brithday=userService.findObjectById(user.getId()).getBrithday();
        user.setBrithday(brithday);
        String[] userRolePKs=request.getParameterValues("userRolePKs");
        if(userRolePKs!=null){
            userService.updateUserAndRole(user,userRolePKs);
            return MessageBuilder.buildBackMap(Constant.success,Constant.editUserSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.failure,Constant.editUserFailure);
    }

    //单个删除
    @ResponseBody
    @RequestMapping("/deleteUser.do")
    public Map<String, String> delete(HttpServletRequest request){
        String userId=request.getParameter("id");
        if(!StringUtils.isEmpty(userId)){
            userService.delete(userId);
            return MessageBuilder.buildBackMap(Constant.success,Constant.deleteUserSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.failure,Constant.deleteUserFailure);
    }

    //批量删除
    @ResponseBody
    @RequestMapping("/deleteSelectedUser.do")
    public Map<String, String> deleteSelected(HttpServletRequest request){
        String selectedRow[]=request.getParameterValues("selectedRow[]");
        if (selectedRow!=null){
            for(String id:selectedRow){
                userService.delete(id);
            }
            return MessageBuilder.buildBackMap(Constant.success,Constant.deleteUserSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.success,Constant.deleteUserFailure);
    }

    //导出学生列表
    @RequestMapping("/exportUserExcel.do")
    public void exportExcel(HttpServletResponse response){
        try{
            List<UserEntity>userList=userService.findObjects();
            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet-stream");
            response.setContentType("application/OCTET-STREAM;charset=UTF-8");
            //第一个参数是标识文件下载，弹出对话框让学生下载
            response.setHeader("Content-Disposition",
                    "attachment;filename="+new String("学生列表.xls".getBytes(),"ISO-8859-1"));
            //获取输出流
            ServletOutputStream outputStream = response.getOutputStream();
            userService.exportExcel(userList,outputStream);
            //关闭流
            if (outputStream!=null){
                outputStream.close();
            }
        }catch (IOException e){
            e.printStackTrace();
        }
    }

    //导入学生列表
    @RequestMapping("/importUserExcel.do")
    public String importExcel(@RequestParam("userExcel") MultipartFile userExcel) throws Exception{
        if (userExcel!=null){
            String userExcelFileName=userExcel.getOriginalFilename();
            InputStream stream=userExcel.getInputStream();
            if (userExcelFileName.matches("^.+\\.(?i)((xls)|(xlsx))$")){
                userService.importExcel(stream,userExcelFileName);
//                return MessageBuilder.buildBackMap(Constant.success,Constant.importExcelUserSuccess);
            }
        }
        return "redirect:/user/userListUI.do";
//        return MessageBuilder.buildBackMap(Constant.success,Constant.importExcelUserFailure);
    }

    //检验账户的唯一性
    @ResponseBody
    @RequestMapping("/doVerify.do")
    public String verifyAccount(HttpServletRequest request) {
        String account=request.getParameter("account");
        String  strResult="false";
        if (!StringUtils.isEmpty(account)){
            boolean exit=userService.exit(account);
            if(exit){
                strResult="true";
            }
        }
        return strResult;
    }

    //回显学生的角色
    private Map<String,String> findRoleName(List<String> userRoles,List<RoleEntity> roles){
        Map<String,String> roleMap=new HashMap<String,String>();
        List<String> roleNames=new ArrayList<String>();
        for (RoleEntity role:roles){
            String roleName=role.getName();
            roleNames.add(roleName); //获取所有的角色
        }
        if (roleNames.size()>0 && roleNames.removeAll(userRoles)){//移除用户的角色名称
            for (RoleEntity role:roles){
                String roleName=role.getName();
                for (int i=0;roleNames.size()>0 && i<roleNames.size();i++){
                    if (roleName.equals(roleNames.get(i))){ //寻找用户没拥有的角色的名称
                        roleMap.put(role.getRoleId(),roleName); //添加map中，key是角色的id  value是角色的名称
                    }
                }
            }
        }else{
            findRoles(roles,roleMap);
        }
        return roleMap;
    }

    //获取所有的角色的id和name
    public void findRoles(List<RoleEntity> roles,Map<String,String> roleMap){
        for (RoleEntity roleEntity:roles){
            roleMap.put(roleEntity.getRoleId(),roleEntity.getName());
        }
    }
}
