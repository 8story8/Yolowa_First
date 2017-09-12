<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- content -->
<c:if test="${sessionScope.member != null}">
   <!-- Content/Funding -->
   <div class="search-v1 panel">
      <div class="panel-body">
         <div class="col-md-12"></div>
         <ul id="tabs-demo6" class="nav nav-tabs nav-tabs-v6 masonry-tabs"
            role="tablist">
            <li role="presentation"><a
               href="${pageContext.request.contextPath}/mainAllContent.do?id=${sessionScope.member.id}">컨텐츠 보기</a></li>

            <li role="presentation"><a
               href="${pageContext.request.contextPath}/writeContentView.do" >컨텐츠 쓰기</a></li>
               
                <li role="presentation"><a
               href="${pageContext.request.contextPath}/mainAllContent.do?id=${sessionScope.member.id}&type=funding">펀딩 글보기</a></li>   
               
             <li role="presentation"><a
               href="${pageContext.request.contextPath}/writeFundingView.do">펀딩 글쓰기</a></li>
         </ul>
      </div>
   </div>
</c:if>