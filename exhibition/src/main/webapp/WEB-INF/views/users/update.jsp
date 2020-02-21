<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/update.jsp</title>
</head>
<body>
<div class="container">
	<c:choose>
		<c:when test="${isSuccess }">
			<script>
				alert("회원 정보를 수정했습니다.");
				location.href="info.do";
			</script>
		</c:when>
		<c:otherwise>
			<h1>Alert</h1>
			<p>
				회원정보 수정 실패!
				<a href="updateform.do">다시 시도 하러가기</a>
			</p>
		</c:otherwise>
	</c:choose>

</div>
</body>
</html>








