<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
  <head>
  </head>
  
  <body>
   <%@include file="/jsp/common/top.jsp" %>
<select id="allow_role">
    <option value="cheese">Cheese</option>
    <option value="tomatoes">Tomatoes</option>
    <option value="mozarella">Mozzarella</option>
    <option value="mushrooms">Mushrooms</option>
    <option value="pepperoni">Pepperoni</option>
    <option value="onions">Onions</option>
</select>
  </body>
 <script type="text/javascript">
	$(function(){
		$("#allow_role").find("option[value='tomatoes']").attr("selected","true");
	});
</script>
</html>
