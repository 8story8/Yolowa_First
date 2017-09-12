<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
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
	function applyFunding(bNo){
		var type=$("#applyType").val();
		$.ajax({
			type:"POST",
			url:"applyFunding.do",
			data:{"bNo":bNo, "id":'${sessionScope.member.id}',"type":type},
			dataType:"json",
			success:function(data){
				alert("신청완료");
				location.reload();
				}
			
		});
}
</script>
<c:set var="bListSize" value="${fn:length(bList)}" />
<c:set var="localSize" value="0"></c:set>
<c:forEach items="${bList}" var="bList">
	<c:if test="${bList.FTITLE ne '0'}">
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
										<li><a href="modifyFundingView.do?bNo=${bList.bNo}">
												<span class="fa fa-refresh"></span> 수정
										</a></li>
										<li><a href="deleteBoard.do?bNo=${bList.bNo}&type=funding">
											<span class="fa fa-trash"></span> 삭제 </a></li>
										<li><a href=""><span class="fa fa-star-o"></span>
												즐겨찾기 </a></li>
									</c:when>
									<c:otherwise>
										<li><a href=""><span class="fa fa-star-o"></span> 즐겨찾기 </a></li>
									</c:otherwise>
								</c:choose>
							</ul></li>
					</ul>
				<h4>
					<span class="icon-notebook icons"></span> ${bList.bType}
				</h4>
					<div style="display: inline-block;width: 20%;text-align: left;"> 
					작성자 : ${bList.id}
					</div>
					<div style="display: inline-block;width: 50%;text-align: center;"> 
					제목 : ${bList.FTITLE}
					</div>
					<div style="display: inline-block;width: 25%;text-align: right;"> 
					등록일 : ${bList.bPostdate}
					</div>
			</div>
			<div class="panel-body padding-0">
				<div class="col-md-12 col-xs-12 col-md-12 padding-0 box-v4-alert">
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
						<div style="display: inline-block;width: 35%;text-align:center;">
							현재/목표포인트 <br>
							${bList.totalpoint} 
							<progress value="${bList.totalpoint}" max="${bList.FPOINT}">
							</progress> 
							${bList.FPOINT}<br>
						</div>
						<div style="display: inline-block;width: 35%;text-align:center;">
							현재/목표인원 <br>
							${bList.count} 
							<progress value="${bList.count}" max="${bList.FPEOPLE}">
							</progress>
							${bList.FPEOPLE}<br>
						</div>
						<div style="display: inline-block;width: 25%;text-align: center;">
						 마감일<br>
						 ${bList.FDEADLINE}
						</div>
					<br><br>
					<pre>${bList.bContent}</pre>
					<c:if test="${bList.local ne '0'}">
						<div class="map" id="map${localSize}"
							style="width: 100%; height: 300px;"></div>
						<input type="text" id="org${localSize}">
						<input type="button" id="findRouteBtn${localSize}" value="길찾기">
						<input type = "button" class = "initRouteBtn" value = "초기화">
						
						<input type="hidden" id="local${localSize}" value="${bList.local}">
						<br>
						<c:set var="localSize" value="${localSize+1}"></c:set>
					</c:if>
					<a onclick="adminLike('${bList.bNo}')"><span
							class="fa fa-thumbs-o-up fa-2x" id=""></span></a> <span
							id="countLike${bList.bNo}">${bList.countlike}</span>
						<c:choose>
							<c:when test="${bList.id != sessionScope.member.id}">
								<div class="col-md-6 col-sm-6 col-xs-6 padding-0"
									style="float: right;">
									<div class="col-md-6 col-sm-6 col-xs-6 tool"></div>
										<button id="applyType" value="apply" class="btn btn-round pull-right" onclick="applyFunding('${bList.bNo}')">
											<span id="checkFunding">신청</span> <span class="icon-arrow-right icons"></span>
										</button>
								</div>
							</c:when>
							<c:when test="${bList.id == sessionScope.member.id}">
							</c:when>
						</c:choose>
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
						
													initMarker = new google.maps.Marker(
																 {
																	map : map,
																	position : results[0].geometry.location,
																});
													initInfoWindow.open(map, initMarker);
													mapArray.push(map);
													
													tempLocal.push(results[0].geometry.location);
													
													onClickHandler.push(function() {
																directionsDisplay.setMap(mapArray[index]);
																findRoute(directionsService, directionsDisplay, index, results[0].geometry.location, mapArray);
													});



					if (tempLocal.length == localSize) {
														for (var i = 0; i < tempLocal.length; i++) {

															document.getElementById('findRouteBtn'+ i).addEventListener('click', onClickHandler[i]);
														}
													}
												} else {
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
