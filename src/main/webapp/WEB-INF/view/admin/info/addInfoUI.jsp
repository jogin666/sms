<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
    <title>信息发布管理</title>
</head>
<body class="rightBody">
<form id="infoForm" name="form" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>信息发布管理</strong>&nbsp;-&nbsp;新增信息</div></div>
                <div class="tableH2">新增信息</div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                        <td class="tdBg" width="200px">信息类别：</td>
                        <td>
                            <select id="type" name="type"  style="width: 60%;height:98%">
                            <c:forEach items="${infoTypeMap}" var="item">
                                <option value="${item.value}">${item.value}</option>
                            </c:forEach>
                        </td>
                        <td class="tdBg" width="200px">来源：</td>
                        <td>
                            <select id="source" name="source"  style="width: 60%;height: 98%">
                                <option value="工学部">工学部</option>
                                <option value="文理学部">文理学部</option>
                                <option value="经管与管理学院">经管与管理学院</option>
                                <option value="应用艺术设计学院">应用艺术设计学院</option>
                                <option value="高等职业技术（国际）学院">高等职业技术（国际）学院</option>
                                <option value="国际交流学院">国际交流学院</option>
                                <option value="继续教育学院">继续教育学院</option>
                                <option value="体育部">体育部</option>
                                <option value="马克思主义学院">马克思主义学院</option>
                                <option value="工程训练中心">工程训练中心</option>
                                <option value="艺术教育中心">艺术教育中心</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">信息标题：</td>
                        <td colspan="3">
                            <input id="title" type="text" name="title" cssStyle="width:90%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">信息内容：</td>
                        <td colspan="3">
                            <textarea id="content" name="content" cols="130" rows="10"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">创建人：</td>
                        <td width="350px">
                            &nbsp;&nbsp;${sessionScope.XSGL_USER.name}
                            <input type="hidden" name="creator" value="${sessionScope.XSGL_USER.name}"/>
                        </td>
                        <td class="tdBg" width="200px">创建时间：</td>
                        <td>
                            <fmt:formatDate value='${time}' pattern='yyyy-MM-dd HH:MM:ss'/>
                            <input type="hidden" name="createTime" value="${time}"/>
                        </td>
                    </tr>
                </table>
                <!-- 默认信息状态为 发布 -->
                <input type="hidden" name="state" value="1"/>
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="saveInfo()" />&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button"  onclick="javascript:history.go(-1)" class="btnB2" value="返回" />
                </div>
            </div>
        </div>
    </div>
</form>
</body>

<script type="text/javascript" src='<%=path%>/js/jquery.min.js'></script>
<script type="text/javascript">
    //保存投诉
    function saveInfo() {
        if (check()) {
            var info=$("#infoForm").serializeArray(); //序列化表单数组
            $.ajax({
                type: "post",
                dataType:"json",
                data:info,
                url:"<%=path%>/info/saveInfo.do",
                success: function (backdata) {
                    if(backdata.msg == "success"){
                        //提示
                        alert(backdata.tip);
                        //返回首页
                        window.location.href = "<%=path%>/info/infoListUI.do";
                    }else{
                        alert(backdata.tip);
                    }
                },error:function () {
                    alert("保存信息失败了！");
                }
            });
        }
    }

    function check() {
        //消息类型
        var type=$("#type")
        if (type.val()==""){
            alert("消息类型不能为空！")
            type.focus();
            return false;
        }
        //消息标题
        var title=$("#title")
        if (title.val()==""){
            alert("消息标题不能为空！")
            title.focus();
            return false;
        }
        //消息来源
        var source=$("#source")
        if (source.val()==""){
            alert("消息来源不能为空！")
            source.focus();
            return false;
        }
        //内容
        var content=$("#content")
        if (content.val()==""){
            alert("消息内容不能为空！")
            content.focus();
            return false;
        }
        return true;
    }
</script>
</html>