<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#writeFundingView").click(function() {
			location.href = "writeFundingView.do?id=${sessionScope.member.id}";
		})
	});
</script>
<div class="col-md-12 padding-0">
	<div class="panel">
		<div class="panel-heading">
			<h4>
				<b>검색어 순위</b>
			</h4>
		</div>
		<div class="panel-body">
			<div class="col-md-12 list-timeline">
				<div class="col-md-12 list-timeline-section bg-light">
					<div class="col-md-12 list-timeline-detail">
						<table id="datatables-example"
							class="table table-striped table-bordered">
							<tr>
								<td>순위</td>
								<td>검색어</td>
							</tr>
							<c:forEach items="${requestScope.rankList }" var="reportMap">
								<tr>
									<td>${reportMap.RANKING }</td>
									<td>${reportMap.KEYWORD }</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- funding List 보여주기 -->
<div class="col-md-12 padding-0">
	<div class="panel">
		<div class="panel-heading">
			<h3>Funding List</h3>
		</div>
		<div class="panel-body">
			<div class="col-md-12 list-timeline">
				<div class="col-md-12 list-timeline-section bg-light">
					<div class="col-md-12 list-timeline-detail">
						<table class="table table-condensed">
							<thead>
								<tr>
									<th>제 목</th>
									<th>작성자</th>
									<th>참여인원</th>
									<th>목표인원</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="flist" items="${requestScope.bList}">
									<c:if test="${flist.FPEOPLE !=null}">
										<tr>
											<td align="center">${flist.FTITLE}</td>
											<td align="center">${flist.id }</td>
											<td align="center">${flist.count }</td>
											<td align="center">${flist.FPEOPLE }</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>