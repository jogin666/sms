package com.zy.sms.admin.entity;


public class UserRoleEntity {

    //返回一个将用户id和角色连在一起的对象
    private UserRoleEntityPK userRoleEntityPk;

    public UserRoleEntity() {
    }

    public UserRoleEntity(UserRoleEntityPK userRoleEntityPk) {
        this.userRoleEntityPk = userRoleEntityPk;
    }

    public UserRoleEntityPK getUserRoleEntityPk() {
        return userRoleEntityPk;
    }

    public void setUserRoleEntityPk(UserRoleEntityPK userRoleEntityPk) {
        this.userRoleEntityPk = userRoleEntityPk;
    }
}
