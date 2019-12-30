package com.zy.sms.admin.entity;

public class RolePrivilegeEntity {

    private RolePrivilegeEntityPK rolePrivilegeEntityPK;

    public RolePrivilegeEntity() {
    }

    public RolePrivilegeEntity(RolePrivilegeEntityPK rolePrivilegeEntityPK) {
        this.rolePrivilegeEntityPK = rolePrivilegeEntityPK;
    }

    public RolePrivilegeEntityPK getRolePrivilegeEntityPK() {
        return rolePrivilegeEntityPK;
    }

    public void setRolePrivilegeEntityPK(RolePrivilegeEntityPK rolePrivilegeEntityPK) {
        this.rolePrivilegeEntityPK = rolePrivilegeEntityPK;
    }
}
