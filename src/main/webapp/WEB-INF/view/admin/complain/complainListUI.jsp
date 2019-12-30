<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path=request.getContextPath();
    String message= (String) request.getAttribute("msg");
    if (message!=null) {
        request.removeAttribute("msg");
    }
%>
<html>
<head>
    <title>投诉受理管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form name="form1" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>投诉受理管理</strong></div> </div>
                <div class="search_art">
                    <li>
                        投诉标题：<input type="text" name="compTitle" cssClass="s_text"  cssStyle="width:160px;"/>
                    </li>
                    <li>
                        投诉时间：<input type="date" id="startTime" name="startTime" cssClass="s_text"  cssStyle="width:160px";/>
                        ——&nbsp;<input type="date" id="endTime" name="endTime" cssClass="s_text"  cssStyle="width:160px;"/>
                    </li>
                    <li>
                        状态：<select name="state" id="state" style="height: 25px">
                                <option></option>
                                <c:forEach items="${complainStateMap}" var="stateMap">
                                    <option value="${stateMap.value}">${stateMap.value}</option>
                                </c:forEach>
                            </select>
                    </li>
                    <li><input type="button" class="s_button" value="搜 索" onclick="doSearch()"/></li>
                </div>

                <div class="t_list" style="margin:0px; border:0px none;">
                    <table width="100%" border="0">
                        <tr class="t_tit">
                            <td align="center">投诉标题</td>
                            <td width="120" align="center">被投诉部门</td>
                            <td width="120" align="center">被投诉人</td>
                            <td width="140" align="center">投诉时间</td>
                            <td width="100" align="center">受理状态</td>
                            <td width="100" align="center">操作</td>
                        </tr>
                        <c:forEach items="${pageResult.items}" var="item">
                            <tr <c:if test="#st.odd"> bgcolor="f8f8f8" </c:if> >
                                <td align="center">
                                    ${item.compTitle}
                                </td>
                                <td align="center">
                                    ${item.toCompDept}
                                </td>
                                <td align="center">
                                     ${item.toCompName}
                                </td>
                                <td align="center">
                                    <fmt:formatDate value='${item.compTime}' pattern='yyyy-MM-dd HH:MM:ss'/>
                                </td>
                                <td align="center">
                                    <c:choose>
                                        <c:when test="${item.state==0}">待受理</c:when>
                                        <c:when test="${item.state==1}">已受理</c:when>
                                        <c:otherwise>已失效</c:otherwise>
                                    </c:choose>
                                </td>
                                <td align="center">
                                    <c:if test="${item.state!=2}">
                                        <a href="javascript:doDeal('${item.compId}')">受理</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="c_pate" style="margin-top: 5px;">
                <table width="100%" class="pageDown" border="0" cellspacing="0"
                       cellpadding="0">
                    <tr>
                        <td align="right">
                            总共[<font color="#00bfff">${pageResult.totalCount}</font>]条记录，
                            当前第[<font color="#00bfff">${pageResult.currentPage}</font>] 页，
                            共[<font color="#00bfff">${pageResult.pageCount}</font>]页 &nbsp;&nbsp;
                            <c:if test="${pageResult.pageCount>1}">
                                <a href="<%=path%>/user/userListUI.do?page=${pageResult.currentPage-1}">
                                    上一页&nbsp;&nbsp;
                                </a>
                            </c:if>
                            <c:if test="${pageResult.currentPage<pageResult.pageCount}">
                                <a href="<%=path%>/user/userListUI.do?page=${pageResult.currentPage+1}">
                                    下一页>&nbsp;&nbsp;
                                </a>
                            </c:if>
                            跳转到&nbsp;<input id="pageValue" type="number" style="width: 50px;"onchange="goPage()" min="1"/>&nbsp;页&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</form>

</body>
<script type="text/javascript" src="<%=path%>/jquery.min.js"></script>
<script type="text/javascript">
    //搜索
    function doSearch(){
        document.forms[0].action = "<%=path%>/complain/complainListUI.do";
        document.forms[0].submit();
    }
    //受理
    function doDeal(compId){
        document.forms[0].action = "<%=path%>/complain/dealUI.do?compId=" + compId;
        document.forms[0].submit();
    }

    function goPage() {
        //获取输入框控件
        var pageValue = document.getElementById("pageValue");
        //获取输入框的数据
        var value = pageValue.value;
        if(value<1 || value>${pageResult.pageCount}){
            alert("请输入合法数据");
            return false ;
        }
        window.location.href="<%=path%>/complain/complainListUI.do?page="+value;
    }
</script>
</html>