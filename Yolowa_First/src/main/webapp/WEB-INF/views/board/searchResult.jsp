<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
</script>
<c:set var="sListSize" value="${fn:length(sList)}" />
<c:set var="localSize" value="0"></c:set>
<div class="search-v1 panel">
	<div class="panel-body">
		<div class="col-md-12">
		</div>
		<ul id="tabs-demo6" class="nav nav-tabs nav-tabs-v6 masonry-tabs"
			role="tablist">
			<li role="presentation" class="active" id="searchLi">
			<a
				href="#tabs-demo7-area1" id="tabs-demo6-1" role="tab"
				data-toggle="tab" aria-expanded="true">Content</a>
				</li>
				
			<li role="presentation" class="" id="searchLi">
			<a
				href="#tabs-demo7-area2" role="tab" id="tabs-demo6-2"
				data-toggle="tab" aria-expanded="false">User</a>
				</li>
		</ul>
	</div>
</div>
<div class="col-md-12">
	<div class="col-md-12 tabs-area box-shadow-none">
		<div id="tabsDemo6Content"
			class="tab-content tab-content-v6 col-md-12">
			<div role="tabpanel" class="tab-pane search-v1-menu1 fade active in"
				id="tabs-demo7-area1" aria-labelledby="tabs-demo7-area1">
				<div class="col-md-12 padding-0">
					<c:forEach items="${searchList}" var="sList" varStatus="sOrder">
						<div class="panel box-v4">
							<div class="panel-heading bg-white border-none">
								<h4>
									<span class="icon-notebook icons"></span> ${sList.bType}
								</h4>
								<div style="display: inline-block; width: 20%; text-align: left;">
						작성자 : ${sList.id}</div>
					<div style="display: inline-block; width: 30%; text-align: right;">
						등록일 : ${sList.bPostdate}</div>
							</div>
							<div class="panel-body padding-0">
								<div
									class="col-md-12 col-xs-12 col-md-12 padding-0 box-v4-alert">
										<pre> ${sList.bContent} </pre>
										<br>
										<!-- Image Carousel -->
										<c:if test="${sList.filepath ne '0'}">
										<c:set var="checkFilePath" value="${sList.filepath}" />
										<c:set var="checkFilePathArray" value="${fn:split(checkFilePath,'/')}" />
								<div id="imageCarousel${sOrder.count}" class="carousel slide" data-ride="carousel">
    								<!-- Indicators -->
    								<ol class="carousel-indicators">
    									<c:forEach items="${checkFilePathArray}" var="filePath" varStatus="order">
    										<c:choose>
    											<c:when test="${order.count eq 1}">
    												<li data-target="#imageCarousel${sOrder.count}" data-slide-to="${order.count}" class="active"></li>
    											</c:when>
    											<c:otherwise>
    												<li data-target="#imageCarousel${sOrder.count}" data-slide-to="${order.count}"></li>
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
    								<a class="left carousel-control" href="#imageCarousel${sOrder.count}" data-slide="prev">
      									<span class="glyphicon glyphicon-chevron-left"></span>
										<span class="sr-only">Previous</span>
    								</a>
    								<a class="right carousel-control" href="#imageCarousel${sOrder.count}" data-slide="next">
      									<span class="glyphicon glyphicon-chevron-right"></span>
      									<span class="sr-only">Next</span>
    								</a>
								</div>
  								<br>
  								</c:if>
										<c:if test="${sList.local ne '0'}">
							<div class="map" id="map${localSize}"
								style="width: 100%; height: 300px;"></div><br>
							<input type="text" id="org${localSize}">
							<input type="button" id="findRouteBtn${localSize}" value="길찾기">
							<input type="button" class="initRouteBtn" value="초기화">
							<input type="hidden" id="local${localSize}"
								value="${sList.local}">
							<br>
							<c:set var="localSize" value="${localSize+1}"></c:set>
						</c:if>
										<br>
										<a onclick="adminLike('${sList.bNo}')">
										<span class="fa fa-thumbs-o-up fa-2x" id=""></span></a>
										<span id="countLike${sList.bNo}">${sList.countlike}</span>
											 <input
											type="hidden" id="local${sList.bNo}" value="${sList.local}">
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div role="tabpanel" class="tab-pane fade" id="tabs-demo7-area2"
				aria-labelledby="tabs-demo7-area2">
				<div class="col-md-12 padding-0">
				<div class="panel box-v4">
					<c:forEach items="${searchMemberList}" var="smList">
						<div class="col-md-12 padding-0">
                                  <div class="col-md-10 padding-0">
                                  <c:choose>
                                  <c:when test="${smList.filePath != 'string'}">
                                  	<img src="${pageContext.request.contextPath}/${smList.filePath}" class="box-v7-avatar pull-left" 
                                  				width="75" height="75"/>
                                  </c:when>
                                  <c:otherwise>
                                  	<img src="${pageContext.request.contextPath}/resources/asset/img/avatar.jpg" class="box-v7-avatar pull-left" 
                                  				width="75" height="75"/>
                                  </c:otherwise>
                                  </c:choose>
                                  <h4>&nbsp;${smList.id}</h4>
                                  <p>
                                  &nbsp;이름 : ${smList.name}<br>
                                  &nbsp;타입 : <c:forEach items="${smList.categoryVO}" var="cateList">${cateList.cType}&nbsp;</c:forEach></p>
                                  </div>
                         </div>
					</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

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
