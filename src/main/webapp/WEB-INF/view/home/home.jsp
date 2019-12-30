<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/23
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.zy.sms.admin.entity.UserEntity" %>
<%@ page import="com.zy.sms.Constant" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path=request.getContextPath();
    //用户
    UserEntity user= (UserEntity) request.getSession().getAttribute(Constant.USER);
    String headImg=path+"/images/home/user.png";
    if (user.getHeadImg() != null && !"".equals(user.getHeadImg())) {
        headImg =path+"/"+user.getHeadImg();
    }
%>
<html>
<head>
    <title>学生管理系统平台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/home.css"/>
</head>
<body>
<table width="1222" border="0" align="center" cellpadding="0" cellspacing="0" background="<%=path%>/images/admin/xingzheng.png" class="top">
    <tr>
        <td width="32" height="106">&nbsp;</td>
        <td width="418" height="106" align="left" valign="middle">
            <img class="zxx_test_png" src="<%=path%>/images/home/sspu.png" width="470" height="90" alt=""/>
        </td>
        <td width="211">&nbsp;</td>

        <td width="331" align="right" valign="top">
            <table width="350" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center"></td>
                    <td align="left"></td>
                    <td align="right">
                        <a><b></b><font color="red">欢迎您，${sessionScope.XSGL_USER.account} &nbsp;</font></a>
                    </td>
                    <td align="center"><img src="<%=path%>/images/home/help.png" width="12" height="17"/></td>
                    <td align="left"><a href="javascript:void(0);"><font color="black" size="2px">帮助</font></a></td>
                    <td align="center"><img src="<%=path%>/images/home/exit.png" width="14" height="14"/></td>
                    <td align="left" valign="middle"><a href="<%=path%>/login/loginOut.do"><font color="black" size="2px">退出</font></a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div class="menu">
    <ul class="clearfix" style="background:#87CEFA">
        <li class="hover"><a href="">OA办公</a></li>
        <li><a href="javascript:void(0);">在线学习</a></li>
        <li><a href="javascript:void(0);">教务系统</a></li>
        <li><a href="<%=path%>/admin/home/frameUI;">教师办公</a></li>
        <li><a href="<%=path%>/admin/home/frameUI.do">管理员办公</a></li>
        <li><a href="javascript:void(0);">我的空间</a></li>
    </ul>
</div>

<div class="content">
    <div class="left">
        <div class="left_grzx1">
            <div class="left_grzxbt">
                <h1>个人资料</h1>
                <div style="float:right;padding-top:3px;">
                    <a style="text-align: center;padding-bottom: 5px"
                       href="<%=path%>/home/editUserInfoUI.do?userId=${sessionScope.XSGL_USER.id}" target="_blank">编辑</a>&nbsp;&nbsp;
                </div>
            </div>
            <table width="98%" border="0" align="center">
                <tr>
                    <td width="76" height="100" align="center" valign="middle">
                        <div class="left-tx">
                            <img src="<%=headImg%>" width="70" height="70"/>
                        </div>
                    </td>
                    <td width="60%">
                        <table width="95%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="2" style=" font-weight:bold; font-size: 15px; color:#000000;">${sessionScope.XSGL_USER.name}</td>
                            </tr>
                            <tr>
                                <td colspan="2" style=" font-weight:bold; font-size: 15px; color:#000000;">${sessionScope.XSGL_USER.className}</td>
                            </tr>
                            <tr>
                                <td colspan="2" style=" font-weight:bold; font-size: 15px; color:#000000;">${sessionScope.XSGL_USER.deptName}</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="right">
        <div class="left_grzx1">
            <div class="left_grzxbt">
                <h1>我的投诉</h1>
                <div style="float:right;padding-top:3px;">
                    <a href="<%=path%>/home/addComplainUI.do" target="_blank">我要投诉</a>&nbsp;&nbsp;
                </div>
            </div>
            <table width="98%" border="0" align="center">
                <c:forEach items="${complainList}" var="complain">
                    <tr>
                        <td style="padding-top: 8px;">
                            <a href="<%=path%>/home/searchComplainUI.do?compId=${complain.compId}">
                                    ${complain.compTitle} __
                                <c:choose>
                                    <c:when test="${complain.isNm==1}">匿名</c:when>
                                    <c:otherwise>不匿名</c:otherwise>
                                </c:choose> __
                                <c:choose>
                                    <c:when test="${complain.state==0}">
                                        未受理
                                    </c:when>
                                    <c:when test="${complain.state==1}">
                                        受理
                                    </c:when>
                                    <c:otherwise>
                                        已失效
                                    </c:otherwise>
                                </c:choose>__
                                <fmt:formatDate value="${complain.compTime}" pattern="yyyy-MM-dd HH:MM"/>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="clear"></div>

    <div class="layout_center">
        <div class="lc_grzx1">
            <div class="lc_grzxbt">
                <h1>信息列表</h1>
            </div>
            <table width="98%" border="0" align="center" >
                <c:forEach items="${infoList}" var="info">
                    <tr>
                        <td style="padding-top: 8px;">
                            <a href="<%=path%>/home/searchInfoUI.do?infoId=${info.infoId}">
                                    ${info.title} __
                                    ${info.type} __
                                    ${info.source} __
                                <fmt:formatDate value="${info.createTime}" pattern="yyyy-MM-dd HH:MM"/>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>

<div class="foot">	CopyRight&nbsp;&nbsp;&nbsp;©2018&nbsp;&nbsp;&nbsp;上海第二工业大学</div>

</body>

<%--
<script type="text/javascript" src='<%=path%>/js/jquery.min.js'></script>
<script type="text/javascript">
    /**
     * 1.获取后台传来的投诉列表
     * 2.显示用户的投诉列表
     */
    $.ajax({
        dataType:'json',
        type:'post',
        data:'<%=request%>',
        url:"<%=path%>/home/showComplain.do",
        contentType:"application/json;charset=utf-8",
        success:function (complainList) {
            $("#complainTable").append("<table width=\"98%\" border=\"1\" align=\"center\">");
            for(var j=0;j<complainList.length;j++){
                var complainIsNM=(complainList[j].isNM===0)?"匿名":"不匿名"
                var url="<%=path%>/home/searchComplainUI.do?compId="+complainList[j].compId+"";
                var trTd="'<tr><td><a href="+url+">"+complainList[j].compId+""+complainList[j].compTitle+""+complainIsNM+"" +
                    ""+complainList[j].compTime+"</a></td></tr>";
                $("#complainTable").append(trTd);
            }
            $("#complainTable").append("</table>");
        },error:function () {
            alert("ajax请求获取投诉列表出现错误！")
        }
    });


    /**
     * 1.获取后台传来的信息列表
     * 2.显示用户工作平台的信息列表
     */
    $.ajax({
        dataType:'json',
        type:'post',
        data:'<%=request%>',
        url:"<%=path%>/home/showInfo.do",
        contentType:'application/json;charset=utf-8',
        success:function (infoList) {
            $('#infoTable').append("<table width=\"98%\" border=\"1\" align=\"center\">");
            for (var i=0;i<infoList.length;i++) {
                var url="<%=path%>/home/searchInfoUI.do?infoId="+infoList[i].infoId+"";
                var trTd="<tr><td><a href='"+url+"'>"+infoList[i].title+""+infoList[i].type+"" +
                    ""+infoList[i].createTime+"</a></td></tr>";
                $("#infoTable").append(trTd);
            }
            $('#infoTable').append("</table>");
        },error:function () {
            alert("ajax请求信息列表出错！");
        }
    });
</script>
--%>
</html>