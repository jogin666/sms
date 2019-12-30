<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 21:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>用户管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form id="form" name="form" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>用户管理</strong>&nbsp;-&nbsp;编辑用户</div></div>
                <div class="tableH2">编辑用户</div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                        <td class="tdBg" width="200px">所属部门：</td>
                        <td>
                            <select id="deptName" name="deptName"  style="width: 10%">
                                <option></option>
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
                        <td class="tdBg" width="200px">用户名：</td>
                        <td><input type="text" id="name" name="name" value="${user.name}"/> </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">帐号：</td>
                        <td>
                            ${user.account}
                            <input type="hidden"  id="account" name="account" value="${user.account}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">班级：</td>
                        <td>
                            <input type="text"  id="className" name="className" value="${user.className}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">密码：</td>
                        <td><input type="password" id="password" name="password" value="${user.password}"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">角色：</td>
                        <td>
                            <c:forEach items="${userRole}" var="userRole">
                                <input type="checkbox" name="userRolePKs" value="${userRole.key}" checked/>${userRole.value}
                            </c:forEach>
                            <c:forEach items="${roles}" var="role">
                                <input type="checkbox" name="userRolePKs" value="${role.key}"/>${role.value}
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">用户状态：</td>
                        <td>
                            <input type="radio" name="state" value="1" <c:if test="${user.state==1}"> checked </c:if>/>有效
                            <input type="radio" name="state" value="0" <c:if test="${user.state==0}"> checked </c:if> >无效
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="id" value="${user.id}"/>
                <input type="hidden" name="headImg" value="${user.headImg}">
                <input type="hidden" name="email" value="${user.email}">
                <input type="hidden" name="gender" value="${user.gender}">
                <input type="hidden" name="mobile" value="${user.mobile}">
                <input type="hidden" name="memo" value="${user.memo}">
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="doSubmit()" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button"  onclick="javascript:history.go(-1)" class="btnB2" value="返回" />
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">

    //提交表单
    function doSubmit(){
        var name = $("#name");
        if(name.val() == ""){
            alert("用户名不能为空！");
            name.focus();
            return false;
        }
        var password = $("#password");
        if(password.val() == ""){
            alert("密码不能为空！");
            password.focus();
            return false;
        }
        var deptName = $("#deptName option:selected").val();
        if (deptName==""){
            alert("部门不能为空！");
            $("#deptName").focus();
            return false;
        }
        var className = $("#className");
        if(className.val() == ""){
            alert("密码不能为空！");
            className.focus();
            return false;
        }

        //提交表单
        var data=$("#form").serializeArray();
        $.ajax({
            url:'<%=path%>/user/saveEditUser.do',
            type:'post',
            dataType:'json',
            data:data,
            success:function (backData) {
                if (backData.tip=="success") {
                    alert(backData.msg);
                    window.location.href = "<%=path%>/user/userListUI.do";
                }else {
                    alert(backData.msg);
                }
            },error:function () {
                alert("编辑失败！");
            }
        });
    }
</script>
</html>