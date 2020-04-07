<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	/* 프로필 이미지가 가로 세로 50px 인 원형으로 표시 될수 있도록  */
	#profileLink img{
		width: 200px;
		height: auto;
		border-radius: 50%;
		margin: 30px;
	}
	
	#profileForm{
		display: none;
	}
	.sub-nav-left{
		display:block;
		position:relative;
		font-size:15px;
		float:none;
		margin:10px 0 10px 0;
		text-align:left;
		border-bottom:1px solid #ddd;
		padding:1px 0 5px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic",;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp" />
<div class="container">
	<div class="sub-nav-left">
		<a href="${pageContext.request.contextPath }/home.do">
			<img src="../resources/images/home.png" alt="홈" />
		</a>
		> 
		<a href="${pageContext.request.contextPath }/users/info.do">개인정보 수정</a>
	</div>	
	<h1>개인정보 수정</h1>
	<div style="text-align: center;">
		<a href="javascript:" id="profileLink">
			<c:choose>
				<c:when test="${ empty dto.profile }">
					<img src="${pageContext.request.contextPath }/resources/images/default_user.jpeg"/>
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath }${dto.profile}"/>
				</c:otherwise>
			</c:choose>
		</a>
	</div>
	<table class="table">
		<tr>
			<th>아이디</th>
			<td>${dto.id }</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${dto.name }</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><a class="btn btn-info" href="pwd_updateform.do">수정하기</a></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${dto.email }</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${dto.birth }</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>
				<c:if test="${dto.gender eq 'f' }">여</c:if>
				<c:if test="${dto.gender eq 'm' }">남</c:if>
			</td>
		</tr>

	</table>
	<a class="btn btn-info" href="updateform.do">개인 정보 수정하기</a>
	<a class="btn btn-warning" href="javascript:deleteConfirm()">회원 탈퇴</a>
</div>

<form action="profile_upload.do" method="post" enctype="multipart/form-data" id="profileForm">
	<label for="profileImage">프로필 이미지 선택</label>
	<input type="file" name="profileImage" id="profileImage" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
</form>
<%-- jquery form  플러그인 javascript 로딩 --%>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<script>
	//프로파일 이미지를 클릭하면 
	$("#profileLink").click(function(){
		//강제로 <input type="file" /> 을 클릭해서 파일 선택창을 띄우고
		$("#profileImage").click();
	});
	//input type="file" 에 파일이 선택되면 
	$("#profileImage").on("change", function(){
		//폼을 강제 제출하고 
		$("#profileForm").submit();
	});
	
	// jquery form 플러그인의 동작을 이용해서 폼이 ajax 로 제출되도록 한다. 
	$("#profileForm").ajaxForm(function(responseData){
		//responseData 는 plain object 이다.
		//{savedPath:"/upload/저장된이미지파일명"}
		//savedPath 라는 방에 저장된 이미지의 경로가 들어 있다.
		console.log(responseData);
		var src="${pageContext.request.contextPath }"+responseData.savePath;
		// img 의 src 속성에 반영함으로써 이미지가 업데이트 되도록 한다.
		$("#profileLink img").attr("src", src);
	});
	

	function deleteConfirm(){
		var isDelete=confirm("${id} 님 탈퇴 하시겠습니까?");
		if(isDelete){
			location.href="delete.do";
		}
	}
</script>
</body>
</html>
