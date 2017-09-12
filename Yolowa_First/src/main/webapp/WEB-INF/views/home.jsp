<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:forEach items="${categoryList}" var ="cList">
	<img src = "${pageContext.request.contextPath}/resources/asset/img/${cList.cType}.jpg" alt = "${cList.cType}" style = "width: 100%; height:350px;">
	<br><br>
</c:forEach>
