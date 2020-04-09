<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조이름 : 로그인</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	* {
    margin: 0;
    padding: 0;
    font-family: sans-serif;
	}
	/*배경화면 화면에 꽉 채우기*/
	body{
		background: url(../resources/images/Star.png) no-repeat center center fixed;
		-webkit-background-size: cover;
		-moz-background-size: cover;
		-o-background-size: cover;
		background-size: cover;
	}

	.img-button{
		background:url("../resources/images/google.png");
		border:none;		
		position: absolute;
		top:50%;
		left:50%;
		width:300px;
		height:110px;
		margin:-300px 0px 160px -160px;
		opacity: 0.8; /*투명도*/
	}
		
	/*로그인창 크기,가운데 정렬*/
	.form-signin{
		width:380px;
		height:420px;
		position:absolute;
		left:50%;
		top:50%;
		margin-left:-200px;
		margin-top:-150px;
		overflow:hidden;
		background-color: #ffffff;
        background-color: rgba( 255, 255, 255, 0.8 );
		
	}	
	
	/*아이디, 비밀번호 입력*/
	.input-field {
		width: 100%;
		padding: 10px 10px;
		margin: 10px 10px 10px 10px;
		border: none;
		border-bottom: 1px solid #999;
		outline: none;
		background: transparent;
	}
	
	/*로그인 버튼*/
	.submit{
		width: 85%;
		padding: 10px 30px;
		cursor: pointer;
		display: block;
		margin: 180px 10px 50px 25px;
		background: linear-gradient(to right, #ffde38, #1d4163);
		border: 0;
		outline: none;
		border-radius: 30px;
		zoom: 1;
		filter: alpha(opacity=80); 
		opacity: 0.8;
	}
		
	.checkbox {
		margin: 30px 10px 50px 110px;
		color: #777;
		font-size: 12px;
		bottom: 68px;
		position: absolute;
		cursor: pointer;
	}
	
	.signup {
		height: 20px;
		margin: 0 0 0 300px;
		color: #777;
		font-size: 12px;
		color: #777;
		cursor: pointer;
	}

</style>
</head>
<body>
<div class="wrap">
	<div class="form-wrap">		
			<!-- 차후 이미지 변경(홈페이지명으로) -->
			<button class="img-button" id="button"></button>		
		<form class="form-signin">
			<%-- 폼 제출할때 목적지 정보도 같이 보내준다. --%>
			<input type="hidden" id="url" name="url" value="${url }" />
		
			<label for="id" class="sr-only">아이디</label>
			<input type="text" id="id" name="id" class="input-field" 
				placeholder="아이디입력" value="${savedId }">
			
			<label for="pwd"  class="sr-only">비밀번호</label>
			<input type="password" id="pwd" name="pwd" class="input-field" 
				placeholder="비밀번호입력" value="${savedPwd }">
			<div class="checkbox">
				<label>
					<input type="checkbox" name="isSave" value="yes"/>아이디, 비밀번호 저장
				</label>
			</div>
			<button type="button">Login</button>
			<div class="signup">
				<a href="signup_form.do">회원가입</a>
			</div>
		</form>
	</div>
</div>
</body>
<script>

$("#id, #pwd").on("input", function(){
	var id=$("#id").val();
	var pwd=$("#pwd").val();
	var notEmptyId=id.replace(/ /gi, '');
	var notEmptyPwd=pwd.replace(/ /gi, '');
	$("#id").val(notEmptyId);
	$("#pwd").val(notEmptyPwd);
});

$("button[type=button]").on("click", function(){
	var id=$("#id").val();
	var pwd=$("#pwd").val();
	if(id=="" || pwd==""){
		alert("아이디 또는 비밀번호를 입력해주세요!");
	}else{
		 $.ajax({
				url:"login.do",
				method:"post",
				data:{"id":id, "pwd":pwd, "url":$("#url").val() },
				dataType:"json",
				success:function(responseData){
					console.log(responseData);
					if(responseData.isSuccess==true){
						alert("로그인 되었습니다.");
						location.href=responseData.url;
					}else{
						var loginAgain=confirm("아이디 또는 비밀번호가 틀립니다. 다시 로그인 하시겠습니까?");
						if(loginAgain){
							location.href="loginform.do?url="+responseData.encodedUrl;
						}else{
							location.href=responseData.url;
						}
						
					}
				} 
		});
	}
});//on("click")end

$(".img-button").on("click", function(){
	location.href="${pageContext.request.contextPath }/home.do";
});
</script>
</html>
