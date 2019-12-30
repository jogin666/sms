package com.zy.sms.admin.service.impl;

import com.zy.sms.admin.dao.UserDao;
import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.admin.entity.UserRoleEntityPK;
import com.zy.sms.admin.service.UserService;
import com.zy.sms.base.service.BaseServiceImpl;
import com.zy.sms.util.ExcelUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import java.io.InputStream;
import java.io.Serializable;
import java.util.List;

@Service
public class UserServiceImpl extends BaseServiceImpl<UserEntity> implements UserService {

    private UserDao userDao;

    @Resource(name = "userDaoImpl")
    public void setUserDao(UserDao userDao) {
        super.setBaseBao(userDao);
        this.userDao = userDao;
    }

    //删除用户
    @Override
    public void delete(Serializable id) {
        //删除用户对应的所有权限
        userDao.deleteUserRoleByUserId(id);
        userDao.delete(id);
    }

    //保存用户和用户的角色
    @Override
    public void saveUserAndRole(UserEntity user, String... roleIds) {
        save(user);
        if (roleIds!=null){
            //可能多个角色
            for (String roleId:roleIds){
                UserRoleEntityPK userRolePk=new UserRoleEntityPK(new RoleEntity(roleId),user.getId());
                UserRoleEntity userRole=new UserRoleEntity(userRolePk);
                userDao.saveUserRole(userRole);
            }
        }
    }

    //更新用户所用的角色
    @Override
    public void updateUserAndRole(UserEntity user, String... roleIds) {
        //1、根据用户删除该用户的所有角色
        userDao.deleteUserRoleByUserId(user.getId());
        //2、更新用户
        update(user);
        //3、保存用户对应的角色
        if(roleIds != null){
            for(String roleId: roleIds){
                UserRoleEntityPK userRolePk=new UserRoleEntityPK(new RoleEntity(roleId),user.getId());
                userDao.saveUserRole(new UserRoleEntity(userRolePk));
            }
        }
    }

    //查照用户的所拥有的角色
    @Override
    public List<UserRoleEntity> findUserAndRoleByUserId(String id) {
        return userDao.getUserRoleByUserId(id);
    }

    //账号和密码查找用户
    @Override
    public UserEntity findUserByAccountAndPass(String account, String password) {
        return userDao.findUserByAccountAndPass(account,password);
    }

    @Override
    public boolean exit(String account) {
        return userDao.exit(account);
    }

    //导出
    @Override
    public void exportExcel(List<UserEntity> userList, ServletOutputStream outputStream) {
        ExcelUtil.exportUserExcel(userList,outputStream);
    }

    //导入
    @Override
    public void importExcel(InputStream inputStream, String userExcelName) {
        List<UserEntity> users = ExcelUtil.importExcel(inputStream,userExcelName);
        for (UserEntity user : users) {
            save(user);
            List<UserRoleEntity> userRoleEntityList=user.getUserRoles();
            for(UserRoleEntity userRoleEntity:userRoleEntityList) {
                userDao.saveUserRole(userRoleEntity);
            }
        }
    }
}
