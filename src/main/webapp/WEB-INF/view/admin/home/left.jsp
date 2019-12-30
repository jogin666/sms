<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <link href="<%=path%>/css/admin/css.css" rel="stylesheet" type="text/css"/>
</head>

<body>
<div class="xzfw" style="width: 210px;">
    <div class="xzfw_nav" style="width:214px;min-height:500px;background:#F8F8FF ">
        <div class="nBox" style="width:214px; height: 100%">
            <div class="sm">
                <dl class="">
                    <dt>
                        <a href="<%=path%>/role/roleListUI.do" target="mainFrame"><b></b>角色管理<s class="down"></s>
                        </a>
                    </dt>
                </dl>
                <dl class="">
                    <dt><a href="<%=path%>/user/userListUI.do" target="mainFrame"><b></b>学生管理<s class="down"></s>
                    </a></dt>
                </dl>

                <dl>
                    <dt><a href="<%=path%>/info/infoListUI.do" target="mainFrame"><b></b>信息发布管理<s
                            class="down"></s> </a></dt>
                </dl>
                <dl class="">
                    <dt><a href="<%=path%>/complain/complainListUI.do" target="mainFrame"><b></b>投诉受理管理<s
                            class="down"></s> </a></dt>
                </dl>
                <dl class="">
                    <dt><a href=""><b></b>易告知管理<s class="down"></s> </a></dt>
                </dl>
            </div>
        </div>
    </div>
</div>
</body>
</html>

