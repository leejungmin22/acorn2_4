<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<%
	// category  라는 파라미터 명으로 전달된 문자열이 있는지 읽어와 본다.
	String category=request.getParameter("category");
	if(category==null){//만일 전달된 내용이 없으면
		category=""; //빈 문자열을 대입한다. (NullPointerExcpetion 방지)
	}

	//로그인된 아이디 읽어와 보기
	String id=(String)session.getAttribute("id");
%>    
<div class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<!-- 홈페이지 링크와 버튼을 넣어둘 div -->
		<div class="navbar-header">
			<a class="navbar-brand" href="${pageContext.request.contextPath }/home.do">Home</a>
			<button class="navbar-toggle" 
				data-toggle="collapse" 
				data-target="#one">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<!-- xs 영역에서는 숨겨졌다가 버튼을 누르면 나오게 할 컨텐츠를 넣을 div -->
		<%-- EL과 JSTL 을 활용해서 변경해보기 --%>
		<div class="collapse navbar-collapse" id="one">
			<ul class="nav navbar-nav">
				<%-- el은 출력할 데이터가 없으면 null 대신 아무것도 출력하지 않으므로 nullpointexception을 발생시키지 않는다 --%>
				<li <c:if test="${param.category eq 'ranking' }">class="active"</c:if>><a href="${pageContext.request.contextPath }/ranking.do">Ranking</a></li>
				<li <c:if test="${param.category eq 'map' }">class="active"</c:if>><a href="${pageContext.request.contextPath }/map.do">지도</a></li>
				<li <c:if test="${param.category eq 'community' }">class="active"</c:if>><a href="${pageContext.request.contextPath }/community/comList.do">자유게시판</a></li>
			</ul>
			
			<c:choose>
				<c:when test="${empty sessionScope.id }">
					<div class="pull-right">
						<a class="btn btn-primary navbar-btn btn-xs" href="${pageContext.request.contextPath }/users/loginform.do">로그인</a>
						<a class="btn btn-warning navbar-btn btn-xs" href="${pageContext.request.contextPath }/users/signup_form.do">회원가입</a>
					</div>
				</c:when>
				<c:otherwise>
					<p class="navbar-text pull-right">
						<strong><a class="navbar-link" href="${pageContext.request.contextPath }/users/info.do">${sessionScope.id }</a></strong>
						<a class="navbar-link" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a> 
					</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>


