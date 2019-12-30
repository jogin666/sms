<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/20
  Time: 13:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <base href="<%=path%>">
    <title>系统异常信息</title>
</head>
<body>
<c:choose>
    <c:when test="${exceptionMsg!=null}">
            操作失败！&nbsp;&nbsp;${exceptionMsg}
    </c:when>
    <c:otherwise>
        请求失败！
    </c:otherwise>
</c:choose>
</body>
</html>

