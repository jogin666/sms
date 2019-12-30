<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/25
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.zy.sms.admin.entity.InfoEntity" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    InfoEntity info = (InfoEntity) request.getSession().getAttribute("info");
    String path = request.getContextPath();
%>

<html>
<head>
    <base href="<%=path%>">
    <title>查看信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
</head>

<link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>

<body>
    <div class="c_crumbs">
        <div><b></b><strong>工作主页</strong>&nbsp;-&nbsp;信息</div>
    </div>
    <div style="text-align: center; max-width: 1000px;margin:auto;padding-top: 30px;text-align: center;overflow: hidden">
    	<!-- 标题 -->
        <table  id="baseInfo" border="1" style="text-align: center; width: 100%;" >
            <tr><td height="35px"><h4><%=info.getTitle()%></h4></td></tr>
            <tr>
                <td height="30px">
                    <div style="width:100%; text-align:center;maring-top:10px;">
                        信息类型：<%=info.getType()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        创建人：<%=info.getCreator()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        来源：<%=info.getSource()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        创建时间：<fmt:formatDate value="<%=info.getCreateTime()%>" pattern="yyyy-MM-dd HH:MM"/>
                     </div>
                </td>
            </tr>
            <tr>
                <td height="500px">
                    <%=info.getContent()%>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
