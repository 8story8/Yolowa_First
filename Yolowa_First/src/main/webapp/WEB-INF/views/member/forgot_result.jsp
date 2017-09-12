<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Miminium Admin Template v.1">
<meta name="author" content="Isna Nur Azis">
<meta name="keyword" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Forgot_result</title>
<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>

</head>

<body id="mimin" class="dashboard form-signin-wrapper">

	<div class="container">

		<form class="form-signin">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<!-- <h1 class="atomic-symbol">YOLO WA!</h1> -->
					<h1><a href="home.do">YOLO WA!</a></h1>
					<p class="element-name">You Only Live Once</p>

					<i class="icons icon-arrow-down"></i>
					<c:if test="${requestScope.id!=null}">
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<span class="bar"></span><label>Your ID</label>
						<input class="form-text" readonly="readonly">
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<span class="bar"></span><label>${id.id}</label>
						<input class="form-text" readonly="readonly">
					</div>
					</c:if>
					<c:if test="${requestScope.pass!=null}">
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<span class="bar"></span> <label>Your Password</label>
						<input class="form-text" readonly="readonly">
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<span class="bar"></span><label>${pass.password}</label>
						<input class="form-text" readonly="readonly">
					</div>
					</c:if>
				</div>
				<div class="text-center" style="padding: 5px;">
					<c:if test="${requestScope.id!=null}">
					<a href="forgotPassView.do">Forgot Pass |</a> 
					</c:if>
					<a href="loginView.do"> Sign In</a>
					<a href="registerView.do">| Sign Up</a>
				</div>
			</div>
		</form>

	</div>
	<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>

	<script type="text/javascript">
		$(document).ready(function() {
			$('input').iCheck({
				checkboxClass : 'icheckbox_flat-aero',
				radioClass : 'iradio_flat-aero'
			});
		});
	</script>
	<!-- end: Javascript -->
</body>
</html>