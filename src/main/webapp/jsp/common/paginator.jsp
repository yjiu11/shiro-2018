<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 页数 -->
<div class="row">
<div class="col-md-4 col-md-offset-2">
	<div class="message">
		共<i class="blue">${paginator.totalCount}</i>条记录，当前显示第&nbsp;<i
			class="blue">${paginator.page}/${paginator.totalPages}</i>&nbsp;页
	</div>
</div>
</div>
<div class="row">
<div class="col-md-6 col-md-offset-3">
	<div style="text-align:center;">
		<ul class="pagination">
			<!-- <li><a href="#">&laquo;</a></li> -->
			<c:if test="${!paginator.firstPage}">
				<li><a href="javascript:queryAllPerson(1, ${paginator.limit});">首页</a></li>
				<li><a
					href="javascript:queryAllPerson(${paginator.prePage}, ${paginator.limit});">&lt;</a></li>
			</c:if>
			<c:forEach items="${paginator.slider(5)}" var="slider">
				<c:if test="${slider==paginator.page}">
					<li class="active"><a
						href="javascript:queryAllPerson(${slider}, ${paginator.limit});">${slider}</a></li>
				</c:if>
				<c:if test="${slider!=paginator.page}">
					<li><a
						href="javascript:queryAllPerson(${slider}, ${paginator.limit});">${slider}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${!paginator.lastPage}">
				<li><a
					href="javascript:queryAllPerson(${paginator.nextPage}, ${paginator.limit});">&gt;</a></li>
				<li><a
					href="javascript:queryAllPerson(${paginator.totalPages}, ${paginator.limit});">末页</a></li>
			</c:if>
			<!-- <li><a href="#">&raquo;</a></li> -->
		</ul>
	</div>
</div>
</div>