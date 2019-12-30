<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
    String massage= (String) request.getAttribute("Msg");
    request.removeAttribute("Msg");
%>
<html>
<head>
    <title>信息发布管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form name="form1" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>信息发布管理</strong></div> </div>
                <div class="search_art">
                    <li>
                        信息标题：<input type="text" name="infoTitle" cssClass="s_text" id="infoTitle"  cssStyle="width:160px;"/>
                    </li>
                    <li><input type="button" class="s_button" value="搜 索" onclick="doSearch()"/></li>
                    <li style="float:right;">
                        <input type="button" value="新增" class="s_button" onclick="doAdd()"/>&nbsp;
                        <input type="button" value="删除" class="s_button" onclick="doDeleteAll()"/>&nbsp;
                    </li>
                </div>

                <div class="t_list" style="margin:0px; border:0px none;">
                    <table width="100%" border="0">
                        <tr class="t_tit">
                            <td width="30" align="center"><input type="checkbox" id="selAll" onclick="doSelectAll()" /></td>
                            <td align="center">信息标题</td>
                            <td width="120" align="center">信息分类</td>
                            <td width="120" align="center">创建人</td>
                            <td width="140" align="center">创建时间</td>
                            <td width="80" align="center">状态</td>
                            <td width="120" align="center">操作</td>
                        </tr>
                        <c:forEach items="${pageResult.items}" var="item">
                            <tr<c:if test="#st.odd"> bgcolor="f8f8f8" </c:if> >
                                <td align="center">
                                    <input type="checkbox" name="selectedRow" value="${item.infoId}"/>
                                </td>
                                <td align="center">${item.title}</td>
                                <td align="center">${item.type}</td>
                                <td align="center">${item.creator}</td>
                                <td align="center">${item.createTime}</td>
                                <td id="show_${item.infoId}" align="center">
                                    <c:choose>
                                        <c:when test="${item.state==1}">发布</c:when>
                                        <c:otherwise>停用</c:otherwise>
                                    </c:choose>
                                <td align="center">
                                	<span  id="oper_${item.infoId}">
                                        <c:choose>
                                            <c:when test="${item.state==1}">
                                                <a href="javascript:doPublic('${item.infoId}',0)">停用</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:doPublic('${item.infoId}',1)">发布</a>
                                            </c:otherwise>
                                        </c:choose>
                                	</span>
                                    <a href="javascript:doEdit('${item.infoId}')">编辑</a>
                                    <a href="javascript:doDelete('${item.infoId}')">删除</a>
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
        document.forms[0].action = "<%=path%>/info/infoListUI.do";
        document.forms[0].submit();
    }

    //全选 全反选
    function doSelectAll(){
        $("input[name=selectedRow]").prop("checked", $("#selAll").is(":checked"));
    }

    //新增
    function doAdd(){
        document.forms[0].action = "<%=path%>/info/addInfoUI.do";
        document.forms[0].submit();
    }

    //编辑
    function doEdit(id){
        document.forms[0].action = "<%=path%>/info/editInfoUI.do?infoId=" + id;
        document.forms[0].submit();
    }

    //删除
    function doDelete(id){
        $.ajax({
            url:'<%=path%>/info/deleteInfo.do?',
            type:'post',
            data:{'infoId':id},
            dataType:'json',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    alert(backdata.msg);
                    window.location.href="<%=path%>/info/infoListUI.do";
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("删除信息失败！");
            }
        });
    }

    //批量删除
    function doDeleteAll(){
        var infoIds=new Array();
        var infoCheckBoxs=document.getElementsByName("selectedRow");
        for (i in infoCheckBoxs){
            if (infoCheckBoxs[i].checked){
                infoIds.push(infoCheckBoxs[i].value);
            }
        }
        $.ajax({
            url:'<%=path%>/info/deleteSelectedInfo.do',
            type:'post',
            data:{'infoIds':infoIds},
            dataType:'json',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    alert(backdata.msg);
                    window.location.href="<%=path%>/info/infoListUI.do";
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("删除信息失败！");
            }
        });
    }

    //异步发布信息,信息的id和要改成的信息状态
    function doPublic(infoId, state){
        //更新信息状态
        $.ajax({
            url:"<%=path%>/info/publicInfo.do",
            data:{"infoId":infoId, "state":state},
            type:"post",
            success: function(msgMap){
                //更新状态栏、操作栏的显示值
                if(msgMap.msg=="success"){
                    if(state == 1){
                        //说明信息状态已经被改成 发布，状态栏显示 发布，操作栏显示 停用
                        $("#show_"+infoId).html("发布");
                        $("#oper_"+infoId).html('<a href="javascript:doPublic(\''+infoId+'\',0)">停用</a>');
                    } else {
                        $("#show_"+infoId).html("停用");
                        $("#oper_"+infoId).html('<a href="javascript:doPublic(\''+infoId+'\',1)">发布</a>');
                    }
                    alert(msgMap.tip)
                } else {
                    alert(msgMap.tip);
                }
            }, error: function(){
                alert("更新信息状态失败！");
            }
        });
    }

    //跳转页面
    function goPage() {
        //获取输入框控件
        var pageValue = document.getElementById("pageValue");
        //获取输入框的数据
        var value = pageValue.value;
        if(value<1 || value>${pageResult.pageCount}){
            alert("请输入合法数据");
            return false ;
        }
        window.location.href="<%=path%>/info/infoListUI.do?page="+value;
    }
</script>
</html>