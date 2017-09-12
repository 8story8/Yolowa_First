<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".panel-body").on("click","b",function(){
			var id = $(this).prev().val();
    	  $.ajax({
    		  type:"get",
              url:"friendDelete.do?id="+id,
              success:function(data){
            	  if(data == "ok"){
            		  location.href="MyListPage.do?id=${sessionScope.member.id}";
     				}
     				else{
     					alert("친구 삭제가 실패했습니다.");
     				}
              }//success
    	  });//ajax
		});//on
	});//ready
</script>
<div class="col-md-6">
	<div class="panel">
		<div class="panel-heading">
			<h3 style="text-align: center;">친구</h3>
		</div>
			<c:forEach items="${flist}" var="flist">
			<div class="panel-body">
				<div class="col-md-12 list-timeline">
					<div class="col-md-12 list-timeline-section bg-light">
						<div class="col-md-12 list-timeline-detail">
							<div align="center" >
								<h3>
									<a  href="mypage.do?id=${flist.id}">${flist.name}</a>
									<span>
									<img style="width: 80px; height: 80px; border-radius: 50%; position: absolute;" 
									src="${pageContext.request.contextPath}/${flist.filePath}"></span>
									<input type='hidden' id='hiddenId' value="${flist.id}">
									<b style="position: relative; top: 40px; left: 60px;" class="fa fa-user-times fa-2x" ></b>
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
	</div>
</div>
<div class="col-md-6">
	<div class="panel">
		<div class="panel-heading">
			<h3 style="text-align: center;">My Point: ${sessionScope.member.point }</h3>
		</div>
		<div class="panel-body">
			<div class="col-md-12 list-timeline">
				<div class="col-md-12 list-timeline-section bg-light">
					<div class="col-md-12 list-timeline-detail">
						<div align="center">
							<table style="text-align: center; font-size: 14pt;">
								<thead>
									<tr>
										<td>적립 일자</td>
										<td>내용</td>
										<td>적립 포인트</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${plist}" var="plist">
										<tr>
											<td>${plist.lDate}</td>
											<td>${plist.lContent}</td>
											<td>${plist.point}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>