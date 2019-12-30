<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/5/3
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.zy.sms.admin.entity.UserEntity" %>
<%@ page import="com.zy.sms.Constant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
    String headImg=path+"/images/home/user.png";
    UserEntity user= (UserEntity) request.getSession().getAttribute(Constant.USER);
    if (user!= null && !"".equals(user.getHeadImg())) {
        headImg =path+"/"+user.getHeadImg();
    }
    String msg= (String) request.getAttribute("msg");
%>
<html>
<head>
    <title>学生信息</title>
    <link href="<%=path%>/css/skin1.css" rel="stylesheet" type="text/css"/>
</head>
<body class="rightBody">
<form id="userInfoForm" name="form" action="" method="post" enctype="multipart/form-data">
    <<div class="vp_d_1">
    <div style="width:1%;float:left;">&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="vp_d_1_1">
        <div class="content_info">
            <div class="c_crumbs">
                    <div><b></b><strong>学生信息管理</strong>&nbsp;-&nbsp;编辑学生信息</div>
                </div>
                <div class="tableH2">编辑学生信息</div>
                <table id="baseInfo" width="60%" align="center" class="list" border="0" cellpadding="0" cellspacing="0"  >
                    <tr>
                        <td class="tdBg" width="200px">头像：</td>
                        <td>
                            <img src="<%=headImg%>" id="headImg" width="100" height="100"/>
                            <p><input type="file" id="userHeadImg" name="userHeadImg" onchange="changeFile();"/></p>
                        </td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">电子邮箱：</td>
                        <td><input type="email" id="email" name="email" value="${user.email}"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">手机号：</td>
                        <td><input type="text" id="mobile" name="mobile" value="${user.mobile}"/></td>
                    </tr>
                    <tr>
                        <td class="tdBg" width="200px">生日：</td>
                        <td>
                            <input type="date" value="${user.brithday}" id="brithday" name="brithday">
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="id" value="${user.id}"/>
                <div class="tc mt20">
                    <input type="button" class="btnB2" value="保存" onclick="doSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" class="btnB2" value="返回" onclick="backHome()" />
                </div>
            </div>
        </div>
    </div>
</form>
</body>
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
    //提交表单
    function changeFile() {
        var read=new FileReader(); // 创建FileReader对像;
        var headImgFile=document.getElementById("userHeadImg").files[0];
        read.readAsDataURL(headImgFile)  // 调用readAsDataURL方法读取文件;
        var userHeadImg=document.getElementById("headImg");
        read.onload=function(e) {
            url = this.result  // 拿到读取结果;
            userHeadImg.src = url;
        }
    }

    function doSubmit(){
        document.forms[0].action = "<%=path%>/home/saveEditUserInfo.do";
        document.forms[0].submit();
    }

    window.onload=new function () {
        var msg="<%=msg%>";
        if (msg!="null" && msg!=undefined){
            alert(msg);
        }
    }

    function backHome() {
        document.forms[0].action = "<%=path%>/home/showComplainAndInfo.do";
        document.forms[0].submit();
    }

    /*   function doSubmit(){
           $.ajax({
               url:'',
            dataType:'json',
            data:
            // data:{"brithday":brithday,
            // "mobile":mobile,"email":email},
            type:'post',
            success:function (backdata) {
                if (backdata.tip=="succcess"){
                    alert(backdata.msg);
                }else{
                    alert(backdata.msg);
                }
            },error:function () {
                alert("操作失败！");
            }
        });
    }*/
</script>
</html>