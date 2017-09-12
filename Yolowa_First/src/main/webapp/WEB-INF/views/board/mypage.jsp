<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script src="//code.jquery.com/jquery.min.js"></script>
<style>
#friendList, #pointList {
	cursor: pointer
}

b {
	cursor: default
}

.dropdown {
	cursor: pointer
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#friendList").click(function() {
			location.href = "MyListPage.do?id=${sessionScope.member.id}";
		});//click
		$("#pointList").click(function() {
			location.href = "MyListPage.do?id=${sessionScope.member.id}";
		});//click
	});//ready
</script>
<div class="profile-v1 col-md-12 col-sm-12 profile-v1-wrapper">
	<div class="col-md-9  profile-v1-cover-wrap"
		style="padding-right: 0px;">
		<c:choose>
			<c:when test="${!empty fvo}">
				<div class="profile-v1-pp">
					<ul class="nav navbar-nav navbar-right user-nav" id="name">
						<li class="dropdown avatar-dropdown"><img
							src="${pageContext.request.contextPath}/${fvo.filePath}"
							alt="user name" data-toggle="dropdown" /></li>
						<h2>
							<b>${fvo.name }</b>
						</h2>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="profile-v1-pp">
					<ul class="nav navbar-nav navbar-right user-nav">
						<li class="dropdown avatar-dropdown"><img
							src="${pageContext.request.contextPath}/${sessionScope.member.filePath}"
							alt="user name" data-toggle="dropdown" />

							<ul class="dropdown-menu user-dropdown">
								<li data-toggle="modal" data-target="#myModal">
									<!-- Trigger the modal with a button --> <a href="#"> <span
										class="fa fa-instagram"></span>Change Photo
								</a>
								</li>
								<li><a href="modifyView.do?id=${sessionScope.member.id }"><span
										class="fa fa-user"></span> My Info</a></li>
							</ul></li>
						<h2>
							<b>${sessionScope.member.name }</b>
						</h2>
					</ul>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="col-md-12 profile-v1-cover">
			<img
				src="${pageContext.request.contextPath }/resources/asset/img/bg1.jpg"
				class="img-responsive">

		</div>

	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Change Photo</h4>
				</div>
				<div class="modal-body">
					<form
						action="${pageContext.request.contextPath}/multifileupload.do"
						method="post" enctype="multipart/form-data" id="fileUpload">
						사진<input type="file" name="file[0]"><br> <input
							type="submit" value="멀티파일업로드"> <input type="hidden"
							name="userInfo" value='${sessionScope.member.id }'>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	<div class="col-md-3 col-sm-12 padding-0 profile-v1-right">
		<c:choose>
			<c:when test="${!empty fvo}">
				<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
					<div
						class="col-md-12 padding-0 sub-profile-v1-right text-center sub-profile-v1-right1">
						<h2>Friends</h2>
						<p>${requestScope.friendList }</p>
					</div>
				</div>
				<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
					<div
						class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2">
						<h2>Point</h2>
						<p>${requestScope.fvo.point }</p>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
					<div
						class="col-md-12 padding-0 sub-profile-v1-right text-center sub-profile-v1-right1"
						id="friendList">
						<h2>Friends</h2>
						<p>${requestScope.friendList }</p>
					</div>
				</div>
				<div class="col-md-12 col-sm-4 profile-v1-right-wrap padding-0">
					<div
						class="col-md-12 sub-profile-v1-right text-center sub-profile-v1-right2"
						id="pointList">
						<h2>Point</h2>
						<p>${sessionScope.member.point }</p>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<!--  ㅂㅏ디  -->
<c:set var="bListSize" value="${fn:length(bList)}" />
<c:set var="localSize" value="0"></c:set>
<c:forEach items="${bList}" var="bList">
	<c:if test="${bList.FTITLE eq '0'}">
		<c:if test="${bList.id == requestScope.ID}">
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
											<li><a href="deleteMypage.do?bNo=${bList.bNo}"><span
													class="fa-trash-o"></span> 삭제 </a></li>
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
								<c:set var="checkFilePathArray"
									value="${fn:split(checkFilePath,'/')}" />
								<c:forEach items="${checkFilePathArray}" var="filePath">
									<img
										src="${pageContext.request.contextPath}/resources/asset/upload/${filePath}"
										style="width: 50%; height: 100x;" alt="아나${filePath}">
									<br>
								</c:forEach>
							</c:if>
							<c:if test="${bList.local ne '0'}">
								<div class="map" id="map${localSize}"
									style="width: 100%; height: 300px;"></div>
								<input type="text" id="org${localSize}">
								<input type="button" id="findRouteBtn${localSize}" value="길찾기">
								<input type="button" class="initRouteBtn" value="초기화">
								<input type="hidden" id="local${localSize}"
									value="${bList.local}">
								<br>
								<c:set var="localSize" value="${localSize+1}"></c:set>
							</c:if>
							<a onclick="adminLike('${bList.bNo}')"><span
								class="fa fa-thumbs-o-up fa-2x" id=""></span></a> <span
								id="countLike${bList.bNo}">${bList.countlike}명</span>
							&nbsp;&nbsp;&nbsp; <a href="#"><input type="hidden"
								value="${bList.bNo}" name="hiddenBno"> <span
								class="fa fa-angle-down" id="showReply">댓글보기</span></a>
						</div>
						<!-- 댓글 -->
						<div class="col-md-12 padding-2 box-v7-comment">
							<div id="replyDIV${bList.bNo}" style="display: none;">
								<c:forEach items="${replyList}" var="rList">
									<c:if
										test="${bList.bNo==rList.boardVO.bNo and rList.parentsNo==0}">
										<div class="media">
											<div class="media-left"
												style="text-align: center; font-size: 10pt;">
												<a href="#"> <!-- 친구의 마이페이지로 이동 --> <img
													src="${pageContext.request.contextPath}/resources/asset/img/avatar2.png"
													class="media-object box-v7-avatar" width="40" height="40" />
													${rList.memberVO.id}
												</a>
											</div>
											<div class="media-body" style="text-align: left:;">
												<p>${rList.rContent}</p>
												<a href="#"><input type="hidden" value="${rList.rNo}"><span
													class="fa fa-angle-down" id="viewChildReply">댓글달기</span></a>
											</div>
											<!-- 대댓글 작성 폼 -->
											<div id="childReply${rList.rNo}" style="display: none;">
												<div class="col-md-1"></div>
												<div class="media">
													<div class="media-left" style="text-align: center;">
														<img
															src="${pageContext.request.contextPath}/resources/asset/img/avatar2.png"
															class="media-object box-v7-avatar" width="50" height="50" />
														${sessionScope.member.id}
													</div>
													<div class="media-body">
														<textarea class="col-md-10" name="cContent${bList.bNo}"
															onclick="this.value=''" id="cContent">내용을 입력하세요</textarea>
														<input type="hidden" value="${rList.rNo}" name="hiddenBno">
														<button id="writeChildReply"
															class="btn btn-round pull-right" value="${bList.bNo}">
															<span>작성</span> <span class="icon-arrow-right icons"></span>
														</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 대댓글 -->
										<c:forEach items="${replyList}" var="r">
											<c:if test="${r.depth==1 and r.parentsNo==rList.rNo}">
												<div id="test">
													<div class="col-md-1">
														<span class="fa fa-chevron-circle-right fa-2x"></span>
													</div>
													<div class="media-left"
														style="text-align: center; font-size: 10pt;">
														<a href="#"> <!-- 친구의 마이페이지로 이동 --> <img
															src="${pageContext.request.contextPath}/resources/asset/img/avatar2.png"
															class="media-object box-v7-avatar" width="40" height="40" />
															${r.memberVO.id}
														</a>
													</div>
													<div class="media-body" style="text-align: left:;">
														<p>${r.rContent}</p>
													</div>
												</div>
											</c:if>
										</c:forEach>
										<!-- 대댓글 끝 -->
									</c:if>
								</c:forEach>
							</div>
							<!-- 댓글 쓰기 -->
							<div class="media">
								<div class="media-left" style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/resources/asset/img/avatar2.png"
										class="media-object box-v7-avatar" width="50" height="50" />
									${sessionScope.member.id}
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

<!-- end: content -->





