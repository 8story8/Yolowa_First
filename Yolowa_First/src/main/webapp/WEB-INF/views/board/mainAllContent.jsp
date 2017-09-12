<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
$(function() {
	$("[id^='replyDIV']").hide();
	$("[id^='childReply']").hide();
	// 댓글보기 or 접기
	$("[id^='showReply']").click(function(){
		var bNo=$(this).prev().val();
		$("[id='replyDIV"+bNo+"']").toggle(function(){
			var result=$("[id='replyDIV"+bNo+"']").css("display")=="none";
			if(result){
				$("[id='showReply"+bNo+"']").text("댓글보기");
			}else{			
				$("[id='showReply"+bNo+"']").text("댓글접기");					
			}
		});
	});
	// 대댓글 작성 폼
	$("[id^='viewChildReply']").click(function(){
		var rNo=$(this).prev().val();
		$("[id='childReply"+rNo+"']").toggle(function(){
			var result=$("[id='childReply"+rNo+"']").css("display")=="none";
			if(result){
				$("[id='viewChildReply"+rNo+"']").text("댓글달기");
			}else{			
				$("[id='viewChildReply"+rNo+"']").text("접기");					
			}
		});
	});
	
	// 댓글 작성
   $("[id='writeReply']").click(function(){
      var content="rContent"+$(this).val();
      var rContent=$("textarea[name="+content+"]");
      var mid="${sessionScope.member.id}";
      var filePath="${sessionScope.member.filePath}";
      var bNo=$(this).val();
      $.ajax({
			type:"get",
			url:"writeReply.do",
			dataType:"json",
			data:"rContent="+rContent.val()+"&memberVO.id="+mid+"&boardVO.bNo="+bNo,
			success:function(data){
				$("#replyDIV"+bNo).empty();
				var replyText = "";
				for(var i=0; i<data.length; i++){
					if(data[i].parentsNo==0 && data[i].boardVO.bNo==bNo){
						replyText += "<div class='media'>";
						replyText += "<div class='media-left' style='text-align: center; font-size: 10pt;'>";
						replyText += "<a href='mypage.do?id="+data[i].memberVO.id+"'>";
						if(data[i].memberVO.filePath != "string"){
							replyText += "<img src='${pageContext.request.contextPath}/"+data[i].memberVO.filePath+"' class='media-object box-v7-avatar' width='40' height='40' />";
						}else{
							replyText += "<img src='${pageContext.request.contextPath}/resources/asset/img/avatar.jpg' class='media-object box-v7-avatar' width='40' height='40' />";
						}
						replyText += data[i].memberVO.id+"</a></div>";
						replyText += "<div class='media-body' style='text-align: left: ;'>";
						replyText += "<p>"+data[i].rContent+"</p>";
						replyText += "<a href='#'><input type='hidden' value='"+data[i].rNo+"'>";
						replyText += "<span class='fa fa-angle-down' id='viewChildReply"+data[i].rNo+"'>댓글달기</span></a></div>";
						replyText += "<div id='childReply"+data[i].rNo+"'><div class='col-md-1'></div>";
						replyText += "<div class='media'><div class='media-left' style='text-align: center;'>";
						replyText += "<img src='${pageContext.request.contextPath}/${sessionScope.member.filePath}' class='media-object box-v7-avatar' width='40' height='40' />";
						replyText += "</div><div class='media-body'>";
						replyText += "<textarea class='col-md-10' name='cContent"+data[i].rNo+"' onclick='this.value=''' id='cContent'>내용을 입력하세요</textarea>";
						replyText += "<input type='hidden' value='"+data[i].bNo+"' name='hiddenBno'>";
						replyText += "<button id='writeChildReply' class='btn btn-round pull-right' value='"+data[i].rNo+"'>";
						replyText += "<span>작성</span> <span class='icon-arrow-right icons'></span>";
						replyText += "</button></div></div>";
						replyText += "</div></div>"
						for(var j=0; j<data.length; j++){
							if(data[j].parentsNo==data[i].rNo){
								replyText += "<div id='childDIV"+data[j].parentsNo+"'><div class='col-md-1'>";
								replyText += "<span class='fa fa-chevron-circle-right fa-2x'></span></div>";
								replyText += "<div class='media-left' style='text-align: center; font-size: 10pt;'>";
								replyText += "<a href='mypage.do?id="+data[j].memberVO.id+"'>";
								if(data[j].memberVO.filePath != "string"){
									replyText += "<img src='${pageContext.request.contextPath}/"+data[j].memberVO.filePath+"' class='media-object box-v7-avatar' width='40' height='40' />";
								}else{
									replyText += "<img src='${pageContext.request.contextPath}/resources/asset/img/avatar.jpg' class='media-object box-v7-avatar' width='40' height='40' />";
								}
								replyText += data[j].memberVO.id+"</a></div>";
								replyText += "<div class='media-body' style='text-align: left:;'>";
								replyText += "<p>"+data[j].rContent+"</p></div></div>";
							}
						} 
					}
				}
				$("#replyDIV"+bNo).html(replyText);
				$("[id='replyDIV"+bNo+"']").show();
				$("[id^='childReply']").hide();
				rContent.val("");
			}//success
		});//ajax 
   }); // click
   
   // 대댓글 작성
	$("[id='writeChildReply']").click(function(){
	  var bNo=$(this).prev().val();
	  var parentsNo=$(this).val();
      var content="cContent"+parentsNo;
      var cContent=$("textarea[name="+content+"]");
      var mid="${sessionScope.member.id}";
      //alert(content+", bNo="+bNo+", rNo="+parentsNo+", rContent="+cContent.val());
       $.ajax({
			type : "get",
			url:"writeChildReply.do",
			dataType:"json",
			data:"rContent="+cContent.val()+"&parentsNo="+parentsNo+"&memberVO.id="+mid,
			success:function(data){
				$("#childDIV"+parentsNo).empty();
				var cReplyText = "";
				for(var i=0; i<data.length; i++){
					if(data[i].parentsNo==parentsNo && data[i].boardVO.bNo==bNo){
						cReplyText += "<div class='col-md-1'>";
						cReplyText += "<span class='fa fa-chevron-circle-right fa-2x'></span></div>";
						cReplyText += "<div class='media-left' style='text-align: center; font-size: 10pt;'>";
						cReplyText += "<a href='mypage.do?id="+data[i].memberVO.id+"'>";
						if(data[i].memberVO.filePath != "string"){
							cReplyText += "<img src='${pageContext.request.contextPath}/"+data[i].memberVO.filePath+"' class='media-object box-v7-avatar' width='40' height='40' />";
						}else{
							cReplyText += "<img src='${pageContext.request.contextPath}/resources/asset/img/avatar.jpg' class='media-object box-v7-avatar' width='40' height='40' />";
						}
						cReplyText += data[i].memberVO.id+"</a></div>";
						cReplyText += "<div class='media-body' style='text-align: left:;'>";
						cReplyText += "<p>"+data[i].rContent+"</p></div>";
					}
				}
				$("#childDIV"+parentsNo).html(cReplyText);
				$("[id='replyDIV"+bNo+"']").show();
				$("[id^='childReply']").hide();
				$("[id='viewChildReply"+parentsNo+"']").text("댓글달기");
				cContent.val("");
			}//success
		});//ajax  
   }); // click 
}); // function

function adminLike(bNo){
	$.ajax({
		type:"POST",
		url:"adminLike.do",
		data:{"bNo":bNo, "id":'${sessionScope.member.id}'},
		dataType:"json",
		success:function(data){
			var countLike = $("#countLike"+bNo);
			if(countLike.text() == parseInt(data.length-1)+'명'){
				countLike.html('회원님 외 ' + parseInt(data.length-1) + '명');
			}
			else if(countLike.text() == "회원님 외 " + parseInt(data.length) + "명"){
				countLike.html(parseInt(data.length) + '명');
			}
			else if(parseInt(countLike.text().length) == 0){
				countLike.html('${sessionScope.member.id}'+"님");
			}
			else if(countLike.text() == '${sessionScope.member.id}'+"님"){
				countLike.html("");
			}
		}
	});	
}

</script>
<c:set var="bListSize" value="${fn:length(bList)}" />
<c:set var="localSize" value="0"></c:set>
<c:forEach items="${bList}" var="bList" varStatus="bOrder">
	<c:if test="${bList.FTITLE eq '0'}">
		<div class="col-md-12">
			<!--여기-->
			<div class="panel box-v4">
				<div class="panel-heading bg-white border-none">
					<ul class="nav navbar-nav navbar-right user-nav">
						<li class="dropdown avatar-dropdown"><span
							class="icon-options-vertical" data-toggle="dropdown" /></span>
							<ul class="dropdown-menu user-dropdown">
								<c:choose>
									<c:when test="${sessionScope.member.id ==bList.id}">
										<li><a href="modifyContentView.do?bNo=${bList.bNo}">
												<span class="fa fa-refresh"></span> 수정
										</a></li>
										<li><a href="deleteBoard.do?bNo=${bList.bNo}&type=board"><span
												class="fa fa-trash-o"></span> 삭제 </a></li>
										<li><a href=""><span class="fa fa-star-o"></span>
												즐겨찾기 </a></li>
									</c:when>
									<c:otherwise>
										<li><a href=""><span class=""></span> 찜 </a></li>
									</c:otherwise>
								</c:choose>
							</ul></li>
					</ul>
					<h4>
						<span class="icon-notebook icons"></span> ${bList.bType}
					</h4>
					<div style="display: inline-block; width: 20%; text-align: left;">
						작성자 : ${bList.id}</div>
					<div style="display: inline-block; width: 25%; text-align: right;">
						등록일 : ${bList.bPostdate}</div>
				</div>
				<div class="panel-body padding-0">
					<div class="col-md-12 col-xs-12 col-md-12 padding-0 box-v4-alert">
						<pre> ${bList.bContent} </pre>
						<br>
						<c:if test="${bList.filepath ne '0'}">
							<c:set var="checkFilePath" value="${bList.filepath}" />
							<c:set var="checkFilePathArray" value="${fn:split(checkFilePath,'/')}" />
								<!-- Image Carousel -->
								<div id="imageCarousel${bOrder.count}" class="carousel slide" data-ride="carousel">
    								<!-- Indicators -->
    								<ol class="carousel-indicators">
    									<c:forEach items="${checkFilePathArray}" var="filePath" varStatus="order">
    										<c:choose>
    											<c:when test="${order.count eq 1}">
    												<li data-target="#imageCarousel${bOrder.count}" data-slide-to="${order.count}" class="active"></li>
    											</c:when>
    											<c:otherwise>
    												<li data-target="#imageCarousel${bOrder.count}" data-slide-to="${order.count}"></li>
    											</c:otherwise>
    										</c:choose>
      									</c:forEach>
    								</ol>

    								<!-- Wrapper for slides -->
    								<div class="carousel-inner">
    									<c:forEach items="${checkFilePathArray}" var="filePath" varStatus="order">
    										<c:choose>
    											<c:when test="${order.count eq 1}">
    												<div class="item active">
        												<img src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}" style="width: 100%; height: 300px;" alt="아나${filePath}">
      												</div>
    											</c:when>
    											<c:otherwise>
    			 									<div class="item">
        												<img src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}" style="width: 100%; height: 300px;" alt="아나${filePath}">
     					 							</div>
    											</c:otherwise>
    										</c:choose>
      									</c:forEach>
    								</div>

    								<!-- Left and right controls -->
    								<a class="left carousel-control" href="#imageCarousel${bOrder.count}" data-slide="prev">
      									<span class="glyphicon glyphicon-chevron-left"></span>
										<span class="sr-only">Previous</span>
    								</a>
    								<a class="right carousel-control" href="#imageCarousel${bOrder.count}" data-slide="next">
      									<span class="glyphicon glyphicon-chevron-right"></span>
      									<span class="sr-only">Next</span>
    								</a>
								</div>
  								<br>
						</c:if>
						<c:if test="${bList.local ne '0'}">
							<div class="map" id="map${localSize}"
								style="width: 100%; height: 300px;"></div><br>
							<input type="text" id="org${localSize}">
							<input type="button" id="findRouteBtn${localSize}" value="길찾기">
							<input type="button" class="initRouteBtn" value="초기화">
							<input type="hidden" id="local${localSize}"
								value="${bList.local}">
							<br>
							<c:set var="localSize" value="${localSize+1}"></c:set>
						</c:if>
						<br>
						<a onclick="adminLike('${bList.bNo}')"><span
							class="fa fa-thumbs-o-up fa-2x" id=""></span></a> <span
							id="countLike${bList.bNo}">${bList.countlike}</span>
						&nbsp;&nbsp;&nbsp; <a href="#"><input type="hidden"
							value="${bList.bNo}"> <span class="fa fa-angle-down"
							id="showReply${bList.bNo}">댓글보기</span></a>
					</div>
					<!-- 댓글 -->
					<div class="col-md-12 padding-2 box-v7-comment">
						<div id="replyDIV${bList.bNo}">
							<c:forEach items="${replyList}" var="rList">
								<c:if test="${bList.bNo==rList.boardVO.bNo and rList.parentsNo==0}">
									<div class="media">
										<div class="media-left" style="text-align: center; font-size: 10pt;">
											<a href="mypage.do?id=${rList.memberVO.id}"> 
												<c:choose>
													<c:when test="${rList.memberVO.filePath != 'string'}">
														<img
															src="${pageContext.request.contextPath}/${rList.memberVO.filePath}"
															class="media-object box-v7-avatar" width="40" height="40" />
													</c:when>
													<c:otherwise>
														<img
															src="${pageContext.request.contextPath}/resources/asset/img/avatar.jpg"
															class="media-object box-v7-avatar" width="40" height="40" />
													</c:otherwise>
												</c:choose> 
												${rList.memberVO.id}
											</a>
										</div>
										<div class="media-body" style="text-align: left:;">
											<p>${rList.rContent}</p>
											<a href="#"><input type="hidden" value="${rList.rNo}"><span
												class="fa fa-angle-down" id="viewChildReply${rList.rNo}">댓글달기</span></a>
										</div>
										<!-- 대댓글 작성 폼 -->
										<div id="childReply${rList.rNo}">
											<div class="col-md-1"></div>
											<div class="media">
												<div class="media-left" style="text-align: center;">
													<img
														src="${pageContext.request.contextPath}/${sessionScope.member.filePath}"
														class="media-object box-v7-avatar" width="40" height="40" />
												</div>
												<div class="media-body">
													<textarea class="col-md-10" name="cContent${rList.rNo}"
														onclick="this.value=''" id="cContent">내용을 입력하세요</textarea>
													<input type="hidden" value="${bList.bNo}" name="hiddenBno">
													<button id="writeChildReply"
														class="btn btn-round pull-right" value="${rList.rNo}">
														<span>작성</span> <span class="icon-arrow-right icons"></span>
													</button>
												</div>
											</div>
										</div>
									</div>
									<!-- 대댓글 -->
									<c:forEach items="${replyList}" var="r">
											<div id="childDIV${rList.rNo}">
											<c:if test="${r.parentsNo==rList.rNo}">
												<div class="col-md-1">
													<span class="fa fa-chevron-circle-right fa-2x"></span>
												</div>
												<div class="media-left"
													style="text-align: center; font-size: 10pt;">
													<a href="mypage.do?id=${r.memberVO.id}"> <c:choose>
															<c:when test="${r.memberVO.filePath != 'string'}">
																<img
																	src="${pageContext.request.contextPath}/${r.memberVO.filePath}"
																	class="media-object box-v7-avatar" width="40"
																	height="40" />
															</c:when>
															<c:otherwise>
																<img
																	src="${pageContext.request.contextPath}/resources/asset/img/avatar.jpg"
																	class="media-object box-v7-avatar" width="40"
																	height="40" />
															</c:otherwise>
														</c:choose> ${r.memberVO.id}
													</a>
												</div>
												<div class="media-body" style="text-align: left:;">
													<p>${r.rContent}</p>
												</div>
											</c:if>
										</div>
									</c:forEach>
									<!-- 대댓글 끝 -->
								</c:if>
							</c:forEach>
						</div>
						<!-- 댓글 쓰기 -->
						<div class="media">
							<div class="media-left" style="text-align: center;">
								<img
									src="${pageContext.request.contextPath}/${sessionScope.member.filePath}"
									class="media-object box-v7-avatar" width="40" height="40" />
							</div>
							<div class="media-body">
								<textarea class="col-md-10" name="rContent${bList.bNo}"
									onclick="this.value=''" id="rContent">내용을 입력하세요</textarea>
								<button id="writeReply" class="btn btn-round pull-right"
									value="${bList.bNo}">
									<span>작성</span> <span class="icon-arrow-right icons"></span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:if>
</c:forEach>

<script>
$(document).ready(function(){
   $(".initRouteBtn").click(function(){
      initMap();
      for(var i = 0; i < ${localSize}; i++){
         $("#org"+i).val('');   
      }
   });
});

   function initMap() {
      var map;
      var mapArray = new Array();
      var geocoder = new google.maps.Geocoder();
      var initMarker;
      var initInfoWindow;
      var localSize = ${localSize};
      var tempLocal = new Array();

      var directionsDisplay = new google.maps.DirectionsRenderer();
      var directionsService = new google.maps.DirectionsService;
      var onClickHandler = new Array();

      $.each($('.map'), function(index) {
         var id = this.id;
         var local = $("#local" + index).val();
         var map = new google.maps.Map(document.getElementById(id), {
                        zoom : 16
                     });
         
            geocoder.geocode({'address' : local}, function(results, status) {
            if (status === 'OK') {
               map.setCenter(results[0].geometry.location);
               initInfoWindow = new google.maps.InfoWindow({
                                    content:local
                                 });
                  
               initMarker = new google.maps.Marker({
                              map : map,
                              position : results[0].geometry.location
                           });
               
               initInfoWindow.open(map, initMarker);
               mapArray.push(map);
                                       
               tempLocal.push(results[0].geometry.location);
                                       
               onClickHandler.push(function(){
                  directionsDisplay.setMap(mapArray[index]);
                  findRoute(directionsService, directionsDisplay, index, results[0].geometry.location, mapArray);
               });

               if (tempLocal.length == localSize) {
                  for (var i = 0; i < tempLocal.length; i++) {
                     document.getElementById('findRouteBtn'+ i).addEventListener('click', onClickHandler[i]);
                  }
               }
            } 
            else {
               alert('Fail : '+ status);
            }
         });
      });
   }

var findRouteMarker;
   function findRoute(directionsService, directionsDisplay, index, dest, mapArray) {
      var org = $("#org" + index).val();
      var dest = dest;

      var request = {
         origin : org,
         destination : dest,
         travelMode : google.maps.TravelMode["TRANSIT"]
      }

      directionsService.route(request, function(response, status) {
         if (status == 'OK') {
            var route = response.routes[0].legs[0];
            directionsDisplay.setOptions({suppressMarkers: true});
            var findRouteInfoWindow = new google.maps.InfoWindow({
                  content:org
            });
      
            if (findRouteMarker && findRouteMarker.setMap) {
               findRouteMarker.setMap(null);
            }
            
            findRouteMarker = new google.maps.Marker({
                  position:route.start_location,
                  map: mapArray[index]
            });
            
            findRouteInfoWindow.open(mapArray[index], findRouteMarker);
            directionsDisplay.setDirections(response);

         } else {
            alert("Fail : " + status);
         }
      });
   }
</script>