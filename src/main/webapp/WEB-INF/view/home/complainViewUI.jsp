<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/25
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.zy.sms.admin.entity.ComplainEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("basePath", request.getContextPath()) ;
    //投诉主体
    ComplainEntity complain = (ComplainEntity) request.getSession().getAttribute("complain");
    String type= (String) request.getSession().getAttribute("type"); //类型
    String isNM= (String) request.getSession().getAttribute("isNM"); //是否匿名
%>
<html>
<head>
    <title>投诉信息</title>
</head>
<link href="${basePath}/css/skin1.css" rel="stylesheet" type="text/css"/>

<body class="rightBody">
    <div class="vp_d_1">
    <div style="width:1%;float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="vp_d_1_1">

            <div class="content_info">
                <div class="c_crumbs">
                    <div><b></b><strong>工作主页</strong>&nbsp;-&nbsp;投诉信息</div>
                </div>
                <%
                    try{
                %>
                <div class="tableH2">投诉详细信息<span style="color:red;">(<%=type%>)</span></div>

                <table id="baseInfo" width="60%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr><td colspan="2" align="center">投诉人信息</td></tr>
                    <tr>
                        <td class="tdBg" width="250px">是否匿名投诉：</td>
                        <td><%=isNM%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人单位：</td>
                        <td><%=complain.getCompDept()%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人姓名：</td>
                        <td><%=complain.getCompName()%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人手机：</td>
                        <td><%=complain.getCompMoblie()%></td>
                    </tr>
                    <tr><td colspan="2" align="center">投诉信息</td></tr>
                    <tr>
                        <td class="tdBg">投诉时间：</td>
                        <td><ftm:formatDate value="<%=complain.getCompTime()%>" pattern="yyyy-MM-dd HH:MM"/> </td>
                    </tr>
                    <tr>
                        <td class="tdBg">被投诉部门：</td>
                        <td><%=complain.getToCompDept()%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">被投诉人：</td>
                        <td><%=complain.getToCompName()%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉标题：</td>
                        <td><%=complain.getCompTitle()%></td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉内容：</td>
                        <td><%=complain.getCompContent()%></td>
                    </tr>
                    <tr><td colspan="2" align="center">受理信息</td></tr>
                    <tr>
                        <td colspan="2">
                            <c:forEach items="${complainReplies}" var="replyer">
                                <fieldset style="border: solid 1px #c0c0c0;margin-top:5px;">
                                    <legend style="color:green;font-weight:bold;">回复(<%=complain.getCompName()%>)</legend>
                                    <div style="width:100%; text-align:center;color:#ccc;maring-top:5px;">
                                        回复部门：${replyer.replyerDept}&nbsp;&nbsp;
                                        回复人：${replyer.replyer}&nbsp;&nbsp;
                                        回复时间：<fmt:formatDate value="${replyer.replyTime}" pattern="yyyy-MM-dd HH:MM"/>
                                    </div>
                                    <div style="width:100%;maring-top:10px;font-size:13px;padding-top:5px; text-align: center">
                                            ${replyer.replyContent}
                                    </div>
                                </fieldset>
                            </c:forEach>
                            <span id="replyers"></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align:center;">
                            <input type="button" class="btnB2" onclick="javascript :history.back(-1)" value="返回"/>
                        </td>
                    </tr>
                </table>
                <%
                    }catch (Exception e){ }
                %>
            </div>
        </div>
    <div style="width:1%;float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
</body>
</html>


