package com.zy.sms.admin.entity;


import java.io.Serializable;

/*
    将用户的id和角色连在一起,方便快速查询
*/
public class UserRoleEntityPK implements Serializable {


    private RoleEntity role; //角色

    private String userId; //用户的id

    public UserRoleEntityPK(){}

    public UserRoleEntityPK(RoleEntity role, String userId){
        this.role=role;
        this.userId=userId;
    }

    public RoleEntity getRole() {
        return role;
    }

    public void setRole(RoleEntity role) {
        this.role = role;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    //判断哈希码是否一致
    @Override
    public int hashCode() {
        final int prime=31;
        int result=1;
        result=result*prime+((role==null)? 0:role.hashCode());
        result=result*prime+((userId==null)? 0:userId.hashCode());
        return result;
    }

    //判断对象是否一致
    @Override
    public boolean equals(Object obj) {
        if (this==obj){
            return true;
        }
        if (obj==null){
            return false;
        }
        if (getClass()!=obj.getClass()){
            return false;
        }

        UserRoleEntityPK other= (UserRoleEntityPK) obj;
        if (role==null){
            if (other.role!=null){
                return false;
            }
        }else if (!role.equals(other.role)){
            return false;
        }
        if (userId==null){
            if (other.userId!=null){
                return false;
            }
        }else if(!userId.equals(other.userId)){
            return false;
        }
        return true;
    }
}
