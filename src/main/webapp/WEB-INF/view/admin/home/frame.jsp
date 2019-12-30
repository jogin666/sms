<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <base href="<%=path%>">
    <title>SSPU学生管理系统-管理员办公</title>
</head>
<frameset cols="*,1222,*" class="bj" frameborder="no" border="0" framespacing="0">
    <frame  scrolling="No" noresize="noresize" style="background:#F0FFFF"/>
    <frameset rows="156,*" cols="*" frameborder="no" border="0" framespacing="0">
        <frame src="<%=path%>/admin/home/topUI.do" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" />
        <frameset cols="14%,60%" frameborder="no" border="0" framespacing="0">
            <frame src="<%=path%>/admin/home/leftUI.do" scrolling="yes" noresize="noresize" id="leftFrame" />
            <frame src="<%=path%>/admin/home/welcome.do" name="mainFrame" id="mainFrame" />
        </frameset>
    </frameset>
    <frame scrolling="No" noresize="noresize" style="background:#F0FFFF"/>
</frameset>
<body>
<br>
</body>
</html>
