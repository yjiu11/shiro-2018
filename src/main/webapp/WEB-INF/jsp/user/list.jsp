<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>用户列表</title>
  </head>
  
  <body>
  <%@include file="/jsp/common/top.jsp" %>
  	<div class="container">
  		<!-- 新增模态窗口 -->
		<!-- Modal -->
		<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">注册用户</h4>
		      </div>
		      <div class="modal-body">
		      	<form id="addform" class="form-horizontal">
				  <div class="form-group">
				    <label for="exampleInputUserName" class="col-sm-2 control-label col-md-offset-1">用户名</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="exampleInputUserName" name="username" placeholder="请输入用户名!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="realname" class="col-sm-2 control-label col-md-offset-1">真实姓名</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="realname" name="realname" placeholder="请输入真实姓名!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="add_email" class="col-sm-2 control-label col-md-offset-1">邮箱</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="add_email" name="email" placeholder="请输入邮箱!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="add_phone" class="col-sm-2 control-label col-md-offset-1">手机号</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="add_phone" name="phone" placeholder="请输入手机号!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="exampleInputPassword1" class="col-sm-2 control-label col-md-offset-1">密码</label>
				    <div class="col-sm-8">
					    <input type="password" class="form-control" id="exampleInputPassword1" name="password" placeholder="请输入密码!">
					    <span class="help-block"></span>
					</div>
				  </div>
				  <div class="form-group">
				    <label for="exampleInputPassword2" class="col-sm-2 control-label col-md-offset-1">确认密码</label>
				    <div class="col-sm-8">
					    <input type="password" class="form-control" id="exampleInputPassword2" placeholder="请确认密码!">
					</div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="SaveAddModal">注册</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 修改模态窗口 -->
		<!-- Modal -->
		<div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myUpdateModalLabel">修改用户</h4>
		      </div>
		      <div class="modal-body" >
		      	<form class="form-horizontal"  id="updateForm">
				  <div class="form-group">
				    <label class="col-sm-3 control-label" for="exampleInputUserName">用户:</label>
				    <p class="col-sm-3 form-control-static" id="updateInputUserName"></p>
				    <input type="hidden" id="username" name="username"/>
				    <input type="hidden" id="userid" name="id" />
				   <!--  <input type="text" class="form-control" id="updateInputUserName" name="username" placeholder="请输入用户名!"> -->
				  	<span class="help-block"></span>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-3 control-label" for="update_realname">真实姓名:</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="update_realname" name="realname" placeholder="请输入真实姓名!">
				    	<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="update_email" class="col-sm-2 control-label col-md-offset-1">邮箱</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="update_email" name="email" placeholder="请输入邮箱!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="update_phone" class="col-sm-2 control-label col-md-offset-1">手机号</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="update_phone" name="phone" placeholder="请输入手机号!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-3 control-label" for="exampleInputUserName">是否锁定:</label>
				    <div class="col-sm-8">
				    	<select class="form-control" id="update_locked" name="locked">
				    		<option value="">请选择...</option>
				    		<option value="2">未锁定</option>
				    		<option value="1">锁定</option>
				    	</select>
				    	<!-- <input type="text" class="form-control" id="update_locked" name="locked" placeholder="请选择..."> -->
				    </div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="UpdateAddModal">修改</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- 分配角色窗口 -->
		<div class="modal fade" id="AllocationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="allocation_row">分配角色</h4>
		      </div>
		      <div class="modal-body" >
		      	<form class="form-horizontal"  id="allowForm">
				  <div class="form-group">
				    <label class="col-sm-3 col-sm-offset-1 control-label" for="allocation_username">用户:</label>
				    <p class="col-sm-3 form-control-static" id="allocation_username"></p>
				    <input type="hidden" id="allow_username" name="username"/>
				    <input type="hidden" id="allow_userid" name="id" />
				  </div>
				  <div class="form-group">
				    <label  class="col-sm-3 col-sm-offset-1 control-label" for="allow_role">角色列表:</label>
				    <div class="col-sm-8">
				    	<!-- <select id="allow_role" name="roleIds" multiple="multiple">
				    	</select> -->
				    	<select id="allow_role" name="roleIds" multiple="multiple">
						</select>
				    	<!-- <input type="text" class="form-control" id="update_locked" name="locked" placeholder="请选择..."> -->
				    </div>
				  </div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="AllowRoleModal">分配</button>
		      </div>
		    </div>
		  </div>
		</div>
	<!-- 分页显示 -->
	<div class="row">
		<div class="col-md-2 col-md-offset-1">
			<h3>用户列表</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2 col-md-offset-9" style="">
			<shiro:hasPermission name="/user/add"><button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">注册</button></shiro:hasPermission>
			<!-- <button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">修改密码</button> -->
			<!-- <button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">分配权限</button> -->
			<shiro:hasPermission name="/user/delete"><button type="button" id="deleteBatch" class="btn btn-danger btn-sm">销毁用户</button></shiro:hasPermission>
		</div>
	</div>
	<div class="row">
		<p></p>
	</div>
	<div class="row">
		<div class="col-md-10 col-md-offset-1">
	
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<td><input type="checkbox" id="ckall"></td>
						<td>#</td>
						<td>用户名</td>
						<td>真实姓名</td>
						<td>邮箱</td>
						<td>手机号</td>
						<td>锁定</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${requestScope.personList }" var="user">
						<tr>
							<td><input type="checkbox" class="ck_item"></td>
							<td>${user.id }</td>
							<td>${user.username }</td>
							<td>${user.realname }</td>
							<td>${user.email }</td>
							<td>${user.phone }</td>
							<td>${user.locked == 2 ? '正常' : '锁定' }</td>
							<td>
								<shiro:hasPermission name="/user/update"><button class="btn btn-primary btn-sm update" user_id="${user.id}">更新</button></shiro:hasPermission>
								<shiro:hasPermission name="/user/allow_role"><button class="btn btn-primary btn-sm allow" user_id="${user.id}">分配角色</button></shiro:hasPermission>
								<%-- <button class="btn btn-primary btn-sm update" user_id="${user.id}">修改密码</button> 在个人信息中去修改--%>
								<shiro:hasPermission name="/user/delete"><button class="btn btn-danger btn-sm delete" user_id="${user.id}">删除</button></shiro:hasPermission>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	
	</div>
	<!-- 分页 -->
	<%@ include file="/jsp/common/paginator.jsp" %>
	<!-- 分页变量，要用在list.js中 -->
	<input type="hidden" id="page" value="${paginator.page}">
	<input type="hidden" id="totalPages" value="${paginator.totalPages}">
	</div>
<script src="${APP_PATH }/static/js/user/list.js"></script>
<script type="text/javascript">
$(function() {
	/**点击新增按钮弹出模态框*/
	$("#btn_showAddModal").click(function(){
		click_toPage_add();
	});
	/**新增用户表单提交*/
	$("#SaveAddModal").on("click",function(){
		add_form_submit();
	});
	/**点击【表格中的更新】，弹出模态框，即修改页面*/
	$(".update").click(function(){
		click_toPage_update(this);//方法需要用到this才传递
	});
	$(".allow").click(function(){
		click_toPage_allow(this);//方法需要用到this才传递
	});
	$("#AllowRoleModal").click(function(){
		allow_form_submit();
	});
	/**修改用户表单提交*/
	$("#UpdateAddModal").on("click",function(){
		update_form_submit();
	});
	/**批量删除*/
	$("#deleteBatch").click(function(){
		deleteBatch();
	});
	/**单条删除*/
	$(".delete").click(function(){
		deleteOne(this);
	});
	/**全选\全不选*/
	$("#ckall").click(function(){
		$(".ck_item").prop("checked",$(this).prop("checked"));
	}); 
	/**所有节点选中，则ckall选中，有一个节点未选中，则ckall未选中*/
	$(".ck_item").click(function(){
                var totalCheck = $(".ck_item").length;
		var len = $(".ck_item:checked").length;
		if(len == totalCheck){
			$("#ckall").prop("checked",true);
		}
		if(len < totalCheck){
			$("#ckall").prop("checked",false);
		}
		
	}); 
	
});
</script>
  </body>
</html>
