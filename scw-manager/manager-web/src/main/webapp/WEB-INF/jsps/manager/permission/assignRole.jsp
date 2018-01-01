<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<%@include file="/WEB-INF/includes/css.jsp"%>
<link rel="stylesheet" href="${ctp }/css/main.css">
<link rel="stylesheet" href="${ctp }/css/doc.min.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>
	<%
		//导航条的标题
		pageContext.setAttribute("navinfo", "用户维护");
	%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
					<li><a href="#">首页</a></li>
					<li><a href="#">数据列表</a></li>
					<li class="active">分配角色</li>
				</ol>
				<div class="panel panel-default">
					<div class="panel-body">
						<form role="form" class="form-inline">
							<div class="form-group">
								<label for="exampleInputPassword1">未分配角色列表</label><br> <select
									class="form-control unroles_select" multiple size="10"
									style="width: 100px; overflow-y: auto;">
									<c:forEach items="${unRole }" var="role">
										<option value="${role.id }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<ul>
									<li class="btn btn-default glyphicon glyphicon-chevron-right"></li>
									<br>
									<li class="btn btn-default glyphicon glyphicon-chevron-left"
										style="margin-top: 20px;"></li>
								</ul>
							</div>
							<div class="form-group" style="margin-left: 40px;">
								<label for="exampleInputPassword1">已分配角色列表</label><br> <select
									class="form-control roles_select" multiple size="10"
									style="width: 100px; overflow-y: auto;">
									<c:forEach items="${userRole }" var="role">
										<option value="${role.id }">${role.name }</option>
									</c:forEach>
								</select>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">帮助</h4>
				</div>
				<div class="modal-body">
					<div class="bs-callout bs-callout-info">
						<h4>测试标题1</h4>
						<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
					</div>
					<div class="bs-callout bs-callout-info">
						<h4>测试标题2</h4>
						<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
					</div>
				</div>
				<!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/includes/js.jsp"%>
	<script type="text/javascript">
		$(function() {
			$(".list-group-item").click(function() {
				if ($(this).find("ul")) {
					$(this).toggleClass("tree-closed");
					if ($(this).hasClass("tree-closed")) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
		});
		
		//添加角色
		$(".glyphicon-chevron-right").click(function(){
			//alert("aa");
			//console.log($(".unroles_select :selected"));
			var rids="";
			$(".unroles_select :selected").each(function(){
				rids+=$(this).attr("value")+",";
			});
			var uid="${param.id}";
			var url="${ctp}/permisson/user/addRoleToUser?rids="+rids.substring(0,rids.length-1)+"&uid="+uid;
			$.post(url,function(){
			$(".unroles_select :selected").appendTo(".roles_select");
			});
		});
		
		
		//删除角色
		$(".glyphicon-chevron-left").click(function(){
			var rids="";
			$(".roles_select :selected").each(function(){
				rids+=$(this).attr("value")+",";
			});
			var uid="${param.id}";
			var url="${ctp}/permisson/user/deleteRoleFromUser?rids="+rids.substring(0,rids.length-1)+"&uid="+uid;
			$.post(url,function(){
				$(".roles_select :selected").appendTo(".unroles_select");
			});
		});
	</script>
</body>
</html>
