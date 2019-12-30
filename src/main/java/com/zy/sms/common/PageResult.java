package com.zy.sms.common;

import java.util.ArrayList;
import java.util.List;

public class PageResult {

    //总记录数
    private long totalCount;
    //当前页号
    private int currentPage;
    //总页数
    private int pageCount;
    //页大小
    private int pageSize;
    //列表记录
    private List items;

    private final ThreadLocal<List> threadLocal=new ThreadLocal<>();

    //计算总页数
    public PageResult(long totalCount, int currentPage, int pageSize, List items) {
        this.items=(items==null?new ArrayList():items);
        this.totalCount=totalCount; //总记录数
        this.pageSize=pageSize; //当前页数
        if (totalCount!=0){
            int item= (int) (totalCount/pageSize);
            this.pageCount=(totalCount%pageSize==0 ? item:(item+1));
            this.currentPage=currentPage;
        }else{
            this.currentPage=0;
        }
        threadLocal.set(items);
    }

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public List getItems() {
        return items;
    }

    public void setItems(List items) {
        this.items = items;
    }
}
