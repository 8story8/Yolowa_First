<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- 알림창 CDN -->
<script src="//cdn.jsdelivr.net/alertifyjs/1.7.1/alertify.min.js"></script><!-- JavaScript -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/alertify.min.css"/><!-- CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/default.min.css"/><!-- Default theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/semantic.min.css"/><!-- Semantic UI theme -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/alertifyjs/1.7.1/css/themes/bootstrap.min.css"/><!-- Bootstrap theme -->
<script type="text/javascript">
	$(function() {
		$("#searhAll").click(function(){
			if($.trim($("#keywordAll").val())==""){
				alert("검색어를 입력하세요");
				$("#keywordAll").focus();
				return ;
			}else{
				location.href = "searchListByKeyword.do?keyword="+$.trim($("#keywordAll").val());
			}
		}); // click(searhAll)
		
		$( "#keywordAll" ).autocomplete({
	        source : function( request, response ) {
	             $.ajax({
	                    type: "get",
	                    url: "autoKeyword.do",
	                    dataType: "json",
	                    data: "keyword="+$.trim($("#keywordAll").val()),
	                    success: function(data) {
	                        response(
	                            $.map(data, function(item) {
	                                return {
	                                    label: item.KEYWORD,
	                                    value: item.KEYWORD
	                                } // return
	                            }) // map
	                        ); // response
	                    } // success
	               }); // ajax
	            }, // source
	    });	// autocomplete
	});	// function
</script>

<div class="col-md-12 nav-wrapper">
   <div class="navbar-header" style="width: 100%;">

      <div class="opener-left-menu is-open">
         <span class="top"></span> <span class="middle"></span> <span
            class="bottom"></span>
      </div>
		<c:choose>
			<c:when test="${sessionScope.member ne null}">
				 <a href="mainAllContent.do?id=${sessionScope.member.id}" class="navbar-brand"> <b>YOLO WA</b></a>
				  <ul class="nav navbar-nav search-nav">
         <li>
            <div class="search">
               <span class="fa fa-search icon-search" style="font-size: 23px;"
                  id="searhAll"></span>
               <div class="form-group form-animate-text">
                  <input type="text" class="form-text" id="keywordAll" required>
                  <span class="bar"></span> <label class="label-search">Type
                     anywhere to <b>Search</b>
                  </label>
               </div>
            </div>
         </li>
      </ul>
			</c:when>
			<c:otherwise>
				 <a href="home.do" class="navbar-brand"> <b>YOLO WA</b></a>
			</c:otherwise>
		</c:choose>
     
      <ul class="nav navbar-nav navbar-right user-nav">
         <c:choose>
            <c:when test="${sessionScope.member == null }">
               <li><a href="loginView.do"><span class="fa fa-power-off">
                        LogIn</span></a></li>
               <li><a href="registerView.do"><span class="fa fa-user">
                        SignUp</span></a></li>
            </c:when>
            <c:otherwise>
            
               <li class="user-name"><span>${sessionScope.member.name}</span></li>
               <li class="dropdown avatar-dropdown"><img
                  src="${pageContext.request.contextPath }/${sessionScope.member.filePath}"
                  class="img-circle avatar" alt="user name" data-toggle="dropdown"
                  aria-haspopup="true" aria-expanded="true" />
                  <ul class="dropdown-menu user-dropdown">
                     <li><a href="myMessagePage.do"><span class="fa fa-envelope"></span>　My Message</a></li>
                     <li><a href="mypage.do?id=${sessionScope.member.id}"><span class="fa fa-user"></span>　 My Page</a></li>   
                     <li role="separator" class="divider"></li>
                     <li><a href="#" id="logoutClick"><span class="fa fa-power-off "></span>　 Logout</a></li>
                  </ul>
               </li>
               <li><a href="#" class="opener-right-menu"><span
                     class="icon-list" id="tabBtn"></span></a></li>
            </c:otherwise>
         </c:choose>
      </ul>
   </div>
</div>
<script type="text/javascript">
   $(document).ready(function() {
	   var sound = new Audio("${pageContext.request.contextPath}/resources/asset/media/alarm.mp3");
      $("#logoutClick").click(function() {
         var flag = confirm("로그아웃을 하시겠습니까?");
         if (flag == true) {
            location.href = "logout.do";
         }//if
      });//click
      /* 알림 script */
      if(${sessionScope.member != null }){
    	  $.ajax({
				type:"get",
				url:"requestList.do",
				dataType:"json",
				success:function(data){
					if(data != ""){
						alertify.success('친구 신청이 왔어요!!~~');
						sound.play();
						setInterval(() => {
							alertify.success('친구 신청이 왔어요!!~~');
							sound.play();
						}, 20000);
					}//if
				}//success
			});//ajax
			
			$.ajax({
				type:"get",
				url:"requestMsg.do",
				dataType:"json",
				success:function(data){
					if(data != ""){
						alertify.success('메세지가 왔어요!!~~');
						sound.play();
						setInterval(() => {
							alertify.success('메세지가 왔어요!!~~');
							sound.play();
						}, 20000);
					}//if
				}//success
			});//ajax
			
			
			
			
			
         }//if
      });//ready
</script>

