<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/27
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <title>投诉受理管理</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">

<form id="form" name="form" action="" method="post">
    <div class="p_d_1">
        <div class="p_d_1_1">
            <div class="content_info">
                <div class="c_crumbs"><div><b></b><strong>投诉受理管理</strong>&nbsp;-&nbsp;投诉受理</div></div>
                <div class="tableH2">投诉详细信息<span style="color:red;">(${type})</span></div>
                <table id="baseInfo" width="100%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr><td colspan="2" align="center">投诉人信息</td></tr>
                    <tr>
                        <td class="tdBg" width="260px">是否匿名：</td>
                        <td>
                            <c:choose>
                                <c:when test="${complain.isNm==1}">匿名</c:when>
                                <c:otherwise >不匿名</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人部门：</td>
                        <td>
                            <c:if test="${complain.isNm==0}">${complain.compDept}</c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人姓名：</td>
                        <td>
                            <c:if test="${complain.isNm==0}">${complain.compName}</c:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉人手机：</td>
                        <td>
                            <c:if test="${complain.isNm==0}">${complain.compMoblie}</c:if>
                        </td>
                    </tr>
                    <tr><td colspan="2" align="center">投诉信息</td></tr>
                    <tr>
                        <td class="tdBg">投诉时间:</td>
                        <td>
                          <fmt:formatDate value="${complain.compTime}" pattern='yyyy-MM-dd HH:MM:ss'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">被投诉部门：</td>
                        <td>${complain.toCompDept}</td>
                    </tr>
                    <tr>
                        <td class="tdBg">被投诉人：</td>
                        <td>${complain.toCompName}</td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉标题：</td>
                        <td>${complain.compTitle}</td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉内容：</td>
                        <td>${complain.compContent}</td>
                    </tr>
                    <tr><td colspan="2" align="center">受理信息</td></tr>
                    <tr>
                        <td colspan="2">
                            <c:forEach items="${complain.complainReplies}" var="replyer">
                                <fieldset style="border: solid 1px #c0c0c0;margin-top:5px;">
                                    <legend style="color:green;font-weight:bold;">
                                        回复<c:if test="${complain.isNm==0}">${complain.compName}</c:if> &nbsp;
                                    </legend>
                                    <div style="width:100%; text-align:center;color:#ccc;maring-top:5px;">
                                        回复部门：${replyer.replyerDept}&nbsp;&nbsp;
                                        回复人：${replyer.replyer}&nbsp;&nbsp;
                                        回复时间：  <fmt:formatDate value="${replyer.replyTime}" pattern='yyyy-MM-dd HH:MM:ss'/>
                                    </div>
                                    <div style="width:100%;maring-top:10px;font-size:13px;padding-left:5px; text-align: center; padding: 5px">
                                       ${replyer.replyContent}
                                    </div>
                                </fieldset>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr><td colspan="2" align="center">受理操作</td></tr>
                    <tr>
                        <td class="tdBg">回复部门：</td>
                        <td>
                            ${sessionScope.XSGL_USER.deptName}
                            <input type="hidden" name="replyerDept" value=" ${sessionScope.XSGL_USER.deptName}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">回复人：</td>
                        <td>
                            ${sessionScope.XSGL_USER.name}
                            <input type="hidden" name="replyer" value=" ${sessionScope.XSGL_USER.name}"/>
                        </td>
                    </tr>

                    <tr>
                        <td class="tdBg" width="200px">回复内容：</td>
                        <td>
                            <textarea id="replyContent" name="replyContent" cols="130" rows="10"></textarea>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="compId" value="${complain.compId}"/>
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="sumbit()" />
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

    function sumbit() {
        if (check()){
            var data=$("#form").serializeArray();
            $.ajax({
                url:'<%=path%>/complain/dealComplain.do',
                type:'post',
                data:data,
                dataType:'json',
                success:function (backdata) {
                    if (backdata.tip=="success"){
                        alert(backdata.msg);
                        window.location.href="<%=path%>/complain/complainListUI.do";
                    }else{
                        alert(backdata.msg);
                    }
                },error:function () {
                    alert("受理失败！");
                }

            });
        }
    }

    function check() {
        var replyContent=$("#replyContent");
        if (replyContent.val()==""){
            alert("回复内容为空！");
            replyContent.focus();
            return false;
        }
        return true;
    }
</script>
</html>