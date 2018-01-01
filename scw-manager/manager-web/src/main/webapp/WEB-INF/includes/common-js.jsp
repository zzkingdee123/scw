<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
//实现全选全不选
function checkAllReverse(check_all_button, check_single_button) {
	//单选按钮组都保持和全选按钮一样的选择状态
	check_all_button.click(function() {
			check_single_button.prop("checked",$(this).prop("checked"));
	});
	//单选按钮每个都选中的话，就把全选按钮也勾上
	check_single_button.click(function(){
		check_all_button.prop("checked",check_single_button.filter(":checked").length == check_single_button.length);
		});
	}
</script>
