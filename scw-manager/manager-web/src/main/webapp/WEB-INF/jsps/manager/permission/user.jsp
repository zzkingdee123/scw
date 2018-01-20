<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<%@include file="/WEB-INF/includes/css.jsp"%>
<link rel="stylesheet" href="${ctp }/css/main.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>
		<%
		//导航条的标题
		pageContext.setAttribute("navinfo", "用户维护");
	%>
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;"
							action="${ctp }/permisson/user/findAllUser" method="post">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input id="loginacct" class="form-control has-success"
										type="text" name="searchParam" value="${searchParam }"
										placeholder="按账号查询">
								</div>
							</div>
							<button id="selectBtn" type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;" id="delBatch">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='add.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="checkAll"></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 遍历用户信息 -->
									<c:forEach items="${pageInfo.list }" var="user">
										<tr>
											<td>${user.id }</td>
											<td><input type="checkbox" class="checkSingle" did="${user.id }"></td>
											<td>${user.loginacct }</td>
											<td>${user.username }</td>
											<td>${user.email }</td>
											<td>
												<button type="button" class="btn btn-success btn-xs assignRoleBtn"  did="${user.id }">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" class="btn btn-danger btn-xs">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												<!--页码发请求时需要带上过滤条件  -->
												<li><a href="${ctp }/permisson/user/findAllUser?pn=1">首页</a></li>
												<c:if test="${pageInfo.hasPreviousPage }">
													<li><a
														href="${ctp }/permisson/user/findAllUser?pn=${pageInfo.prePage}">上一页</a></li>
												</c:if>
												<c:forEach items="${pageInfo.navigatepageNums }" var="pn">
													<c:if test="${pn==pageInfo.pageNum }">
														<li class="active"><a>${pn }<span class="sr-only"></span></a></li>
													</c:if>
													<c:if test="${pn!=pageInfo.pageNum }">
														<li><a
															href="${ctp }/permisson/user/findAllUser?pn=${pn }">${pn }</a></li>
													</c:if>
												</c:forEach>
												<c:if test="${pageInfo.hasNextPage }">
													<li><a
														href="${ctp }/permisson/user/findAllUser?pn=${pageInfo.nextPage}">下一页</a></li>
												</c:if>
												<li><a
													href="${ctp }/permisson/user/findAllUser?pn=${pageInfo.pages }">末页</a></li>
											</ul>
										</td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/includes/js.jsp"%>
	<%@include file="/WEB-INF/includes/common-js.jsp" %>
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

		//给分页按钮加过滤参数
		$(".pagination").find("a").click(function() {
			var searchParam = $("input[name=searchParam]").val();
			var newHref = $(this).attr("href") + "&searchParam=" + searchParam;
			$(this).attr("href", newHref);
		});
	
		//实现全选和单选
		checkAllReverse($("#checkAll"), $(".checkSingle"));
		
		//批量删除
		$("#delBatch").click(function(){
			//拿到被选的id
			var ids="";
			var delUrl="${ctp}/permisson/user/delBatch?ids=";
		$(".checkSingle:checked").each(function(){
			ids+=$(this).attr("did")+",";
		});
		//删除按钮跳转
		delUrl+=ids.substring(0,ids.length-1);
		if(confirm("确认删除"+ids.substring(0,ids.length-1)+"号会员")){
		location.href=delUrl;
		}
		return false;
		});
		
		//分配权限
		$(".assignRoleBtn").click(function() {
			var id = $(this).attr("did");
			//alert(id);
			var permissionUrl = "${ctp}/permisson/user/toAssignRolePage?id="+id;
			location.href=permissionUrl;
		});
		
		
		//被选中红显及树打开
		changePageStyle("permisson/user/findAllUser");
		


	</script>
	
	<script type="text/javascript">
	</script>
</body>
</html>
