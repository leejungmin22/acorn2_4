<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<div class="container">
	<h1>회원정보 수정폼</h1>
	<form action="update.do" method="post">
		<input type="hidden" name="id" value="${id }"/>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" id="id" value="${id }" disabled/>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="text" id="email" name="email" value="${dto.email }"/>
		</div>
		<div class="form-group">
			<label for="gender">성별</label>
			<select class="form-control" name="gender" id="gender">
				<option value="f" <c:if test="${gender eq 'f' }">selected</c:if>>여</option>
				<option value="m" <c:if test="${gender eq 'm' }">selected</c:if>>남</option>
			</select>
		</div>
		<div class="form-group">
			<label for="phone">전화번호</label>
			<input class="form-control" type="text" id="phone" value="${dto.phone }" />
		</div>
		
		<button class="btn btn-primary" type="submit">수정확인</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
		
</div>
</body>
</html>










