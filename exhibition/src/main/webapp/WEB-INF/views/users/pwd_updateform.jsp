<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<jsp:include page="../include/resource.jsp"/>
<style type="text/css">
	/* 페이지 로딩 시점에 도움말과 피드백 아이콘은 일단 숨기기 */
	.help-block, .form-control-feedback{
		display: none;
	
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp" />
<div class="container">
	<h1>비밀번호 수정 페이지</h1>
	<form action="pwd_update.do" method="post">
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd">기존 비밀번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd"/>
			<p class="help-block" id="oldPwd_required">필수 정보입니다.</p>
			<p class="help-block" id="oldPwd_notmatch">기존의 비밀번호와 맞지 않습니다.</p>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="newPwd">새 비밀번호</label>
			<input class="form-control" type="password" id="newPwd" name="newPwd"/>
			<p class="help-block" id="pwd_required">필수 정보입니다.</p>
			<p class="help-block" id="pwd_notmatch">비밀번호는 영어, 특수문자를 포함하여 8~15자리로 입력해야합니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="newPwd2">새 비밀번호 확인</label>
			<input class="form-control" type="password" id="newPwd2" name="newPwd2"/>
			<p class="help-block" id="pwd2_required">필수 정보입니다.</p> 
			<p class="help-block" id="pwd2_notequal">새 비밀번호와 동일하게 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<button disabled="disabled" class="signup" type="submit">수정확인</button>
	</form>
</div>
<script>
	//아이디 입력란에 한번이라도 입력한 적이 있는지 여부
	var isOldPwdDirty=false;
	var oldPwdMatch=false;
	//비밀번호를 확인란과 같게 입력 했는지 여부 
	var isPwdEqual=false;
	//비밀번호를 입력했는지 여부 
	var oldPwdInput=false;
	var isNewPwdInput=false;
	var isNewPwd2Input=false;
	//비밀번호 형식에 맞게 입력했는지 여부
	var isPwdMatch=false;
	//비밀 번호 입력란에 한번이라도 입력한 적이 있는지 여부
	var isNewPwdDirty=false;
	var isNewPwd2Dirty=false;
	// pwd 체크 정규식 : 영어(대,소)와 특수문자를 포함한 8자리 이상 15자리 이하로 입력할것.
	var pwdCheck=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=.]).*$/
	
	$("#pwd").on("input", function(){
		isOldPwdDirty=true;
		//띄어쓰기 불가
		var pwd=$("#pwd").val();
		var a=pwd.replace(/ /gi, '');
		$("#pwd").val(a);
		//pwd 입력 여부 검증
		if(pwd.length == 0){
			oldPwdInput=false;
		}else{
			oldPwdInput=true;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/users/checkPwd.do",
			method:"POST",
			data:{inputPwd:pwd},
			dataType:"json",
			success:function(responseData){
				if(responseData.isValid){ //기존의 비밀번호와 일치한다면
					oldPwdMatch=true;
				}else{
					oldPwdMatch=false;
				}
				//아이디 에러 여부 
				var isError= !oldPwdMatch || !oldPwdInput ;
				//아이디 상태 바꾸기 
				setState("#pwd", isError );
			}
		});
	});
	
	//비밀번호를 입력할때 실행할 함수 등록
	$("#newPwd").on("input", function(){
		//상태값을 바꿔준다. 
		isNewPwdDirty=true;
		//띄어쓰기 불가
		var pwd=$("#newPwd").val();
		var a=pwd.replace(/ /gi, '');
		$("#newPwd").val(a);
		
		//pwd 입력 여부 검증
		if(pwd.length == 0){
			isNewPwdInput=false;
		}else{
			isNewPwdInput=true;
			
		}
		//비밀번호 형식에 맞게 입력 했는지 검증
		if(pwd.match(pwdCheck)){ //비밀번호 형식에 맞게 입력했다면
			isPwdMatch=true;
		}else{//형식에 맞지 않다면
			isPwdMatch=false;
		}
	
		var isError=!isPwdMatch || !isNewPwdInput;
		//비밀번호 상태 바꾸기 
		setState("#newPwd", isError);
	});
	
	$("#newPwd2").on("input", function(){
		
		isNewPwd2Dirty=true; //입력이 한번이라도 되었을 경우
	
		//입력한 비밀번호를 읽어온다.
		var pwd=$("#newPwd").val();
		var pwd2=$("#newPwd2").val();
		var b=pwd2.replace(/ /gi, '');
		
		$("#newPwd2").val(b);
	
		//pwd 입력 여부 검증
		if(pwd2.length == 0){
			isNewPwd2Input=false;
		}else{
			isNewPwd2Input=true;
			
			if(pwd != pwd2){//두 비밀번호를 동일하게 입력하지 않았다면
				isPwdEqual=false;
			}else{
				isPwdEqual=true;
			}
			
		}
		
	var isError=!isPwdEqual || !isNewPwd2Input ;
		setState("#newPwd2", isError);
		
		console.log("isError : "+isError);
		console.log("isPwdEqual : "+isPwdEqual);
		console.log("isNewPwd2Input : "+isNewPwd2Input);
	});
	
	
	//입력란의 상태를 바꾸는 함수 
	function setState(sel, isError){
		//일단 UI 를 초기 상태로 바꿔준다.
		$(sel)
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")
		.hide();
		
		//입력란의 색상과 아이콘을 바꿔주는 작업 
		if(isError){
			//입력란이 error 인 상태
			$(sel)
			.parent()
			.addClass("has-error")
			.find(".glyphicon-remove")
			.show();
		}else{
			//입력란이 success 인 상태
			$(sel)
			.parent()
			.addClass("has-success")
			.find(".glyphicon-ok")
			.show();
		}
		
		if(!oldPwdMatch && oldPwdInput){ //pwd를 입력했는데 기존의 비밀번호와 맞지 않는 경우
			$("#oldPwd_notmatch").show();
		}
		if(!oldPwdInput && isOldPwdDirty){//pwd를 입력하지 않은 경우
			$("#oldPwd_required").show();
		}
		if(!isPwdMatch && isNewPwdDirty && isNewPwdInput){ //pwd를 입력 했는데 조건에 맞지 않는 경우
			$("#pwd_notmatch").show();
		}
		if(!isNewPwdInput && isNewPwdDirty){ // pwd를 입력하지 않은 경우
			$("#pwd_required").show();
		}
		if(!isNewPwd2Input && isNewPwd2Dirty){ //pwd2 입력하지 않은 경우
			$("#pwd2_required").show();
		}
		if(!isPwdEqual && isNewPwdInput && isNewPwd2Input){ //pwd 같지 않은 경우
			$("#pwd2_notequal").show();
		}
		
		//버튼의 상태 바꾸기 
		if( oldPwdInput && oldPwdMatch && isPwdEqual && isNewPwdInput && isPwdMatch 
				&& isNewPwd2Input){
			$("button[type=submit]").removeAttr("disabled");
		}else{
			$("button[type=submit]").attr("disabled","disabled");
		}
	}
	
</script>
</body>
</html>










