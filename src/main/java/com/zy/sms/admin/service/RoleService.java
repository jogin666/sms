package com.zy.sms.admin.service;

import com.zy.sms.admin.entity.RoleEntity;
import com.zy.sms.base.service.BaseService;

public interface RoleService extends BaseService<RoleEntity> {

    //删除角色的权限
    void deleteRoleAndPrivilege(RoleEntity roleEntity);
}
