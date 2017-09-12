<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="//code.jquery.com/jquery.min.js"></script>
<title>YoloWa</title>
<jsp:include page="/resources/asset/util/plugutill.html"></jsp:include>
<body id="mimin" class="dashboard form-signin-wrapper">
   <script>
      $(document)
            .ready(
                  function() {
                     var checkResultId = "";
                     $("#checkForm").hide();
                     $("#up").hide();
                     $("#down").click(function() {
                     $("#checkForm").toggle();
                        $("#down").hide();
                        $("#up").show();
                     }); //click
                     $("#up").click(function() {
                        $("#checkForm").hide();
                        $("#down").show();
                        $("#up").hide();
                     }); //click
                     $("#form-signin")
                           .submit(
                                 function() {
                                    if ($(":input[name=password]")
                                          .val().trim() == "") {
                                       alert("패스워드를 입력하세요");
                                       return false;
                                    }
                                    if ($(":input[name=name]")
                                          .val().trim() == "") {
                                       alert("이름을 입력하세요");
                                       return false;
                                    }
                                    if ($(":input[name=phone]")
                                          .val().trim() == "") {
                                       alert("번호를 입력하세요");
                                       return false;
                                    }
                                    if ($(":input[name=address]")
                                          .val().trim() == "") {
                                       alert("주소를 입력하세요");
                                       return false;
                                    }
                                    if ($(":input[name=checkbox_category]:checked").length < 1
                                          || $(":input[name=checkbox_category]:checked").length > 3) {
                                       alert("카테고리를 1개 이상 3개 이하 선택하세요");
                                       return false;
                                    }
                                    var category = $(":input[name=checkbox_category]:checked");
                                    var tmp = "";
                                    for (var i = 0; i < category.length; i++) {
                                       tmp += "<input type='hidden'name='cNo' value="
                                             + $(category[i])
                                                   .val()
                                             + ">";
                                    }
                                    $("#category").html(tmp);
                                    alert(tmp);
                                 });
                  });
   </script>
<body id="mimin" class="dashboard form-signin-wrapper">
	<div class="container">
		<form method="post" id="form-signin" name="form-signin"
			class="form-signin"
			action="${pageContext.request.contextPath}/modifyMember.do">
			<div class="panel periodic-login">
				<div class="panel-body text-center">
					<h1>
						<a href="home.do">YOLO WA!</a>
					</h1>
					<p class="element-name">You Only Live Once</p>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<div style="text-align: left">&nbsp;&nbsp;ID</div>
						<input type="text" class="form-text" name="id"
							value="${sessionScope.member.id }" id="id" readonly="readonly">
						<span class="bar"></span>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important">
						<input type="password" name="password" class="form-text"
							value="${sessionScope.member.password}" id="password"
							required="required"> <span class="bar"></span><label>PASSWORD</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name="name" class="form-text" id="name"
							value="${sessionScope.member.name }" required="required">
						<span class="bar"></span> <label>NAME</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name="phone" class="form-text"
							value="${sessionScope.member.phone }" id="phone"
							required="required"> <span class="bar"></span> <label>PHONE</label>
					</div>
					<div class="form-group form-animate-text"
						style="margin-top: 20px !important;">
						<input type="text" name="address" class="form-text"
							value="${sessionScope.member.address }" id="address"
							required="required"> <span class="bar"></span> <label>ADDRESS</label>
					</div>
					<div style="font-size: 18px">
						<label>CARTEGORY</label><br> <i class="icons icon-arrow-down"
							id="down"></i> <i class="icons icon-arrow-up" id="up"></i>
						<div id="checkForm">
						<c:forEach items="${categoryList}" var="category" >
							<c:choose>
								<c:when test="${category.cNO == requestScope.cList[0].cNO}">
									<input type="checkbox" name="checkbox_category"
											value="${category.cNO}" style="width: 30px"
											checked="checked">${category.cType}
								</c:when>
								<c:when test="${category.cNO == requestScope.cList[1].cNO}">
									<input type="checkbox" name="checkbox_category"
											value="${category.cNO}" style="width: 30px"
											checked="checked">${category.cType}
								</c:when>
								<c:when test="${category.cNO == requestScope.cList[2].cNO}">
									<input type="checkbox" name="checkbox_category"
											value="${category.cNO}" style="width: 30px"
											checked="checked">${category.cType}
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="checkbox_category"
											value="${category.cNO}" style="width: 30px"
											>${category.cType}
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</div>
					</div>
					<br> <input type="submit" id="modyfy" class="btn col-md-12"
						value="회원정보수정" />
				</div>
			</div>
			<div id="category"></div>
		</form>
	</div>
	<jsp:include page="/resources/asset/util/scriptutill.html"></jsp:include>
</body>
