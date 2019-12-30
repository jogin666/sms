package com.zy.sms.admin.entity;

import java.io.Serializable;

/*
  将角色的id与权限绑定在一起，方便查询
*/
public class RolePrivilegeEntityPK implements Serializable {


    private RoleEntity role;
    private String code;

    public RolePrivilegeEntityPK() {
        if (role!=null){
            role.setRolePrivileges(null);
        }
    }

    public RolePrivilegeEntityPK(RoleEntity role, String code) {
        this.role = role;
        this.code = code;
    }

    public RoleEntity getRole() {
        return role;
    }

    public void setRole(RoleEntity role) {
        this.role = role;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    //返回对象的hashcode码
    @Override
    public int hashCode() {
        final int prime=31;
        int result=1;
        result=prime*result+((code==null)? 0:code.hashCode());
        result=prime*result+((role==null)? 0:role.hashCode());
        return result;
    }

    //判断对象是否相同
    @Override
    public boolean equals(Object obj) {
        if (obj==null){
            return false;
        }
        if (this==obj){
            return true;
        }
        if (getClass()!=obj.getClass()){
            return false;
        }
        //同一对象后，判断对象的属性是否一致
        RolePrivilegeEntityPK other= (RolePrivilegeEntityPK) obj;
        if (code==null){
            if (other.code!=null){
                return false;
            }
        }else if (!code.equals(other.code)){
            return false;
        }
        if (role==null){
            if (other.role!=null){
                return false;
            }
        }else if (!role.equals(other.role)){
            return false;
        }
        return true;
    }
}
