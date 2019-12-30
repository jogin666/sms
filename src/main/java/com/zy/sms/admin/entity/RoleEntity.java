package com.zy.sms.admin.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class RoleEntity implements Serializable {

    private String roleId; //角色id
    private String state; //状态
    private String name; //角色称号
    private Set<RolePrivilegeEntity> rolePrivileges=new HashSet<RolePrivilegeEntity>(0); //权限
    //角色状态
    public static final String ROLE_STATE_VALID="1";
    public static final String ROLE_STATE_INVALID="0";

    public RoleEntity() { }

    public RoleEntity(String roleId) {
        this.roleId = roleId;
    }

    public RoleEntity(String roleId, String state, String name) {
        this.roleId = roleId;
        this.state = state;
        this.name = name;
    }

    public RoleEntity(String roleId, String state, String name, Set<RolePrivilegeEntity> rolePrivileges) {
        this.roleId = roleId;
        this.state = state;
        this.name = name;
        this.rolePrivileges = rolePrivileges;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<RolePrivilegeEntity> getRolePrivileges() {
        return rolePrivileges;
    }

    public void setRolePrivileges(Set<RolePrivilegeEntity> rolePrivileges) {
        this.rolePrivileges = rolePrivileges;
    }
}
