package com.zy.sms.admin.controller;

import com.zy.sms.Constant;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.entity.RolePrivilegeEntity;
import com.zy.sms.admin.entity.RolePrivilegeEntityPK;
import com.zy.sms.admin.service.RoleService;
import com.zy.sms.base.controller.BaseController;
import com.zy.sms.util.MessageBuilder;
import com.zy.sms.util.QueryHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {


    @Autowired
    private RoleService roleService;

    //列表页面
    @RequestMapping("/roleListUI.do")
    public ModelAndView listUI(HttpServletRequest request)throws Exception{
        //返回的视图
        ModelAndView modelAndView=new ModelAndView("admin/role/roleListUI");
        //查询
        QueryHelper queryHelper = new QueryHelper(RoleEntity.class, "r");
        try {
            //是否是条件查询
            String name=request.getParameter("roleName");
            if(!StringUtils.isEmpty(name)){
                queryHelper.addCondition("r.name like ?0", "%" + name + "%");
            }
            String page=request.getParameter("page"); //页数跳转
            if (!StringUtils.isEmpty(page)){
                int curreentPage=Integer.parseInt(page);
                pageResult=roleService.getPageResult(queryHelper,curreentPage,getPageSize());
            }else {
                pageResult = roleService.getPageResult(queryHelper, getCurrentPage(), getPageSize());
            }
            //存放对象
            modelAndView.addObject("pageResult",pageResult);
        } catch (Exception e) {
            throw new Exception(e.getMessage());
        }
        return modelAndView;
    }

    //跳转到新增的页面
    @RequestMapping("/addRoleUI.do")
    public ModelAndView addUI(){
        ModelAndView model=new ModelAndView("admin/role/addRoleUI");
        model.addObject("privilegeMap", Constant.PRIVILEGE_MAP);
        return model;
    }

    //保存新增
    @ResponseBody
    @RequestMapping("/saveRole.do")
    public Map<String, String> saveRole(RoleEntity role, @RequestParam(value = "rolePrivilege")String []rolePrivileges){
        if (getPrivilege(role,rolePrivileges)) {
            roleService.save(role);
            //添加角色成功
            return MessageBuilder.buildBackMap(Constant.success,Constant.addRoleSuccess);
        }
        //添加角色失败
        return MessageBuilder.buildBackMap(Constant.failure,Constant.addRoleFailure);
    }

    //跳转到编辑的页面
    @RequestMapping("/editRoleUI.do")
    public ModelAndView editUI(HttpServletRequest request){
        //设置跳转的页面
        ModelAndView model=new ModelAndView("admin/role/editRoleUI");
        //获取请求携带的角色的id
        String roleId=request.getParameter("roleId");
        if (!StringUtils.isEmpty(roleId)){
            RoleEntity role=roleService.findObjectById(roleId);
            request.getSession().setAttribute("role",role);
            model.addObject("roleName",role.getName());
            //获取用户的权限集
            Set<RolePrivilegeEntity> privilegeSet=role.getRolePrivileges();
            if (privilegeSet!=null){
                //加载系统的权限集
                Map<String,String> map=Constant.PRIVILEGE_MAP;
                //获取系统权限集的values
                Collection<String> mapValues =Constant.PRIVILEGE_MAP.values();
                //存放角色的所用的权限
                List<String> rolePrivilegeList=new ArrayList<String>();
                for(RolePrivilegeEntity privilege:privilegeSet){
                    String privilegeName=privilege.getRolePrivilegeEntityPK().getCode();
                    if (mapValues.contains(privilegeName)){
                        mapValues.remove(privilegeName);
                    }
                    rolePrivilegeList.add(privilegeName);
                }
                //剩下角色没拥用的权限
                model.addObject("privilegeMap",map);
                model.addObject("rolePrivilegeList", rolePrivilegeList); //角色的权限
            }
        }
        return model;
    }

    //保存编辑
    @ResponseBody
    @RequestMapping("/saveEditRole.do")
    public Map<String,String> edit(HttpServletRequest request,RoleEntity role){
        //前台编辑后的角色权限
        String []rolePrivileges=request.getParameterValues("rolePrivilege");
        if (getPrivilege(role,rolePrivileges)) {
            roleService.update(role);
            //编辑成功
            return MessageBuilder.buildBackMap(Constant.success,Constant.roleEditSuccess);
        }
        //编辑失败
        return MessageBuilder.buildBackMap(Constant.failure,Constant.addRoleFailure);
    }

    //删除角色
    @ResponseBody
    @RequestMapping("deleteRole.do")
    public Map delete(@RequestParam(value = "roleId") String roleId){
        if (!StringUtils.isEmpty(roleId)){
            roleService.delete(roleId);
            return MessageBuilder.buildBackMap(Constant.success,Constant.deleteRoleSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.failure,Constant.deleteRoleFailure);
    }

    //批量删除
    @ResponseBody
    @RequestMapping("/deleteSelectedRowRole.do")
    public Map deleteSelected(HttpServletRequest request){
        //已选择的用户
        String[] selectedRow=request.getParameterValues("selectedRow[]");
        if (selectedRow!=null){
            for (String id:selectedRow){
                roleService.delete(id);
            }
            return MessageBuilder.buildBackMap(Constant.success,Constant.deleteRoleSuccess);
        }
        return MessageBuilder.buildBackMap(Constant.failure,Constant.deleteRoleFailure);
    }

    //处理角色的权限
    private boolean getPrivilege(RoleEntity role,String rolePrivileges[]){
        //判空操作
        boolean state=!StringUtils.isEmpty(role.getState());
        boolean name=!StringUtils.isEmpty(role.getName());
        boolean privileges=(rolePrivileges!=null);
        if(state && name && privileges){
            HashSet<RolePrivilegeEntity> set=new HashSet<RolePrivilegeEntity>();
            //保存用户的权限
            for (int i=0;i<rolePrivileges.length;i++){
                RolePrivilegeEntityPK rolePrivilegeEntityPK=new RolePrivilegeEntityPK(role,rolePrivileges[i]);
                //使用权限和角色的Id，实例一个角色权限
                RolePrivilegeEntity rolePrivilege=new RolePrivilegeEntity(rolePrivilegeEntityPK);
                set.add(rolePrivilege);
            }
            role.setRolePrivileges(set);
            return true;
        }
        return false;
    }

}
