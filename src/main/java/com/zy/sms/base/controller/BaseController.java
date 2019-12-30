package com.zy.sms.base.controller;

import com.zy.sms.common.PageResult;

public class BaseController {

    //页面对象
    protected PageResult pageResult;
    //当前页面
    private int currentPage;
    //页面的大小  记录数
    private int pageSize;
    //默认页面大小
    public  final int DEFAULT_PAGE_SIZE=10;
    //默认当前页为1
    public  final int DEFAULT_CURRENT_PAGE=1;

    public PageResult getPageResult() {
        return pageResult;
    }

    public void setPageResult(PageResult pageResult) {
        this.pageResult = pageResult;
    }

    public int getCurrentPage() {
        if(currentPage<1){
            currentPage=DEFAULT_CURRENT_PAGE;
        }
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        if (pageSize<1){
            pageSize=DEFAULT_PAGE_SIZE;
        }
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
