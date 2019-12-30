<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
    String msg= (String) request.getAttribute("Msg");
%>
<html>
<head>
    <title>角色管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form id="roleForm" name="form" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>角色管理</strong>&nbsp;-&nbsp;新增角色</div></div>
                <div class="tableH2">新增角色</div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                        <td class="tdBg" width="200px">角色名称：</td>
                        <td><input type="text" id="name" name="name" /></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">角色权限：</td>
                        <td>
                           <c:forEach items="${privilegeMap}" var="map">
                               <input type="checkbox" name="rolePrivilege" value="${map.value}">${map.value}&nbsp;
                           </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">状态：</td>
                        <td>
                            <input type="radio" name="state" value="1"/>有效&nbsp;
                            <input type="radio" name="state" value="0"/>无效
                        </td>
                    </tr>
                </table>

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
            var role=$("#roleForm").serializeArray(); //序列化表单数组
            $.ajax({
                type: "post",
                dataType:"json",
                data:role,
                url:"<%=path%>/role/saveRole.do",
                success: function (backdata) {
                    if(backdata.tip== "success"){
                        alert(backdata.msg);
                        window.location.href = "<%=path%>/role/roleListUI.do";
                    }else{
                        alert(backdata.tip);
                    }
                },error:function () {
                    alert("保存角色失败！");
                }
            });
        }
    }

    function check() {
        var name=$("#name")
        if (name.val()==""){
            alert("角色名不能为空！")
            name.focus();
            return false;
        }
        var privileges=$('input:checkbox[name="rolePrivilege"]:checked').val();
        if (privileges=="" || privileges==undefined){
            alert("角色权限不能为空！")
            return false;
        }
        var state=$('input:radio[name="state"]:checked').val();
        if (state=="" || state==undefined){
            alert("角色状态不能为空！")
            return false;
        }
        return true;
    }
</script>
</html>