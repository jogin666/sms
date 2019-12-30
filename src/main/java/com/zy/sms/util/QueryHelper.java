package com.zy.sms.util;

import java.util.ArrayList;
import java.util.List;

public class QueryHelper {

    private StringBuffer fromClause=new StringBuffer();  //from 子句

    private StringBuffer whereClause=new StringBuffer(); //where 子句

    private StringBuffer orderByClause=new StringBuffer();  //order by 子句

    private List<Object> parameters; //条件

    public final static String ORDER_BY_DESC="DESC"; //降序
    public final static String ORDER_BY_ASC="ASC"; //降序

    //拼接 from 子句
    public QueryHelper(Class<?> tClass,String alias){
        fromClause.append("from "+tClass.getSimpleName()+" "+alias);
    }

    //添加条件
    public void addCondition(String condition,Object... params){
        if (whereClause.length()==0){
            whereClause.append(" where "+condition);
        }else{
            whereClause.append(" and "+condition);
        }
        if (parameters==null){
            parameters=new ArrayList<>();
        }
        if (parameters!=null){
            for (Object obj: params){
                parameters.add(obj);
            }
        }
    }

    //添加排序
    public void addOrderByProperty(String property,String order){
        if (orderByClause.length()==0){
            orderByClause.append(" order by "+property+" "+order);
        }else{
            orderByClause.append(","+property+" "+order);
        }
    }

    //获取拼接的hql语句
    public String getQueryHQL(){
        StringBuffer sb = new StringBuffer(fromClause);
        sb.append(whereClause)
                .append(orderByClause);
        return new String(sb);
    }

    //查询全部
    public String getQueryCountHql(){
        return "select COUNT(*) " + fromClause.toString() + whereClause.toString();
    }

    //获取参数
    public List<Object> getParameters(){
        return parameters;
    }
}
