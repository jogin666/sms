<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 22:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>角色管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form name="form1" action="" method="post">
<div class="p_d_1">
  <div class="p_d_1_1">
      <div class="content_info">

         <div class="c_crumbs"><div><b></b><strong>角色管理 </strong></div> </div>

          <div class="search_art">
              <li>
                  角色名称：<input type="text" name="roleName" cssClass="s_text" id="name"  cssStyle="width:160px;"/>
              </li>
              <li>
                  <input type="button" class="s_button" value="搜 索" onclick="doSearch()"/>
              </li>
              <li style="float:right;">
                  <input type="button" value="新增" class="s_button" onclick="doAdd()"/>&nbsp;
                  <input type="button" value="删除" class="s_button" onclick="doDeleteAll()"/>&nbsp;
              </li>
          </div>

          <div class="t_list" style="margin:0px; border:0px none;">

              <table width="100%" border="0">
              <tr class="t_tit">
                  <td width="30" align="center">
                      <input type="checkbox" id="selAll" onclick="doSelectAll()" value="全选" />
                  </td>
                  <td width="120" align="center">角色名称</td>
                      <td align="center">权限</td>
                  <td width="80" align="center">状态</td>
                  <td width="120" align="center">操作</td>
              </tr>
              <c:forEach var="item" items="${pageResult.items}">
                  <tr <c:if test="#st.odd">bgcolor="f8f8f8"</c:if>>
                      <td align="center">
                          <input type="checkbox" name="selectedRow" value="${item.roleId}"/>
                      </td>
                      <td align="center">${item.name}</td>
                      <td align="center">
                          <c:forEach var="rolePrivilegeEntity" items="${item.rolePrivileges}">
                                    ${rolePrivilegeEntity.rolePrivilegeEntityPK.code}&nbsp;
                          </c:forEach>
                      </td>
                      <td align="center">
                          <c:choose>
                              <c:when test="${item.state==1}">
                                  <c:out value="有效"></c:out>
                              </c:when>
                              <c:otherwise>
                                  <c:out value="无效"></c:out>
                              </c:otherwise>
                          </c:choose>
                      <td align="center">
                          <a href="javascript:doEdit('${item.roleId}')">编辑</a>
                          <a href="javascript:doDelete('${item.roleId}')">删除</a>
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
                              下一页&nbsp;&nbsp;
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

<script type="text/javascript" src='<%=path%>/js/jquery.min.js'></script>
<script type="text/javascript">

    //搜索
    function doSearch(){
        //重置页号
        $("#pageNo").val(1);
        document.forms[0].action = "<%=path%>/role/roleListUI.do";
        document.forms[0].submit();
    }

    //全选、全反选
    function doSelectAll(){
        $("input[name=selectedRow]").prop("checked", $("#selAll").is(":checked"));
    }

    //新增
    function doAdd(){
        document.forms[0].action ="<%=path%>/role/addRoleUI.do";
        document.forms[0].submit();
    }

    //编辑
    function doEdit(id){
        document.forms[0].action ="<%=path%>/role/editRoleUI.do?roleId=" + id;
        document.forms[0].submit();
    }

    //删除
    function doDelete(id){
        $.ajax({
            url:'<%=path%>/role/deleteRole.do',
            type:'post',
            data:{'roleId':id},
            dataType:'json',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    alert(backdata.msg);
                    window.location.href="<%=path%>/role/roleListUI.do";
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("操作失败！");
            }
        });
    }
    //批量删除
    function doDeleteAll(){
        var roleIds=new Array();
        var roleCheckBoxs=document.getElementsByName("selectedRow");
        for (i in roleCheckBoxs){
            if (roleCheckBoxs[i].checked){
                roleIds.push(roleCheckBoxs[i].value);
            }
        }
        $.ajax({
            type:'post',
            dataType:'json',
            data:{'selectedRow':roleIds},
            url:'<%=path%>/role/deleteSelectedRowRole.do',
            success:function (backdata) {
                if (backdata.tip=="success"){
                    window.location.href="<%=path%>/role/roleListUI.do";
                    alert(backdata.msg);
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("操作失败！");
            }
        });
    }

    //跳转页面
    function goPage() {
         /*获取输入框控件*/
        var pageValue = document.getElementById("pageValue");
        /*获取输入框的数据*/
        var value = pageValue.value;
        if(value<1 || value>${pageResult.pageCount}){
             alert("请输入合法数据");
            return false ;
        }
        window.location.href="<%=path%>/role/roleListUI.do?page="+value;
    }

</script>
</html>