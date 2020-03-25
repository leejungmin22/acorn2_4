<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조이름:로그인</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>

#bread{
		background-color: #FAEBD7;		
	}

</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"/>
<div class="container">
	<ol class="breadcrumb" id="bread">
		<li><a href="${pageContext.request.contextPath }/community/comList.do">목록</a></li>
		<li>로그인</li>
	</ol>
	<c:choose>
		<c:when test="${not empty sessionScope.id }">
			<script type="text/javascript">
				location.href="${pageContext.request.contextPath}/home.do?url=${pageContext.request.contextPath}/detail.do?seq=${dto.seq}";
			</script>
		</c:when>
		<c:otherwise>
			<p>
				아이디 혹은 비밀번호가 틀려요!
				<a href="loginform.do?url=${encodedUrl }">다시 로그인 하러 가기</a>
			</p>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>






