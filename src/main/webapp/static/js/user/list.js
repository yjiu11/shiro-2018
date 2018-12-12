/**&&&&&&&&&&&&&&&&&&&&&&打开【修改|新增】 模态框 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
/**点击【表格中的更新】，弹出模态框，即修改页面*/
function click_toPage_update(currentEle) {
	// 清除表单数据（表单完整重置（表单的数据，表单的样式））
	//reset_form("#UpdateModal form");
	$.reset_form($("#UpdateModal form"));
	var user_id = $(currentEle).attr("user_id");
	getUser(user_id);
	// 弹出模态框
	$("#UpdateModal").modal({
		backdrop : "static"
	});
}
//点击新增按钮弹出模态框。
function click_toPage_add(){
	$.reset_form("#AddModal form");
	//弹出模态框
	$("#AddModal").modal({
		backdrop:"static"
	});
}
/**打开修改模态框前，查询用户详细信息*/
function getUser(user_id){
	$.ajax({
		url:$.getAppPath()+'/user/getUser',
		type:'post',
		data:{"user_id":user_id},
		success:function(result){
			console.info(result.extend.user);
			$("#updateInputUserName").text(result.extend.user.username);
			$("#update_realname").val(result.extend.user.realname);
			$("#update_locked").val(result.extend.user.locked);
			$("#update_email").val(result.extend.user.email);
			$("#update_phone").val(result.extend.user.phone);
			
			$("#username").val(result.extend.user.username);
			$("#userid").val(result.extend.user.id);
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
		url:$.getAppPath()+"/user/add",
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
		url:$.getAppPath()+"/user/update",
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
			url:$.getAppPath()+"/user/delete",
			type:'post',
			data:{"ids":result},
			success:function(result){
				alert(result.status);
				if(result.status==100){
					alert(result.msg);
					//回到当前页
					var page = $("#page").val();
					queryAllPerson(page,10);
				}else alert(result.msg);
				
			}
		});
	}
}
function deleteOne(currentEle){
	if (!confirm("确认要删除？")) {
		window.event.returnValue = false;
	}else{
		var user_id = $(currentEle).attr("user_id");
		$.ajax({
			url:$.getAppPath()+"/user/delete",
			type:'post',
			data:{"ids":user_id},
			success:function(result){
				if(result.code==100){
					alert(result.msg);
					//回到当前页
					var page = $("#page").val();
					queryAllPerson(page,10);
				}else alert(result.msg);
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
function queryAllPerson(pageNow) {
	window.location.href = $.getAppPath()+"/user/list?pageNow=" + pageNow;
}
/**&&&&&&&&&&&&&&&&&&&&&&【修改|新增】校验 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/
//校验新增表单数据
function validate_add_form(){
	//1、拿到要校验的数据，使用正则表达式
	var empName = $("#exampleInputUserName").val();
	var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
	if(!regName.test(empName)){
		show_validate_msg("#exampleInputUserName", "error", "用户名可以是2-5位中文或者4-16位英文和数字的组合");
		return false;
	}else{
		show_validate_msg("#exampleInputUserName", "success", "");
	};
	//2、两个密码不能为空
	if($("#exampleInputPassword1").val().length<=6){
		show_validate_msg("#exampleInputPassword1", "error", "密码不能低于6位!");
		return false;
	}else{
		show_validate_msg("#exampleInputPassword1", "success", "");
	}
	//3、两次密码比对
	if($("#exampleInputPassword1").val() != $("#exampleInputPassword2").val()){
		show_validate_msg("#exampleInputPassword1", "error", "两次密码不同!");
		return false;
	}else{
		show_validate_msg("#exampleInputPassword1", "success", "");
	}
	return true;
}
//校验修改表单数据
function validate_update_form(){
	return true;
}
/**点击【表格中的分配角色】，弹出模态框*/
function click_toPage_allow(currentEle) {
	// 清除表单数据（表单完整重置（表单的数据，表单的样式））
	$.reset_form("#AllocationModal form");
	$('#allow_role').empty();//避免重复
	$('#allow_role').multiselect('deselectAll', false);//跟以下联合操作，清空选中内容
    $('#allow_role').multiselect('updateButtonText');
	var user_id = $(currentEle).attr("user_id");
	getRole(user_id);
	getUser2(user_id);
	// 弹出模态框
	$("#AllocationModal").modal({
		backdrop : "static"
	});
}
/**打开分配角色模态框前，根据用户ID查询所有角色*/
function getRole(user_id){
	$.ajax({
		url:$.getAppPath()+'/role/getRoleByUserId',
		type:'post',
		data:{"user_id":user_id},
		success:function(result){
			if(result.code==100){
				$.each(result.extend.allRoles,function(index,item){//全部角色
					$("#allow_role").append("<option value='"+item.id+"'>"+item.description+"</option>");
				});
				$.each(result.extend.roles,function(i,n){//要选中的角色
					$("#allow_role").find("[value="+n.id+"]").attr("selected","true");
				});
				$('#allow_role').multiselect('rebuild');
			}else{
				alert(result.msg);
			}
			
		}
	});
}
/**打开分配角色模态框前，查询用户详细信息*/
function getUser2(user_id){
	$.ajax({
		url:$.getAppPath()+'/user/getUser',
		type:'post',
		data:{"user_id":user_id},
		success:function(result){
			$("#allocation_username").text(result.extend.user.username);
			/*$("#allow_username").val(result.extend.user.username);*/
			
			$("#allow_username").val(result.extend.user.username);
			$("#allow_userid").val(result.extend.user.id);
		}
	});
}
function allow_form_submit(){
	var data = $("#allowForm").serialize();
	$.ajax({
		type:'post',
		url:$.getAppPath()+"/user/allow_role",
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
