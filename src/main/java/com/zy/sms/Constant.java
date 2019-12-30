package com.zy.sms;

import java.util.HashMap;
import java.util.Map;

public class Constant {

    public final static String USER="user";

    //系统权限
    public final static String PRIVILEGE_OABG="oabg"; //OA办公
    public final static String PRIVILEGE_TEACHER="teacher";//教师办公
    public final static String PRIVILEGE_ZXXX="zxxx";// 在线学习
    public final static String PRIVILEGE_JWXT="jwxt";//教务系统
    public final static String PRIVILEGE_ADMIN="admin";//管理员办公
    public final static String PRIVILEGE_SPACE="space"; //我的空间
    //权限集
    public static Map<String,String> PRIVILEGE_MAP;
    //添加权限
    static{
        PRIVILEGE_MAP = new HashMap<String, String>();
        PRIVILEGE_MAP.put(PRIVILEGE_ZXXX,"在线学习");
        PRIVILEGE_MAP.put(PRIVILEGE_ADMIN, "管理员办公");
        PRIVILEGE_MAP.put(PRIVILEGE_TEACHER, "教师办公");
        PRIVILEGE_MAP.put(PRIVILEGE_OABG, "OA办公");
        PRIVILEGE_MAP.put(PRIVILEGE_SPACE, "我的空间");
        PRIVILEGE_MAP.put(PRIVILEGE_JWXT,"教务系统");
    }

    public final static String success="success";
    public final static String failure="failure";


    /********************后台提示消息**********************/
    //角色
    public final static String roleEditSuccess="编辑角色成功！";
    public final static String roleEditFailure="编辑角色失败！";
    public final static String addRoleSuccess="添加角色成功！";
    public final static String addRoleFailure="添加角色失败！";
    public final static String deleteRoleSuccess="删除角色成功！";
    public final static String deleteRoleFailure="删除角色失败!";

    //信息
    public final static String infoEditSuccess="编辑信息成功！";
    public final static String infoEditFailure="编辑失败,信息不完整！";
    public final static String publicInfoSuccess="发布信息成功！";
    public final static String publicInfoFailure="发布信息失败,信息不完整！";
    public final static String stopInfoSuccess="停用信息成功";
    public final static String deleteInfoSuccess="删除信息成功！";
    public final static String deleteInfoFailure="删除信息失败!";
    public final static String operationInfo="操作失败！";

    //投诉
    public final static String dealComplainFailure="处理投诉失败!";
    public final static String dealComplainSuccess="处理投诉成功";

    //用户
    public final static String deleteUserSuccess="删除学生成功！";
    public final static String deleteUserFailure="删除学生失败！";
    public final static String addUserSuccess="添加学生成功！";
    public final static String addUserFailure="添加学生失败！";
    public final static String editUserSuccess="编辑成功！";
    public final static String editUserFailure="编辑失败！";
    public final static String importExcelUserSuccess="导入学生成功！";
    public final static String importExcelUserFailure="添加学生失败！";

}
