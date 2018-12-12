/**&&&&&&&&&&&&&&&&&&&&&&打开【修改|新增】 模态框 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
/**点击【表格中的更新】，弹出模态框，即修改页面*/
function click_toPage_update(currentEle) {
	// 清除表单数据（表单完整重置（表单的数据，表单的样式））
	reset_form("#UpdateModal form");
	var role_id = $(currentEle).attr("role_id");
	getRole(role_id);
	// 弹出模态框
	$("#UpdateModal").modal({
		backdrop : "static"
	});
}
//点击新增按钮弹出模态框。
function click_toPage_add(){
	//清除表单数据（表单完整重置（表单的数据，表单的样式））
	reset_form("#AddModal form");
	//弹出模态框
	$("#AddModal").modal({
		backdrop:"static"
	});
}
/**打开修改模态框前，查询用户详细信息*/
function getRole(role_id){
	$.ajax({
		url:$.getAppPath()+'/role/getRole',
		type:'post',
		data:{"role_id":role_id},
		success:function(result){
			$("#updateRole").text(result.extend.role.role);
			$("#update_description").val(result.extend.role.description);
			$("#update_available").val(result.extend.role.available);
			$("#role").val(result.extend.role.role);
			$("#roleid").val(result.extend.role.id);
		}
	});
}
/**&&&&&&&&&&&&&&&&&&&&&&【修改|新增】表单提交&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
/**新增用户，表单提交*/
function add_form_submit(){
	if(!validate_add_form()){
		return false;
	};
	var data = $("#addform").serialize();
	$.ajax({
		type:'post',
		url:$.getAppPath()+"/role/add",
		data:data,
		success:function(result){
			if(result.code == 100){//员工保存成功；
				//1、关闭模态框
				$("#AddModal").modal('hide');
				var totalPages = $("#totalPages").val();
				queryAllPerson(totalPages,10);
			}else{
				//显示失败信息，返回的是服务器结果，即后端校验内容
				//有哪个字段的错误信息就显示哪个字段的；
				/*if(undefined != result.extend.errorFields.password){
					show_validate_msg("#exampleInputPassword1", "error", result.extend.errorFields.password);
				}*/
				alert("操作失败!");
			}
		}
		
	});
}
/**修改用户，表单提交*/
function update_form_submit(){
	if(!validate_update_form()){
		return false;
	};
	var data = $("#updateForm").serialize();
	$.ajax({
		type:'post',
		url:$.getAppPath()+"/role/update",
		data:data,
		success:function(result){
			if(result.code == 100){//员工修改成功；
				$("#UpdateModal").modal('hide');
				var page = $("#page").val();
				queryAllPerson(page,10);
			}
		}
		
	});
}
/**&&&&&&&&&&&&&&&&&&&&&&【删除】&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
//批量删除
function deleteBatch(currentEle){
	var len = $(".ck_item:checked").length;
	if(len<=0){
		alert("请至少选择一条记录");
		return false;
	}
	//获取选中的id,用-连接
	var cked = [];
	var tmp;
	$.each($(".ck_item:checked"),function(){
		tmp = $(this).parents("tr").find("td:eq(1)").text();
		cked.push(tmp);
	});
	var result = cked.join("-");
	if (!confirm("确认要删除【"+result+"】记录吗？")) {
		window.event.returnValue = false;
	}else{
		$.ajax({
			url:$.getAppPath()+"/role/delete",
			type:'post',
			data:{"ids":result},
			success:function(result){
				alert(result.msg);
				//回到当前页
				var page = $("#page").val();
				queryAllPerson(page,10);
			}
		});
	}
}
function deleteOne(currentEle){
	if (!confirm("确认要删除？")) {
		window.event.returnValue = false;
	}else{
		var role_id = $(currentEle).attr("role_id");
		$.ajax({
			url:$.getAppPath()+"/role/delete",
			type:'post',
			data:{"ids":role_id},
			success:function(result){
				alert(result.msg);
				//回到当前页
				var page = $("#page").val();
				queryAllPerson(page,10);
			}
		});
	}
} 
/**&&&&&&&&&&&&&&&&&&&&&&通用&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
//显示校验结果的提示信息
function show_validate_msg(ele,status,msg){
	//清除当前元素的校验状态
	$(ele).parent().removeClass("has-success has-error");
	$(ele).next("span").text("");
	if("success"==status){
		$(ele).parent().addClass("has-success");
		$(ele).next("span").text(msg);
	}else if("error" == status){
		$(ele).parent().addClass("has-error");
		$(ele).next("span").text(msg);
	}
}
//清空表单样式及内容
function reset_form(ele){
	$(ele)[0].reset();
	//清空表单样式
	$(ele).find("*").removeClass("has-error has-success");
	$(ele).find(".help-block").text("");
}
function queryAllPerson(pageNow) {
	window.location.href = $.getAppPath()+"/role/list?pageNow=" + pageNow;
}
/**&&&&&&&&&&&&&&&&&&&&&&【修改|新增】校验 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
//校验新增表单数据
function validate_add_form(){
	//1、拿到要校验的数据，使用正则表达式
	var roleName = $("#add_role").val();
	var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	if(!regName.test(roleName)){
		show_validate_msg("#add_role", "error", "用户名可以是2-5位中文或者4-16位英文和数字的组合");
		return false;
	}else{
		show_validate_msg("#add_role", "success", "");
	};
	/*//2、校验邮箱信息
	var email = $("#exampleInputEmail1").val();
	var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	if(!regEmail.test(email)){
		show_validate_msg("#exampleInputEmail1", "error", "邮箱格式不正确");
		return false;
	}else{
		show_validate_msg("#exampleInputEmail1", "success", "");
	}*/
	return true;
}
//校验修改表单数据
function validate_update_form(){
	/*var empName = $("#exampleInputUserName").val();
	var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	if(!regName.test(empName)){
		show_validate_msg("#exampleInputUserName", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
		return false;
	}else{
		show_validate_msg("#exampleInputUserName", "success", "");
	};*/
	return true;
}
/**点击【表格中的分配角色】，弹出模态框*/
function click_toPage_allow(currentEle) {
	// 清除表单数据（表单完整重置（表单的数据，表单的样式））
	reset_form("#AllocationModal form");
	/*$('#allow_resource').empty();//避免重复
	$('#allow_resource').multiselect('deselectAll', false);
    $('#allow_resource').multiselect('updateButtonText');*/
    
	var role_id = $(currentEle).attr("role_id");
	getResource(role_id);
	getRole2(role_id);
	// 弹出模态框
	$("#AllocationModal").modal({
		backdrop : "static"
	});
}
/**打开分配角色模态框前，根据用户ID查询所有角色*/
function getResource(role_id){
	$.ajax({
		url:$.getAppPath()+'/resource/getTree',
		type:'get',
		// data:{"role_id":role_id},
		success:function(result){
			//var last="["+JSON.stringify(result)+"]"; //将JSON对象转化为JSON字符
			//console.info(last)
			var $checkableTree = $("#allow_resource").treeview({
				data : result,
				showIcon : false,
				showCheckbox : true,
				onNodeChecked : function(event, node) { //选中节点
                    console.info("onNodeChecked:"+node);
					var selectNodes = getChildNodeIdArr(node); //获取所有子节点
					if (selectNodes) { //子节点不为空，则选中所有子节点
						$('#allow_resource').treeview('checkNode',
								[ selectNodes, {
									silent : true
								} ]);
					}
					var parentNode = $("#allow_resource").treeview(
							"getNode", node.parentId);
					setParentNodeCheck(node);
				},
				onNodeUnchecked : function(event, node) { //取消选中节点
					var selectNodes = getChildNodeIdArr(node); //获取所有子节点
					if (selectNodes) { //子节点不为空，则取消选中所有子节点
						$('#allow_resource').treeview('uncheckNode',
								[ selectNodes, {
									silent : true
								} ]);
					}
				},
				onNodeExpanded : function(event, data) {
					if (data.nodes === undefined || data.nodes === null) {

					} else if (data.tags[0] === "2") {
						alert("Tags 2");
					} else {
						alert("1111");
					}
				}
			});
			/*console.info(result)
			$.each(result.extend.allResources,function(index,item){//全部角色
				$("#allow_resource").append("<option value='"+item.id+"'>"+item.name+"</option>");
			});
			$.each(result.extend.resources,function(i,n){//要选中的角色
				$("#allow_resource").find("[value="+n.id+"]").attr("selected","true");
			});
			$('#allow_resource').multiselect('rebuild');*/
		}
	});
}
/**打开分配角色模态框前，查询用户详细信息*/
function getRole2(role_id){
	$.ajax({
		url:$.getAppPath()+'/role/getRole',
		type:'post',
		data:{"role_id":role_id},
		success:function(result){
			$("#allocation_role").text(result.extend.role.role);
			/*$("#allow_username").val(result.extend.user.username);*/
			
			$("#allow_role").val(result.extend.role.role);
			$("#allow_roleid").val(result.extend.role.id);
		}
	});
}
function allow_form_submit(){
	var data = $("#allowForm").serialize();
	$.ajax({
		type:'post',
		url:$.getAppPath()+"/role/allow_resource",
		data:data,
		success:function(result){
			if(result.code == 100){//员工修改成功；
				$("#AllocationModal").modal('hide');
				var page = $("#page").val();
				queryAllPerson(page,10);
			}
		}
		
	});
}


function getChildNodeIdArr(node) {
	console.info(node)
	var ts = [];
	if (node.nodes) {
		for (x in node.nodes) {
			ts.push(node.nodes[x].nodeId);
			if (node.nodes[x].nodes) {
				var getNodeDieDai = getChildNodeIdArr(node.nodes[x]);
				for (j in getNodeDieDai) {
					ts.push(getNodeDieDai[j]);
				}
			}
		}
	} else {
		ts.push(node.nodeId);
	}
	return ts;
}

function setParentNodeCheck(node) {
	var parentNode = $("#treeview-checkable")
			.treeview("getNode", node.parentId);
	if (parentNode.nodes) {
		var checkedCount = 0;
		for (x in parentNode.nodes) {
			if (parentNode.nodes[x].state.checked) {
				checkedCount++;
			} else {
				break;
			}
		}
		if (checkedCount === parentNode.nodes.length) {
			$("#treeview-checkable").treeview("checkNode", parentNode.nodeId);
			setParentNodeCheck(parentNode);
		}
	}
}