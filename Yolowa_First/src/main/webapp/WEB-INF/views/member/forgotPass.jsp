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
<title>ForgotPass</title>
<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>
<style type="text/css">
#loginForm {
	margin-top: 30px;
}
</style>
</head>

<body id="mimin" class="form-signin-wrapper">

	<div class="container" id="loginForm">

		<form class="form-signin" action="forgotPass.do">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<h2>Search Password</h2>
					<div class="time">
						<p class="animated fadeInRight">Sat,October 1st 2029</p>
					</div>

					<i class="icons icon-arrow-down"></i>

					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" class="form-text" name="id" required> <span
							class="bar"></span> <label>ID</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" class="form-text" name="name" required> <span
							class="bar"></span> <label>NAME</label>
					</div>

					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" class="form-text" name="phone" required> <span
							class="bar"></span> <label>Phone Number</label>
					</div>

					<input type="submit" class="btn col-md-12" value="Search" />
				</div>
				<div class="text-center" style="padding: 5px;">
					<a href="loginView.do">SignIn</a> | <a href="registerView.do">Signup</a>
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