<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/resource.jsp" />
<style>
	.box{
		height: 100px;
		background-color: #0f0;
		font-size: 20px;
		font-weight: bold;
		border: 1px solid red;
	}
</style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-sm-4 col-sm-push-4">
			<div class="box">1</div>
		</div>
		<div class="col-sm-4 col-sm-push-4">
			<div class="box">2</div>
		</div>
		<div class="col-sm-4 col-sm-pull-8">
			<div class="box">3</div>
		</div>
	</div>
</div>
</body>
</html>