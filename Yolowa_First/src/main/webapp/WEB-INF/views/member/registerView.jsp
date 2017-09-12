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
<title>YoloWa</title>

<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>

</head>

<body id="mimin" class="dashboard form-signin-wrapper">

	<div class="container">
		<form method="post" id="form-signin" name="form-signin" class="form-signin" action="${pageContext.request.contextPath}/registerMember.do">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<h1><a href="home.do">YOLO WA!</a></h1>
					<p class="element-name">You Only Live Once</p>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" class="form-text" name="id" id="id" required="required">
						<span id="idCheckView" style="margin-top: 10px"></span>
						<span class="bar"></span> <label>ID</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="password" name="password" class="form-text" id="password" required="required"> <span
							class="bar"></span> <label>PASSWORD</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name ="name" class="form-text" id="name" required="required"> <span
							class="bar"></span> <label>NAME</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name="phone"class="form-text" id="phone" required="required"> <span
							class="bar"></span> <label>PHONE</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name="address" class="form-text" id="address" required="required"> <span
							class="bar"></span> <label>ADDRESS</label>
					</div>

					<div style="font-size: 18px">

						<label>CARTEGORY</label><br> 
						<i class="icons icon-arrow-down" id="down"></i> 
						<i class="icons icon-arrow-up" id="up"></i>
						<div id="checkForm">
							<c:forEach items="${categoryList}" var="category">
								<input type="checkbox" name="checkbox_category" value="${category.cNO}" style="width: 30px;">${category.cType}
							</c:forEach>
						
						</div>
					</div>
					<br> <input type="submit" id="signUp" class="btn col-md-12" value="SignUp" />
				</div>
				<div class="text-center" style="padding: 5px;">
					<a href="loginView.do">Already have an account?</a>
				</div>
			</div>
			<div id="category">
				
			</div>
				
		</form>

	</div>
<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function() {
			var checkResultId="";	
			$("#checkForm").hide();
			$("#up").hide();
			$("#down").click(function() {
				$("#checkForm").show();
				$("#down").hide();
				$("#up").show(); 
			}); //click
			$("#up").click(function() {
				$("#checkForm").hide(); 	
				$("#down").show();
				$("#up").hide();
			});	//click
			 $("#signUp").click(function(){
					if(checkResultId==""){
						alert("아이디 중복확인을 하세요");
						return false;
					}
					if($("#id").val()==""){
						alert("아이디를 입력하세요");
						return false;
					}
					if($("#password").val()==""){
						alert("패스워드를 입력하세요");
						return false;
					}
					if($("#name").val()==""){
						alert("이름을 입력하세요");
						return false;
					}
					if($("#phone").val()==""){
						alert("핸드폰번호를 입력하세요");
						return false;
					}	
					if($("#address").val()==""){
						alert("주소를 입력하세요");
						return false;
					}
					if($(":input[name=checkbox_category]:checked").length<1||
							$(":input[name=checkbox_category]:checked").length>3){
						alert("카테고리를 1개 이상 3개 이하 선택하세요");
						return false;
					}
				 	var category=$(":input[name=checkbox_category]:checked");
					var tmp="";
					for(var i=0;i<category.length;i++){
						tmp +="<input type='hidden'name='cNo' value="+$(category[i]).val()+">"; 
					}  
					$("#category").html(tmp);
					$("#form-signin").submit();	
			}); //click
			// 아이디 중복 체크
			$(":input[name=id]").keyup(function(){
				var id=$(this).val().trim();
				if(id.length<4 || id.length>10){
					$("#idCheckView").html("아이디는 4자이상 10자 이하여야 함!").css(
							"background","pink");
					checkResultId="";
					return;
				}			
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/idcheckAjax.do",			
					data:"id="+id,	
					success:function(data){						
						if(data=="fail"){
						$("#idCheckView").html(id+" 사용불가!").css("background","blue");
							checkResultId="";
						}else{						
							$("#idCheckView").html(id+" 사용가능!").css(
									"background","red");		
							checkResultId=id;
						}					
					}//callback			
				});//ajax
			});//keyup
		}); //ready
	</script>
	<!-- end: Javascript -->
</body>
</html>