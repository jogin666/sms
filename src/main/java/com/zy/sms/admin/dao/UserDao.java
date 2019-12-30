package com.zy.sms.admin.dao;

import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.base.dao.BaseDao;

import java.io.Serializable;
import java.util.List;

public interface UserDao extends BaseDao<UserEntity> {

    //保存用户的角色
    void saveUserRole(UserRoleEntity userRole);
    //根据id删除用户的所用角色
    void deleteUserRoleByUserId(Serializable id);
    //根据id获取用户的所用角色
    List<UserRoleEntity> getUserRoleByUserId(String id);
    //根据账号与密码中查找用户
    UserEntity findUserByAccountAndPass(String account,String password);
    //查找账号是否存在
    boolean exit(String account);
}
