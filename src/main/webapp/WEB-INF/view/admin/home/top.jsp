<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 18:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/home.css"/>
</head>

<body>

<table width="1222" border="0" align="center" cellpadding="0" cellspacing="0" background="<%=path%>/images/admin/xingzheng.png" class="top">
    <tr>
        <td width="26" height="106">&nbsp;</td>
        <td width="416" height="110" align="left" valign="middle">
            <img class="zxx_test_png" src="<%=path%>/images/home/sspu.png" width="470" height="90" alt="" />
        </td>
        <td width="135">&nbsp;</td>

        <td width="300" align="right" valign="top">
            <table width="350" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="17" height="9"></td>
                    <td width="66" height="9"></td>
                    <td width="120" height="5"></td>
                    <td width="17" height="9"></td>
                    <td width="36" height="9"></td>
                    <td width="17"></td>
                    <td width="46"></td>
                </tr>
                <tr>
                    <td align="center"></td>
                    <td align="left"></td>
                    <td align="left"><a><b></b><font color="red">欢迎您，${sessionScope.XSGL_USER.account}</font></a></td>
                    <td align="center"><img src="<%=path%>/images/admin/help.png" width="12"height="17" /></td>
                    <td align="left"><a href="javascript:void(0)"><font color="black" size="2px">帮助</font></a></td>
                    <td width="17" align="center"><img src="<%=path%>/images/admin/exit.png"width="14" height="14"/></td>
                    <td align="left" valign="middle"><a href="<%=path%>/login/loginOut.do" target="_parent"><font color="black" size="2px">退出</font></a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<div class="menu" style="background:#87CEFA">
    <ul>
        <li><a href="<%=path%>/home/homeUI.do;" target="_parent">OA办公</a></li>
        <li><a href="javascript:void(0);">在线学习</a></li>
        <li><a href="javascript:void(0);">教务系统</a></li>
        <li><a href="javascript:void(0);">教师办公</a></li>
        <li><a href="javascript:void(0)">管理员办公</a></li>
        <li><a href="javascript:void(0);">我的空间</a></li>
    </ul>
</div>


</body>
</html>