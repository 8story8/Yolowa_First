<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>

<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>

</head>

<body id="mimin" class="dashboard form-signin-wrapper">

	<div class="container">

		<form class="form-signin" action="login.do" method="post">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<!-- <h1 class="atomic-symbol">YOLO WA!</h1> -->
					<h1><a href="home.do">YOLO WA!</a></h1>
					<p class="element-name">You Only Live Once</p>
					<i class="icons icon-arrow-down"></i>
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<input type="text" class="form-text" name="id" required> <span
							class="bar"></span> <label>ID</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 40px !important;">
						<input type="password" class="form-text" name="password" required>
						<span class="bar"></span> <label>Password</label>
					</div>
					 <input type="submit" class="btn col-md-12" value="Log In" />
				</div>
				<div class="text-center" style="padding: 5px;">
					<a href="forgotIdView.do">Forgot Id / Pass </a> <a href="registerView.do">|
						Signup</a>
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