<%--
  Created by IntelliJ IDEA.
  User: 99447
  Date: 2019/4/18
  Time: 18:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=request.getContextPath();
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="cas"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/login/login.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/login/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/login/custom.css">
    <!-- 主样式CSS -->
</head>

<body>
<!-- header -->
<div class="header">
    <div class="logo">
        <img src="<%=path%>/images/login/logo.png" class="login-logo">
    </div>
</div>
<div class="slides">
    <div class="nav">
        <a class="prev" href="javascript:;"></a> <a class="next" href="javascript:;"></a>
    </div>

    <div class="login">
        <div class="login-box">
            <div class="login-bag">
                <p class="login-bag-title">
                    <img src="<%=path%>/images/login/login-bag-title.png">
                </p>
                <form id="form1" name="form1" class="fm-v clearfix" action="<%=path%>/login/login.do" method="post" autocomplete="off">
                    <div class="input-box">
                        <input type="text" name="account" id="account" placeholder="请输入您的学/工号" class="login-username" value="">
                        <div class="error-box hide" style="right:-62px;margin-top:-9px;">
                            <span class="fa fa-minus-circle"></span>&nbsp;
                            <span id="loginUserError"></span>
                            <button id="loginUserErrorTrigger" type="button" class="hide"></button>
                        </div>
                    </div>
                    <div class="input-box">
                        <input type="password" name="password" id="password" placeholder="请输入您的密码" class="login-password">
                        <div class="error-box hide" style="right:-48px">
                            <span class="fa fa-minus-circle"></span>&nbsp;
                            <span id="loginPwdError"></span>
                            <button id="loginPwdErrorTrigger" type="button" class="hide"></button>
                        </div>
                    </div>
                    <div class="input-box login-yzm-box" id="imageCode">
                        <img src="<%=path%>/images/cas/codeimage" class="login-yzm-box-img"
                             onclick="this.src='images/cas/codeimage?'+Math.floor(Math.random()*100)"/>
                        <input type="text" name="imageCodeName" id="imageCodeName" placeholder="请输入验证码" class="login-yzm">
                        <input id="errors" name="errors" type="hidden" value="0"/>
                        <div class="error-box hide" style="top:17%;right:-62px">
                            <span class="fa fa-minus-circle"></span>&nbsp;
                            <span id="loginYzmError"></span>
                            <button id="loginYzmErrorTrigger"  type="button" class="hide"></button>
                        </div>
                    </div>
                    <div class="login-submit-box">
                        <p class="login-submit-box-forget">
                            <a href="" target="_blank">忘记密码？</a>
                        </p>
                        <button type="submit" class="submit_button"
                                onclick="javascript:return checkInput();">登录</button>
                        <div id="errormsg" class="hide"></div>
                    </div>
                    <input type="hidden" name="lt" value=""/>
                    <input type="hidden" name="_eventId" value="submit" />
                </form>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <div class="footer-bottom">
			<span>
				CopyRight&nbsp;&nbsp;&nbsp;©2018&nbsp;&nbsp;&nbsp;上海第二工业大学
			</span>
    </div>
</div>

</body>
<script type="text/javascript" src='<%=path%>/js/jquery.min.js'></script>
<script type="text/javascript">

    $(document).ready(function(){

        $('#account').focus(); //初始聚焦account输入框
        if ("" != "") {
            $('#password').focus();
        }

        //是否显示账号的提示错误
        $("#loginUserErrorTrigger").click(function(){
            var txtVal = $("#loginUserError").text();
            if(txtVal == null || txtVal.trim() == ""){
                $("#loginUserError").parent(".error-box").addClass("hide");
            }else{
                $("#loginUserError").parent(".error-box").removeClass("hide");
            }
        });

        //是否显示密码的错误
        $("#loginPwdErrorTrigger").click(function(){
            var txtVal = $("#loginPwdError").text();
            if(txtVal == null || txtVal.trim() == ""){
                $("#loginPwdError").parent(".error-box").addClass("hide");
            }else{
                $("#loginPwdError").parent(".error-box").removeClass("hide");
            }
        });

        //是否显示验证码
        $("#loginYzmErrorTrigger").click(function(){
            var txtVal = $("#loginYzmError").text();
            if(txtVal == null || txtVal.trim() == ""){
                $("#loginYzmError").parent(".error-box").addClass("hide");
            }else{
                $("#loginYzmError").parent(".error-box").removeClass("hide");
            }
        });

        //获取request中的返回的错误
        var errorMsg='${errorMsg}';
        //显示错误
        if(errorMsg != null && errorMsg.trim() != ""){
            if(errorMsg.indexOf("账号") == 0){
                $("#loginUserError").text(errorMsg);
                $("#loginUserErrorTrigger").click();
            }else if(errorMsg.indexOf("密码") == 0){
                $("#loginPwdError").text(errorMsg);
                $("#loginPwdErrorTrigger").click();
            }else if(errorMsg.indexOf("验证码") == 0){
                $("#loginYzmError").text(errorMsg);
                $("#loginYzmErrorTrigger").click();
            }else{
                $("#errormsg").removeClass("hide"); //移除样式（隐藏）
            }
        }

    });

    //失去焦点后判断
    $("input[name='account']").blur(function(){
        var m=/^(.+)?[a-zA-Z]+(.+)?$/;
        if(!m.test(document.getElementById('account').value)){
            if(document.getElementById('account').value != ""){
                var o='';
                var tmp= document.getElementById('account').value;
                for(var i=0;i<11-tmp.length;i++){o=o+'0';}
                document.getElementById('account').value=o+tmp;
            }
        }
    })

</script>

<script type="text/javascript">
    //错误次数
    var errors = 0;
    var errorTimes = 2; //密码超过两次错误，需要输入验证码

    function checkImageCodeDisplay() {
        if (errorTimes == -1 || errors < errorTimes) {
            document.getElementById("imageCode").style.display = "none";
        } else {
            document.getElementById("imageCode").style.display = "";
        }
    }
    checkImageCodeDisplay();

    //账号密码为空时，显示提示
    function checkInput() {
        var userAccount = document.getElementById("account");
        var password = document.getElementById("password");
        //检测输入
        if (userAccount.value=="") {
            $("#loginUserError").text("请输入登录名");
            $("#loginUserErrorTrigger").click();
            return false;
        }else{
            $("#loginUserError").text("");
            $("#loginUserErrorTrigger").click();
        }

        if (password.value=="") {
            $("#loginPwdError").text("请输入密码");
            $("#loginPwdErrorTrigger").click();
            return false;
        }else{
            $("#loginPwdError").text("");
            $("#loginPwdErrorTrigger").click();
        }

        //错误次数超两次，需要输入验证码
        if (errorTimes == -1 || errors < errorTimes) { }
        else {
            imageCodeName = document.getElementById("imageCodeName");
            if (imageCodeName.value=="") {
                $("#loginYzmError").text("请输入验证码");
                $("#loginYzmErrorTrigger").click();
                return false;
            }else{
                $("#loginYzmError").text("");
                $("#loginYzmErrorTrigger").click();
            }
        }
        userAccount.value = $.trim(userAccount.value); //格式化账号
        return true;
    }

</script>

</html>


