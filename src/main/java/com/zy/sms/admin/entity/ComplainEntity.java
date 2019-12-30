package com.zy.sms.admin.entity;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class ComplainEntity {

    private String compId; //主键
    private String compDept; //所在的部门
    private String compName; //投诉人
    private String compMoblie; //手机号
    private String isNm; //是否匿名
    private String compTitle; //标题
    private Timestamp compTime; //时间
    private String toCompName; //被投诉人
    private String toCompDept; //投诉部门
    private String compContent; //投诉内容
    private String state; //状态
    private Set<ComplainReplyEntity> complainReplies = new HashSet<ComplainReplyEntity>(0); //回复处理
    //状态
    public static String COMPLAIN_STATE_UNDONE = "0"; //待受理
    public static String COMPLAIN_STATE_DONE = "1"; //已受理
    public static String COMPLAIN_STATE_INVALID = "2"; //已失效
    //投诉信的类型
    public static Map<String, String> COMPLAIN_STATE_MAP;
    static {
        COMPLAIN_STATE_MAP = new HashMap<String, String>();
        COMPLAIN_STATE_MAP.put(COMPLAIN_STATE_UNDONE, "待受理");
        COMPLAIN_STATE_MAP.put(COMPLAIN_STATE_DONE, "已受理");
        COMPLAIN_STATE_MAP.put(COMPLAIN_STATE_INVALID, "已失效");
    }

    public String getCompId() {
        return compId;
    }

    public void setCompId(String compId) {
        this.compId = compId;
    }

    public String getCompDept() {
        return compDept;
    }

    public void setCompDept(String compDept) {
        this.compDept = compDept;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public String getCompMoblie() {
        return compMoblie;
    }

    public void setCompMoblie(String compMoblie) {
        this.compMoblie = compMoblie;
    }

    public String getIsNm() {
        return isNm;
    }

    public void setIsNm(String isNm) {
        this.isNm = isNm;
    }

    public String getCompTitle() {
        return compTitle;
    }

    public void setCompTitle(String compTitle) {
        this.compTitle = compTitle;
    }

    public Timestamp getCompTime() {
        return compTime;
    }

    public void setCompTime(Timestamp compTime) {
        this.compTime = compTime;
    }

    public String getToCompName() {
        return toCompName;
    }

    public void setToCompName(String toCompName) {
        this.toCompName = toCompName;
    }

    public String getToCompDept() {
        return toCompDept;
    }

    public void setToCompDept(String toCompDept) {
        this.toCompDept = toCompDept;
    }

    public String getCompContent() {
        return compContent;
    }

    public void setCompContent(String compContent) {
        this.compContent = compContent;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Set<ComplainReplyEntity> getComplainReplies() {
        return complainReplies;
    }

    public void setComplainReplies(Set<ComplainReplyEntity> complainReplies) {
        this.complainReplies = complainReplies;
    }
}
