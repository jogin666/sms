package com.zy.sms.admin.entity;

import java.sql.Timestamp;

public class ComplainReplyEntity {

    private String replyId; //回复者的主键
    private String replyer; //姓名
    private String replyerDept; //部门
    private Timestamp replyTime; //回复时间
    private String replyContent; //回复内容
    private ComplainEntity complain; //投诉的信息体

    public ComplainReplyEntity() {
        if(complain!=null){
            complain.setComplainReplies(null);
        }
    }

    public ComplainReplyEntity(String replyId, String replyer, String replyerDept,
                               Timestamp replyTime, String replyContent) {
        this.replyId = replyId;
        this.replyer = replyer;
        this.replyerDept = replyerDept;
        this.replyTime = replyTime;
        this.replyContent = replyContent;
    }

    public String getReplyId() {
        return replyId;
    }

    public void setReplyId(String replyId) {
        this.replyId = replyId;
    }

    public String getReplyer() {
        return replyer;
    }

    public void setReplyer(String replyer) {
        this.replyer = replyer;
    }

    public String getReplyerDept() {
        return replyerDept;
    }

    public void setReplyerDept(String replyerDept) {
        this.replyerDept = replyerDept;
    }

    public Timestamp getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Timestamp replyTime) {
        this.replyTime = replyTime;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public ComplainEntity getComplain() {
        return complain;
    }

    public void setComplain(ComplainEntity complain) {
        this.complain = complain;
    }
}


