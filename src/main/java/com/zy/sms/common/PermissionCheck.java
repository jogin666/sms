package com.zy.sms.common;

import com.zy.sms.admin.dao.UserDao;
import com.zy.sms.admin.dao.impl.UserDaoImpl;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.entity.RolePrivilegeEntity;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.service.UserService;
import com.zy.sms.admin.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("permissionCheck")
public class PermissionCheck {

    @Autowired
    private UserService userService;

    public boolean isAccessible(UserEntity user, String code) {
        //获取用户被授予的角色
        List<UserRoleEntity> userRoles=user.getUserRoles();
        if (userRoles==null){
            UserDao userDao=new UserDaoImpl();
            UserService userService=new UserServiceImpl();
            ((UserServiceImpl) userService).setUserDao(userDao);
            userRoles=userService.findUserAndRoleByUserId(user.getId());
        }
        if (userRoles!=null && userRoles.size()>0){
            for (UserRoleEntity userRole:userRoles){
                //获取角色
                RoleEntity role=userRole.getUserRoleEntityPk().getRole();
                //获取角色的权限
                for (RolePrivilegeEntity rp:role.getRolePrivileges()){
                    //判断是否相等
                    if (code.equals(rp.getRolePrivilegeEntityPK().getCode())){
                        return true;
                    }
                }
            }
        }
        return false;
    }
}
