<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<%@include file="/WEB-INF/includes/css.jsp"%>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="index.html" style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form id="loginForm" class="form-signin" role="form" action="${ctp }/permisson/user/login" method="post"> 
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 用户登录
			</h2>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" id="loginacct_input"
					name="loginacct" value="${errorUser.loginacct }" placeholder="请输入登录账号" autofocus>
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
					<span style="color: red">${errormsg }</span> 
					<!-- 取出一次，就将session中的errormsg移除 -->
					<c:remove var="errormsg"/>
					<c:remove var="errorUser"/>
					
					<span class="errorinfo" style="color: red"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" id="userpswd_input"
					name="userpswd" placeholder="请输入登录密码" style="margin-top: 10px;">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				<span class="errorinfo" style="color: red"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<select class="form-control">
					<option value="member">会员</option>
					<option value="manager">管理</option>
				</select>
			</div>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					记住我
				</label> <br> <label> 忘记密码 </label> <label style="float: right">
					<a href="${ctp }/reg.jsp">我要注册</a>
				</label>
			</div>
			<a class="btn btn-lg btn-success btn-block" id="loginBtn"> 登录</a>
		</form>
	</div>
	<%@include file="/WEB-INF/includes/js.jsp"%>
	<script type="text/javascript">
	
	/* 自定义表单校验 */
	$.validator.setDefaults({
		
		showErrors: function(map, list) {
			//console.log(map);
			//console.log(list);
			//清除所有错误和状态
			$(".errorinfo").empty();
			$(".form-group").removeClass("has-success has-error has-warning")
			$.each(list,function(){
				/* 
					element:input#loginacct_input.form-control
					message:"登录账号是必须的"
					method:"required"
				*/
				$(this.element).nextAll(".errorinfo").text(this.message);
				$(this.element).parent("div.form-group").addClass("has-error");
			})
		}
	}
			);
	
	/* 管理员登录 */
	 $("#loginBtn").click(function(){
		 var loginType = $("select.form-control").val();
		 if(loginType == "manager"){
			 $("#loginForm").submit();
		 }else{
			 alert("此功能尚未开通");
		 }

		 return false;
	 });
	
		/* 表单校验 */
		$("#loginForm").validate({
			rules: {
				loginacct: {
					required: true,
					minlength: 6
				},
				userpswd: {
					required: true,
					minlength: 5
				}
			},
			messages: {
				loginacct: {
					required: "登录账号是必须的",
					minlength: "登录账号必须是六位以上"
				},
				userpswd: {
					required: "请填写密码",
					minlength: "密码必须在5位以上"
				}
			}
		});
	</script>

</body>
</html>