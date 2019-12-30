<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/23
  Time: 20:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setAttribute("basePath", request.getContextPath());
%>
<html>
<head>
    <title>我要投诉</title>
</head>

<script type="text/javascript" src="${basePath}/js/jquery.min.js"></script>
<link href="${basePath}/css/skin1.css" rel="stylesheet" type="text/css"/>

<body>
<form id="comPlainForm" name="form" action="" method="post" enctype="multipart/form-data">
    <div class="vp_d_1">
        <div style="width:1%;float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="vp_d_1_1">
            <div class="content_info">
                <div class="c_crumbs">
                    <div><b></b><strong>工作主页</strong>&nbsp;-&nbsp;我要投诉</div>
                </div>
                <div class="tableH2">我要投诉</div>

                <table id="baseInfo" width="80%" align="center" class="list" border="0" cellpadding="0"
                       cellspacing="0">
                    <tr>
                        <td class="tdBg" width="250px">投诉标题：</td>
                        <td><input type="text" id="compTitle" name="compTitle"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg">被投诉人部门：</td>
                        <td>
                            <select id="toCompDept" name="toCompDept" onchange="doSelectDept()" style="width: 10%">
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
                        <td class="tdBg">被投诉人姓名：</td>
                        <td>
                            <select name="toCompName" id="toCompName" style="width: 10%"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">投诉内容：</td>
                        <td>
                            <textarea name="compContent" id="compContent" rows="8" cols="8" style="width:100%"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg">是否匿名投诉：</td>
                        <td>
                            <input type="radio" name="isNm" id="isNm1" value="1">匿名
                            <input type="radio" name="isNm" id="isNm2" value="0">不匿名
                        </td>
                    </tr>
                </table>

                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="saveComplain()"/>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" onclick="javascript:window.close()" class="btnB2" value="关闭"/>
                </div>
            </div>
        </div>
        <div style="width:1%;float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>

</form>
</body>

<script type="text/javascript">
    /**
     * 每次选择部门后，想后台请求该部门的所有人
     */
    function doSelectDept() {
        //投诉的部门的值
        var deptName = $("#toCompDept option:selected").val();
        //清空投诉人
        if(deptName.length==0){
            $("#toCompName").empty();
        }
        //获取选地部门之后的用户信息
        $.ajax({
            type: "post",
            data: {"deptName":deptName},
            dataType: "json",//返回的数据类型
            url: "${basePath}/home/getUserInfo.do",
            success: function (data) {
                if("success" == data.Msg){
                    var toCompName = $("#toCompName");
                    toCompName.empty();
                    $.each(data.userList, function(index, user){
                        toCompName.append("<option value='" + user.name + "'>" + user.name + "</option>");
                    });
                } else {alert("获取被投诉人列表失败！");}
            }, error: function () {
                alert("失败咯")
            }
        });
    }

    //保存投诉
    function saveComplain() {
        if (checkEmpty()) {
            var comp=$("#comPlainForm").serializeArray(); //序列化表单数组
            $.ajax({
                type: "post",
                dataType:"json",
                data:comp,
                url:"${basePath}/home/saveComplain.do",
                // contentType:'application/json;charset=utf-8', //？？
                success: function (backdata) {
                    if(backdata.msg == "success"){
                        //告诉用户，保存成功了。
                        alert("投诉成功！！！");
                        //把父窗口刷新
                        window.opener.parent.location.reload(true);
                        //把本页面关闭
                        window.close();
                    }
                },error:function () {
                    alert("保存投诉信息失败了！");
                }
            });
        }
    }

    function checkEmpty(){
        var title=$("#compTitle").val();
        if (title=="" || title==null){
            alert("标题不能为空！");
            return false;
        }

        var deptName = $("#toCompDept option:selected").val();
        if(deptName=="" || deptName==null){
            alert("被投诉人的部门不能为空！");
            return false;
        }

        var toCompName=$("#toCompName option:selected").val();
        if (toCompName==null || toCompName==""){
            alert("被投诉人不能为空！");
            return false;
        }

        var compContent=$("#compContent").val();
        if (compContent==null || compContent==""){
            alert("投诉内容不能为空！");
            return false;
        }

        var isNM=$('input:radio[name="isNm"]:checked').val();
        if (isNM=="" || isNM==null){
            alert("你为选投诉类型！");
            return false;
        }
        // var tag=false;
        // var radios = document.getElementsByName("radio");
        // for(radio in radios) {
        //     if(radios[radio].checked) {
        //         tag = true;
        //         break;
        //     }
        // }
        // if (!tag){
        //     alert("你为选投诉类型！")
        //     return false;
        // }
        return true;
    }

</script>
</html>