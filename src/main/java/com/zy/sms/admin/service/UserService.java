package com.zy.sms.admin.service;

import com.zy.sms.admin.entity.UserEntity;
import com.zy.sms.admin.entity.UserRoleEntity;
import com.zy.sms.base.service.BaseService;

import javax.servlet.ServletOutputStream;
import java.io.InputStream;
import java.util.List;

public interface UserService extends BaseService<UserEntity> {

    //导出用户列表
    void exportExcel(List<UserEntity> userList, ServletOutputStream outputStream);
    //导入用户列表
    void importExcel(InputStream inputStream, String userExcelName);
    //保存用户以及其角色
    void saveUserAndRole(UserEntity user,String...roleIds);
    //跟新用户以及其角色
    void updateUserAndRole(UserEntity user,String...roleRolePK);
    //根据用户的id获取用户对应的所用角色
    List<UserRoleEntity> findUserAndRoleByUserId(String id);
    //根据用户的账号和密码查询用户
    UserEntity findUserByAccountAndPass(String account,String password);
    //检测账号是否存在
    boolean exit(String account);

}
