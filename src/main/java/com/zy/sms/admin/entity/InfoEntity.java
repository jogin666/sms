package com.zy.sms.admin.entity;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class InfoEntity {
    private String infoId;
    private String type;
    private String source;
    private String title;
    private String content;
    private String creator;
    private Timestamp createTime;
    private String state;

    //状态
    public static String INFO_STATE_PUBLIC = "1";//发布
    public static String INFO_STATE_STOP = "0";//停用

    //信息分类
    public static String INFO_TYPE_TZGG = "tzgg";
    public static String INFO_TYPE_FJTZ = "zcsd";
    public static String INFO_TYPE_JXTZ = "nszd";
    public static Map<String, String> INFO_TYPE_MAP;
    static {
        INFO_TYPE_MAP = new HashMap<String, String>();
        INFO_TYPE_MAP.put(INFO_TYPE_TZGG, "通知公告");
        INFO_TYPE_MAP.put(INFO_TYPE_FJTZ, "放假通知");
        INFO_TYPE_MAP.put(INFO_TYPE_JXTZ, "检修通知");
    }

    public InfoEntity(){}

    public InfoEntity(String infoId, String type, String source, String title,
                      String content, String creator, Timestamp createTime, String state) {
        this.infoId = infoId;
        this.type = type;
        this.source = source;
        this.title = title;
        this.content = content;
        this.creator = creator;
        this.createTime = createTime;
        this.state = state;
    }

    public String getInfoId() {
        return infoId;
    }

    public void setInfoId(String infoId) {
        this.infoId = infoId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        InfoEntity that = (InfoEntity) o;
        return Objects.equals(infoId, that.infoId) &&
                Objects.equals(type, that.type) &&
                Objects.equals(source, that.source) &&
                Objects.equals(title, that.title) &&
                Objects.equals(content, that.content) &&
                Objects.equals(creator, that.creator) &&
                Objects.equals(createTime, that.createTime) &&
                Objects.equals(state, that.state);
    }

    @Override
    public int hashCode() {
        return Objects.hash(infoId, type, source, title, content, creator, createTime, state);
    }
}
