<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/inc.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title>用户列表</title>
<script type="text/javascript">
	$(function(){
		$("#allow_role").multiselect();
	})
</script>
</head>

<body>
	<select id="allow_role" name="roleIds" multiple="multiple">
		<option>value1</option>
		<option>value2</option>
		<option>value3</option>
		<option>value1</option>
		<option>value2</option>
		<option>value3</option>
	</select>
</body>
</html>
