<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/20
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>学生管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form id="form" name="form" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs">
                    <div><b></b><strong>学生管理</strong>&nbsp;-&nbsp;新增学生</div>
                </div>
                <div class="tableH2">新增学生</div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0"
                       cellspacing="0">
                    <tr>
                        <td class="tdBg" width="200px">所属部门：</td>
                        <td>
                            <select id="deptName" name="deptName"  style="width: 20%">
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
                        <td class="tdBg" width="200px">班级：</td>
                        <td>
                            <input type="text" id="className" name="className">
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">学生名：</td>
                        <td>
                            <input type="text" id="name" name="name">
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">学生性别：</td>
                        <td>
                            <input type="radio" name="gender" value="男">男
                            <input type="radio" name="gender" value="女">女
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">帐号：</td>
                        <td><input type="text" id="account" name="account" maxlength="11" minlength="11" onchange="doVerify()"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">密码：</td>
                        <td><input type="password" id="password" name="password"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">角色：</td>
                        <td>
                            <c:forEach items="${roleMap}" var="role">
                                <input type="checkbox" name="userRolePKs" value="${role.key}">${role.value}
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">手机号：</td>
                        <td><input type="text" id="mobile" name="mobile"></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">状态：</td>
                        <td>
                            <input type="radio" name="state" value="1"/>有效
                            <input type="radio" name="state" value="0"/>无效
                        </td>
                    </tr>
                </table>
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick=" doSubmit()"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" onclick="javascript:history.go(-1)" class="btnB2" value="返回"/>
                </div>
            </div>
        </div>
    </div>
</form>

</body>

<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">

    var Vresult = true;
    function doVerify() {
        var account = $("#account").val();
        $.ajax({
            type: "post",
            url: "<%=path%>/user/doVerify.do",
            async: false,  //非异步
            data: {"account": account},
            success: function (backdata) {
                //当存在的时候，告知账户已经存在了。
                if (backdata == "true") {
                    alert("该账户已经存在了！");
                    //聚焦
                    $("#account").focus();
                    Vresult = false;
                } else {
                    Vresult = true;
                }
            }
        });
    }

    function doSubmit() {
        if(doCheck()) {
            doVerify();
            //判断能否提交表单
            if (Vresult) {
                var data = $("#form").serializeArray();
                $.ajax({
                    type: 'post',
                    data: data,
                    dataType: 'json',
                    url: '<%=path%>/user/addUser.do',
                    success: function (backData) {
                        if (backData.tip == "success") {
                            alert(backData.msg);
                            window.location.href = "<%=path%>/user/userListUI.do?name=";
                        } else {
                            alert(backData.msg);
                        }
                    }, error: function () {
                        alert("添加失败！");
                    }
                });
            }
        }
    }

    function doCheck() {
        var deptName = $("#deptName option:selected");
        if (deptName.val()==""){
            alert("部门不能为空！");
            $("#deptName").focus();
            return false;
        }
        var className = $("#className");
        if(className.val() == ""){
            alert("班级不能为空！");
            className.focus();
            return false;
        }

        var name = $("#name");
        if(name.val() == ""){
            alert("学生名不能为空！");
            name.focus();
            return false;
        }
        var gender=$('input:radio[name="gender"]:checked').val();
        if(gender== "" || gender==undefined){
            alert("性别不能为空！");
            return false;
        }
        var account = $("#account");
        if(account.val() == ""){
            alert("账号不能为空！");
            account.focus();
            return false;
        }
        var password = $("#password");
        if(password.val() == ""){
            alert("密码不能为空！");
            password.focus();
            return false;
        }
        var userRolePKs=$('input:checkbox[name="userRolePKs"]:checked').val();
        if(userRolePKs== "" || userRolePKs==undefined){
            alert("角色不能为空！");
            return false;
        }
        var mobile = $("#mobile");
        if(mobile.val() == ""){
            alert("手机号码不能为空！");
            mobile.focus();
            return false;
        }
        var state=$('input:radio[name="state"]:checked').val();
        if(state== "" || state==undefined){
            alert("状态不能为空！");
            return false;
        }
        return true;
    }
</script>
</html>


