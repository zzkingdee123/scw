<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<%@include file="/WEB-INF/includes/css.jsp"%>
<link rel="stylesheet" href="${ctp }/css/main.css">
<link rel="stylesheet" href="${ctp }/plugin/ztree/zTreeStyle.css">
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
				pageContext.setAttribute("navinfo", "角色维护");
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
							<i class="glyphicon glyphicon-th"></i>数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;"
							action="${ctp }/permisson/role/findAllRole?pn=${pn }"
							method="post">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件" name="searchParam"
										value="${searchParam }">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i>删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='form.html'">
							<i class="glyphicon glyphicon-plus"></i>新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="checkAll"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>

									<c:forEach items="${pageInfo.list }" var="role">
										<tr>
											<td>${role.id }</td>
											<td><input type="checkbox" class="checkSingle"></td>
											<td>${role.name }</td>
											<td>
												<!-- modal -->
												<button type="button" class="btn btn-success btn-xs"
													data-toggle="modal" data-target="#myModal">
													<i class=" glyphicon glyphicon-check" roleid="${role.id }"></i>
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
												<li><a href="${ctp }/permisson/role/findAllRole?pn=1">首页</a></li>
												<c:if test="${pageInfo.hasPreviousPage }">
													<li><a
														href="${ctp }/permisson/role/findAllRole?pn=${pageInfo.prePage}">上一页</a></li>
												</c:if>
												<c:forEach items="${pageInfo.navigatepageNums }" var="pn">
													<c:if test="${pn==pageInfo.pageNum }">
														<li class="active"><a>${pn }<span class="sr-only"></span></a></li>
													</c:if>
													<c:if test="${pn!=pageInfo.pageNum }">
														<li><a
															href="${ctp }/permisson/role/findAllRole?pn=${pn }">${pn }</a></li>
													</c:if>
												</c:forEach>
												<c:if test="${pageInfo.hasNextPage }">
													<li><a
														href="${ctp }/permisson/role/findAllRole?pn=${pageInfo.nextPage}">下一页</a></li>
												</c:if>
												<li><a
													href="${ctp }/permisson/role/findAllRole?pn=${pageInfo.pages }">末页</a></li>
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

	<!-- 模态框 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">角色权限分配</h4>
				</div>
				<div class="modal-body">
					<div>
						<ul id="permissionTree" class="ztree">

						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="rpBtn">分配</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/includes/js.jsp"%>
	<%@include file="/WEB-INF/includes/common-js.jsp"%>
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

		//按钮悬停提示
		$(".glyphicon-check").tooltip({
			trigger : 'hover',
			html : true,
			title : '权限分配'
		});

		//被选中红显及树打开
		changePageStyle("permisson/role/findAllRole");

		//点击分配按钮弹出模态框权限树
		$(".glyphicon-check").click(function() {
			//1.初始化权限树并勾中已有权限
			var roleid = $(this).attr("roleid");
			initTree(roleid);

			//3.弹出模态框
			var option = {
				backdrop : 'static',
				show : true
			};
			$('#myModal').modal(option);
			$("#rpBtn").attr("rid",roleid);
		});

		function addDiyDom(treeId, treeNode) {
			//console.log(treeId);
			//console.log(treeNod e);
			$("#" + treeNode.tId + "_ico").removeClass();
			$("#" + treeNode.tId + "_ico").before("<span class='"+treeNode.icon+"'></span>");
		}

		function initTree(roleid) {
			var setting = {
				check : {
					enable : true
				},
				data : {
					simpleData : {
						enable : true,
						pIdKey : "pid"
					},
				key:{
					url:"xurl"
				}
				},

				view : {
					addDiyDom : addDiyDom
				}
			};

			/* 获取权限json */
			$.getJSON("${ctp}/permisson/getAllPermission", function(zNodes) {
				//console.log(zNodes);
				$.each(zNodes, function() {
					if (this.pid == 0) {
						this.open = true;
					}
				})
				ztree = $.fn.zTree.init($("#permissionTree"), setting, zNodes);
				checkedTree(roleid);
			});
		}

		function checkedTree(roleid) {
			$.getJSON("${ctp}/permisson/findPermissionByRoleId?roleid="
					+ roleid, function(data) {
				//console.log(data);
				$.each(data,function(){
					var node = ztree.getNodeByParam("id", this.id, null);
					ztree.checkNode(node, true, null);
				});

			});
		}
		
		//点击分配完成角色权限分配
		$("#rpBtn").click(function(){
			//1.选中所有被选的节点
			var nodes = ztree.getCheckedNodes(true);
			console.log(nodes);
			var rid=$(this).attr("rid");
			var pids="";
			$.each(nodes,function(){
				pids+=this.id+",";
			});
			
			$.get("${ctp}/permisson/updateRolePermission?rid="+rid+"&pids="+pids,function(){
				alert("分配成功");
				$('#myModal').modal("hide");
			});
		});
	</script>
</body>
</html>
