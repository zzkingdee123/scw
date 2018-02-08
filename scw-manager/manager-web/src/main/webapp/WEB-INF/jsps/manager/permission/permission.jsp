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
<link rel="stylesheet" href="${ctp }/css/doc.min.css">
<link rel="stylesheet" href="${ctp }/plugin/ztree/zTreeStyle.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}
</style>
</head>

<body>

	<%
	    //导航条的标题

				
				pageContext.setAttribute("navinfo", "许可111维护");

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
						<i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<ul id="permissionTree" class="ztree"></ul>
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
						<h4>没有默认类</h4>
						<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
					</div>
					<div class="bs-callout bs-callout-info">
						<h4>没有默认类</h4>
						<p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
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
	<%@include file="/WEB-INF/includes/common-js.jsp"%>
	
	<script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            
    		//被选中红显及树打开
    		changePageStyle("permisson/permissonList");
    		
    		initTree();
    		
    		function initTree() {
    			var setting = {
    				check : {
    					enable : false
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
    					addDiyDom : addDiyDom,
    					addHoverDom:addHoverDom
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
    			});
    		}
    		
    		function addDiyDom(treeId, treeNode) {
    			//console.log(treeId);
    			//console.log(treeNod e);
    			$("#" + treeNode.tId + "_ico").removeClass();
    			$("#" + treeNode.tId + "_ico").before("<span class='"+treeNode.icon+"'></span>");
    		}
    		
    		function addHoverDom(treeId, treeNode){
				var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
				aObj.attr("href", "javascript:;");
				if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
				var s = '<span id="btnGroup'+treeNode.tId+'">';
				if ( treeNode.level == 0 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
				} else if ( treeNode.level == 1 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
					if (treeNode.children.length == 0) {
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
					}
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
				} else if ( treeNode.level == 2 ) {
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="#" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
					s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
				}

				s += '</span>';
				aObj.after(s);

    		}
    		
        </script>
</body>
</html>
