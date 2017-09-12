<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Miminium Admin Template v.1">
<meta name="author" content="Isna Nur Azis">
<meta name="keyword" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>login</title>

<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>

</head>

<body id="mimin" class="dashboard form-signin-wrapper">

	<div class="container">

		<form class="form-signin" action="login.do">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<!-- <h1 class="atomic-symbol">YOLO WA!</h1> -->
					<a href="home.do"><h1>YOLO WA!</h1></a>
					<p class="element-name">You Only Live Once</p>
					<br>
					<br>
					<h2> 가입완료 </h2>
					 <input type="button" id="home" class="btn col-md-12" value="확인" />
				</div>
			</div>
		</form>

	</div>
	<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#home").click(function(){
				location.href="loginView.do";
			})
		});
	</script>
	<!-- end: Javascript -->
</body>
</html>