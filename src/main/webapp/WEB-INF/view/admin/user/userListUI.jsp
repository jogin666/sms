<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:59
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
    <meta http-equiv="Content-Type" content="multipart/form-data;charset=utf-8" />
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>

<body class="rightBody">
<form name="form1" action="" method="post" enctype="multipart/form-data">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>学生管理</strong></div> </div>
                <div class="search_art">
                    <li>
                        学生名：<input type="text" name="usrName" id="userName"  style="width:80px;"/>
                    </li>
                    <li>
                        班级：<input type="text" name="className" id="className" style="width:80px;"/>
                    </li>
                    <li><input type="button" class="s_button" value="搜 索" onclick="doSearch()"/></li>
                    <li style="float:right;">
                        <input type="button" value="新增" class="s_button" onclick="doAdd()"/>&nbsp;&nbsp;&nbsp;
                        <input type="button" value="删除" class="s_button" onclick="doDeleteAll()"/>&nbsp;&nbsp;&nbsp;
                        <input type="button" value="导出" class="s_button" onclick="doExportExcel()"/>&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;<input id="userExcel" name="userExcel" type="file"/>&nbsp;&nbsp;&nbsp;
                        <input type="button" value="导入" class="s_button" onclick="doImportExcel()"/>&nbsp;&nbsp;
                    </li>
                </div>

                <div class="t_list" style="margin:0px; border:0px none;">
                    <table width="100%" border="0">
                        <tr class="t_tit">
                            <td width="30" align="center">
                                <input type="checkbox" id="selAll" onclick="doSelectAll()" />
                            </td>
                            <td width="140" align="center">学生姓名</td>
                            <td width="140" align="center">帐号</td>
                            <td width="160" align="center">所属部门</td>
                            <td align="center">班级</td>
                            <td width="80" align="center">性别</td>
                            <td align="center">电子邮箱</td>
                            <td width="100" align="center">操作</td>
                        </tr>
                        <c:forEach items="${pageResult.items}" var="user">
                            <tr <c:if test="#st.odd"> bgcolor="f8f8f8" </c:if> >
                                <td align="center">
                                    <input type="checkbox" name="selectedRow" value="${user.id}" />
                                </td>
                                <td align="center">${user.name}</td>
                                <td align="center">${user.account}</td>
                                <td align="center">${user.deptName}</td>
                                <td align="center">${user.className}</td>
                                <td align="center">${user.gender}</td>
                                <td align="center">${user.email}</td>
                                <td align="center">
                                    <a href="javascript:doEdit('${user.id}')">编辑</a>
                                    <a href="javascript:doDelete('${user.id}')">删除</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="c_pate" style="margin-top: 5px;">
                <table width="100%" class="pageDown" border="0" cellspacing="0"
                       cellpadding="0">
                    <tr>
                        <td align="right">
                            总共[<font color="#00bfff">${pageResult.totalCount}</font>]条记录，
                            当前第[<font color="#00bfff">${pageResult.currentPage}</font>] 页，
                            共[<font color="#00bfff">${pageResult.pageCount}</font>]页 &nbsp;&nbsp;
                            <c:if test="${pageResult.pageCount>1}">
                                <a href="<%=path%>/user/userListUI.do?page=${pageResult.currentPage-1}">
                                    上一页&nbsp;&nbsp;
                                </a>
                            </c:if>
                            <c:if test="${pageResult.currentPage<pageResult.pageCount}">
                                <a href="<%=path%>/user/userListUI.do?page=${pageResult.currentPage+1}">
                                    下一页>&nbsp;&nbsp;
                                </a>
                            </c:if>
                            跳转到&nbsp;<input id="pageValue" type="number" style="width: 50px;"onchange="goPage()" min="1"/>&nbsp;页&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</form>

</body>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
    //搜索
    function doSearch(){
        document.forms[0].action ="<%=path%>/user/userListUI.do";
        document.forms[0].submit();
    }
    //全选、全反选
    function doSelectAll(){
        $("input[name=selectedRow]").prop("checked", $("#selAll").is(":checked"));
    }
    //新增
    function doAdd(){
        document.forms[0].action = "<%=path%>/user/addUserUI.do";
        document.forms[0].submit();
    }
    //编辑
    function doEdit(id){
        document.forms[0].action = "<%=path%>/user/editUserUI.do?id=" + id;
        document.forms[0].submit();
    }
    //删除
    function doDelete(id){
        $.ajax({
            url:'<%=path%>/user/deleteUser.do?',
            type:'post',
            data:{'id':id},
            dataType:'json',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    alert(backdata.msg);
                    window.location.href="<%=path%>/user/userListUI.do";
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("操作失败！");
            }
        });
        <%--document.forms[0].action = "<%=path%>/user/deleteUser.do?id=" + id;--%>
        <%--document.forms[0].submit();--%>
    }
    //批量删除
    function doDeleteAll(){
        var stuIds=new Array();
        var stuCheckBoxs=document.getElementsByName("selectedRow");
        for (i in stuCheckBoxs){
            if (stuCheckBoxs[i].checked){
                stuIds.push(stuCheckBoxs[i].value);
            }
        }
        $.ajax({
            type:'post',
            dataType:'json',
            data:{'selectedRow':stuIds},
            url:'<%=path%>/user/deleteSelectedUser.do',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    window.location.href="<%=path%>/user/userListUI.do";
                    alert(backdata.msg);
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("操作失败！");
            }
        });
    }
    //导出学生列表
    function doExportExcel(){
        window.open("<%=path%>/user/exportUserExcel.do");
    }
    //导入学生
    function doImportExcel(){
        <%--$.ajax({--%>
            <%--type:"post",--%>
            <%--dateType:'json',--%>
            <%--url:'<%=path%>/user/importUserExcel.do',--%>
            <%--success:function (backdata) {--%>
                <%--if (backdata.tip=="success"){--%>
                    <%--alert(backdata.msg)--%>
                    <%--document.forms[0].action = "<%=path%>/user/userListUI.do";--%>
                    <%--document.forms[0].submit();--%>
                <%--} else{--%>
                    <%--alert(backdata.msg)--%>
                <%--}--%>
            <%--},error:function () {--%>
                <%--alert("操作失败！")--%>
            <%--}--%>
        <%--});--%>
        document.forms[0].action = "<%=path%>/user/importUserExcel.do";
        document.forms[0].submit();
    }

    function goPage() {
        /*获取输入框控件*/
        var pageValue = document.getElementById("pageValue");
        /*获取输入框的数据*/
        var value = pageValue.value;
        if(value<1 || value>${pageResult.pageCount}){
            alert("请输入合法数据");
            return false ;
        }
        window.location.href="<%=path%>/user/userListUI.do?page="+value;
    }

</script>
</html>