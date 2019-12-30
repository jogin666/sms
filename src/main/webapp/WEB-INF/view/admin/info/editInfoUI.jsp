<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                <div class="c_crumbs"><div><b></b><strong>信息发布管理</strong>&nbsp;-&nbsp;修改信息</div></div>
                <div class="tableH2">修改信息</div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                        <td class="tdBg" width="200px">信息类别：</td>
                        <td>
                            ${info.type}
                        </td>
                        <td class="tdBg" width="200px">来源：</td>
                        <td>
                            ${info.source}
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">信息标题：</td>
                        <td colspan="3">
                            <input type="text" id="title" name="title" value="${info.title}" cssStyle="width:90%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">信息内容：</td>
                        <td colspan="3">
                            <textarea id="content" name="content"cols="130" rows="10">${info.content}</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">创建人：</td>
                        <td width="350px">
                            &nbsp;&nbsp;${info.creator}
                            <input type="hidden" name="creator" value="${info.creator}"/>
                        </td>
                        <td class="tdBg" width="200px">创建时间：</td>
                        <td>
                            <fmt:formatDate value='${info.createTime}' pattern='yyyy-MM-dd HH:MM:ss'/>
                            <input type="hidden" name="createTime" value="${info.createTime}"/>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="source" value="${info.source}"/>
                <input type="hidden" name="infoId" value="${info.infoId}"/>
                <input type="hidden" name="state" value="${info.state}"/>
                <input type="hidden" name="type" value="${info.type}"/>
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="editInfo()" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button"  onclick="javascript:history.go(-1)" class="btnB2" value="返回" />
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script type="text/javascript" src='<%=path%>/js/jquery.min.js'></script>
<script type="text/javascript">
    //保存消息
    function editInfo() {
        if (check()) {
            var info=$("#infoForm").serializeArray(); //序列化表单数组
            $.ajax({
                url:"<%=path%>/info/saveEditInfo.do",
                type:'post',
                dataType:'json',
                data:info,
                async:false,
                success: function (backdata) {
                    if(backdata.msg == "success"){
                        //告诉用户，保存成功了。
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
        //消息标题
        var title=$("#title")
        if (title.val()==""){
            alert("消息类型不能为空！")
            title.focus();
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