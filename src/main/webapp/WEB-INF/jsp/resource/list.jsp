<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE HTML>
<html>
  <head>
    <title>资源列表</title>
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
		        <h4 class="modal-title" id="myModalLabel">添加资源</h4>
		      </div>
		      <div class="modal-body">
		      	<form id="addform" class="form-horizontal">
				  <div class="form-group">
				    <label for="add_name" class="col-sm-2 control-label col-md-offset-1">资源名称</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="add_name" name="name" placeholder="请输入资源名称!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				   <div class="form-group">
				    <label for="add_type" class="col-sm-2 control-label col-md-offset-1">资源类型</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="add_type" name="type" placeholder="资源类型!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="add_url" class="col-sm-2 control-label col-md-offset-1">资源地址</label>
				    <div class="col-sm-8">
					    <input type="text" class="form-control" id="add_url" name="url" placeholder="请输入资源地址!">
					    <span class="help-block"></span>
					</div>
				  </div>
				  <div class="form-group">
				    <label for="add_parentId" class="col-sm-2 control-label col-md-offset-1">父节点</label>
				    <div class="col-sm-8">
					    <input type="text" class="form-control" id="add_parentId" name="parentId" placeholder="请选择父节点!">
					</div>
				  </div>
				  <!-- <div class="form-group">
				    <label for="add_permission" class="col-sm-2 control-label col-md-offset-1">权限列表</label>
				    <div class="col-sm-8">
					    <input type="password" class="form-control" id="add_permission" name="permission" placeholder="请选择权限列表!">
					</div>
				  </div> -->
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
		        <h4 class="modal-title" id="myUpdateModalLabel">修改资源</h4>
		      </div>
		      <div class="modal-body" >
		      	<form class="form-horizontal"  id="updateForm">
				  <div class="form-group">
				  	<input type="hidden" id="resourceName" name="name"/>
				    <input type="hidden" id="resourceId" name="id" />
				    <label class="col-sm-3 control-label" for="updatename">资源名称:</label>
				    <p class="col-sm-3 form-control-static" id="updatename"></p>
				   <!--  <input type="text" class="form-control" id="updateInputUserName" name="username" placeholder="请输入用户名!"> -->
				  	<span class="help-block"></span>
				  </div>
				   <div class="form-group">
				    <label for="update_type" class="col-sm-2 control-label col-md-offset-1">资源类型</label>
				    <div class="col-sm-8">
				    	<input type="text" class="form-control" id="update_type" name="type" placeholder="资源类型!">
				  		<span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="update_url" class="col-sm-2 control-label col-md-offset-1">资源地址</label>
				    <div class="col-sm-8">
					    <input type="text" class="form-control" id="update_url" name="url" placeholder="请输入资源地址!">
					    <span class="help-block"></span>
					</div>
				  </div>
				  <div class="form-group">
				    <label for="update_parentId" class="col-sm-2 control-label col-md-offset-1">父节点</label>
				    <div class="col-sm-8">
					    <input type="text" class="form-control" id="update_parentId" name="parentId" placeholder="请选择父节点!">
					</div>
				  </div>
				 <!--  <div class="form-group">
				    <label for="update_permission" class="col-sm-2 control-label col-md-offset-1">权限列表</label>
				    <div class="col-sm-8">
					    <input type="password" class="form-control" id="update_permission" name="permission" placeholder="请选择权限列表!">
					</div>
				  </div> -->
				  <div class="form-group">
				    <label  class="col-sm-3 control-label" for="update_available">是否可用:</label>
				    <div class="col-sm-8">
				    	<select class="form-control" id="update_available" name="available">
				    		<option value="">请选择...</option>
				    		<option value="2">禁用</option>
				    		<option value="1">可用</option>
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
	<!-- 分页显示 -->
	<div class="row">
		<div class="col-md-2 col-md-offset-1">
			<h3>资源管理</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4 col-md-offset-9" style="">
			<shiro:hasPermission name="/resource/add"><button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">添加</button></shiro:hasPermission>
			<!-- <button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">修改密码</button> -->
			<!-- <button type="button" id="btn_showAddModal" class="btn btn-primary btn-sm">分配权限</button> -->
			<shiro:hasPermission name="/resource/delete"><button type="button" id="deleteBatch" class="btn btn-danger btn-sm">删除</button></shiro:hasPermission>
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
						<td>资源名称</td>
						<td>资源类型</td>
						<td>资源地址</td>
						<td>父节点</td>
						<!-- <td>权限列表</td> -->
						<td>是否可用</td>
						<td>操作</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${requestScope.resourceList }" var="resource">
						<tr>
							<td><input type="checkbox" class="ck_item"></td>
							<td>${resource.id }</td>
							<td>${resource.name }</td>
							<td>${resource.type }</td>
							<td>${resource.url }</td>
							<td>${resource.parentId }</td>
							<%-- <td>${resource.permission }</td> --%>
							<td>${resource.available == 1 ? '正常' : '禁用' }</td>
							<td>
								<shiro:hasPermission name="/resource/update"><button class="btn btn-primary btn-sm update" resource_id="${resource.id}">更新</button></shiro:hasPermission>
								<%-- <button class="btn btn-primary btn-sm update" resource_id="${resource.id}">分配权限</button> --%>
								<%-- <button class="btn btn-primary btn-sm update" user_id="${user.id}">修改密码</button> 在个人信息中去修改--%>
								<shiro:hasPermission name="/resource/delete"><button class="btn btn-danger btn-sm delete" resource_id="${resource.id}">删除</button></shiro:hasPermission>
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
<script src="${APP_PATH }/static/js/resource/list.js"></script>
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
