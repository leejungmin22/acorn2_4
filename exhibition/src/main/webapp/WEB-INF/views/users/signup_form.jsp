<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	/* 페이지 로딩 시점에 도움말과 피드백 아이콘은 일단 숨기기 */
	.help-block, .form-control-feedback{
		display: none;
	}
</style>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
<!-- jQuery UI Datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$( "#birth" ).datepicker({
			dateFormat: 'yymmdd', //input에 입력되는 날짜 형식.
			prevText: '이전달', //prev 아이콘의 툴팁.
			nextText: '다음달', //next 아이콘의 툴팁.
			changeMonth: true, //월을 바꿀 수 있는 셀렉트 박스를 표시한다.
			changeYear: true, //년을 바꿀 수 있는 셀렉트 박스를 표시한다.
			showMonthAfterYear: true, //월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다.
			yearRange: 'c-100:c' // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할 것인다.
		});
	});
</script>
<style type="text/css">
	.ui-datepicker{font-size: 12px; width: 200px;}
	.ui-datepicker select.ui-datepicker-month{width: 50%; font-size: 11px;}
	.ui-datepicker select.ui-datepicker-year{width: 50%; font-size: 11px;}
	.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a {color:#f00;}
	.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a {color:#00f;}
</style>
</head>
<body>
<div class="container">
	<h1>회원 가입 페이지</h1>
	<form action="signup.do" method="post" id="signupForm">
		<div class="form-group has-feedback">
			<label class="control-label" for="name">이름</label>
			<input class="form-control" type="text" id="name" name="name"/>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="id">아이디</label>
			<input class="form-control" type="text" id="id" name="id"/>
			<p class="help-block" id="id_notusable">사용 불가능한 아이디 입니다.</p>
			<p class="help-block" id="id_required">반드시 입력 하세요</p>
			<p class="help-block" id="id_notmatch">아이디는 숫자,영문 15자 내로 입력 할 수 있습니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd">비밀번호</label>
			<input class="form-control" type="password" id="pwd" name="pwd"/>
			<p class="help-block" id="pwd_required">반드시 입력하세요</p>
			<p class="help-block" id="pwd_notmatch">비밀번호는 영어, 특수문자를 포함하여 8~15자리로 입력해야합니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" id="pwd2" name="pwd2"/>
			<p class="help-block" id="pwd_required2">반드시 입력하세요</p>
			<p class="help-block" id="pwd_notequal">비밀번호 입력란과 동일하게 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="email">이메일</label>
			<input class="form-control" type="email" id="email" name="email" />
			<p class="help-block" id="email_notmatch">이메일 형식에 맞게 입력하세요</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="birth">생년월일</label>
			<input class="form-control" type="text" id="birth" name="birth" autocomplete="off"/>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="gender">성별</label>
			<select class="form-control" name="gender" id="gender">
				<option value="f">여</option>
				<option value="m">남</option>
			</select>
		</div>
		<button disabled="disabled" class="btn btn-primary" type="submit">가입</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
</div>
<script>
	//아이디를 사용할수 있는지 여부 
	var isIdUsable=false;
	//아이디를 입력 했는지 여부 
	var isIdInput=false;
	//아이디 형식에 맞게 입력했는지 여부
	var isIdMatch=false;
	
	//비밀번호를 확인란과 같게 입력 했는지 여부 
	var isPwdEqual=false;
	//비밀번호를 입력했는지 여부 
	var isPwdInput=false;
	//비밀번호 형식에 맞게 입력했는지 여부
	var isPwdMatch=false;
	
	var isPwd2Input=false;
	var isPwd2Dirty=false;
	
	//이메일을 형식에 맞게 입력했는지 여부 
	var isEmailMatch=false;
	//이메일을 입력했는지 여부
	var isEmailInput=false;
	
	//아이디 입력란에 한번이라도 입력한 적이 있는지 여부
	var isIdDirty=false;
	//비밀 번호 입력란에 한번이라도 입력한 적이 있는지 여부
	var isPwdDirty=false;
	
	// id 체크 정규식 : 숫자, 영문(대문자, 소문자)만 1개이상 15개이하 입력 가능
	var idCheck = /^[0-9a-zA-Z]{1,15}$/gi
	// email 체크 정규식 
	var emailCheck = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$/;
	// pwd 체크 정규식 : 영어(대,소)와 특수문자를 포함한 8자리 이상 15자리 이하로 입력할것.
	var pwdCheck=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=.]).*$/g
	
	//이메일을 입력할때 실행할 함수 등록
	$("#email").on("input", function(){
		var email=$("#email").val();		
		if(email.match(emailCheck)){//이메일 형식에 맞게 입력 했다면
			isEmailMatch=true;
		}else{//형식에 맞지 않게 입력했다면 
			isEmailMatch=false;
		}
		
		if(email.length == 0){ //이메일을 입력하지 않았다면
			isEmailInput=false;
		}else{//이메일을 입력 했다면 
			isEmailInput=true;
		}
		//이메일 에러 여부 
		var isError=isEmailInput && !isEmailMatch;
		//이메일 상태 바꾸기 
		setState("#email", isError);
	});
	
	//비밀번호를 입력할때 실행할 함수 등록
	$("#pwd").on("input", function(){
		//상태값을 바꿔준다. 
		isPwdDirty=true;
		
		//입력한 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();

		//띄어쓰기 불가
		var a=pwd.replace(/ /gi, '');
		$("#pwd").val(a);
		
		//pwd 입력 여부 검증
		if(pwd.length == 0){
			isPwdInput=false;
		}else{
			isPwdInput=true;
		}
		
		//비밀번호 형식에 맞게 입력 했는지 검증
		if(pwd.match(pwdCheck)){ //비밀번호 형식에 맞게 입력했다면
			isPwdMatch=true;
		}else{//형식에 맞지 않다면
			isPwdMatch=false;
		}
		
		//아이디 에러 여부
		var isErrorReult= !isPwdInput || !isPwdMatch ;
		
		//아이디 상태 바꾸기 
		setState("#pwd", isErrorReult );
		
	});
	
	//비밀번호를 입력할때 실행할 함수 등록
	$("#pwd2").on("input", function(){
		//상태값을 바꿔준다. 
		isPwd2Dirty=true;
		
		//입력한 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();

		//띄어쓰기 불가
		var b=pwd2.replace(/ /gi, '');
		$("#pwd2").val(b);
		
		//pwd 입력 여부 검증
		if(pwd2.length == 0){
			isPwd2Input=false;
		}else{
			isPwd2Input=true;
		}
		console.log("isPwd2Input:"+isPwd2Input);
		//pwd과 pwd2 일치 여부 검증
		isPwdEqual = pwd != pwd2 ? false : true;
		console.log("isPwdEqual:"+isPwdEqual);
		//아이디 에러 여부 
		var isErrorReult= !isPwd2Input || !isPwdEqual ;
		
		//아이디 상태 바꾸기 
		setState("#pwd2", isErrorReult );
		console.log("pwd2isErrorReult:"+isErrorReult);
		
		
	});
	
	//아이디를 입력할때 실행할 함수 등록 
	$("#id").on("input", function(){
		isIdDirty=true;
		var isError=false;
		//1. 입력한 아이디를 읽어온다.
		var inputId=$("#id").val();
		//띄어쓰기 불가
		var a=inputId.replace(/ /gi, '');
		$("#id").val(a);
		
		//id 입력여부 검증
		if(inputId.length == 0){
			isIdInput=false;
		}else{
			isIdInput=true;
		}
		
		//아이디 형식에 맞게 입력 했는지 검증
		if(inputId.match(idCheck)){//아이디 형식에 맞게 입력 했다면
			isIdMatch=true;
		}else{//형식에 맞지 않게 입력했다면 
			isIdMatch=false;
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath }/users/checkid.do",
			method:"GET",
			data:{inputId:inputId},
			success:function(responseData){
				if(responseData.isExist){//이미 존재하는 아이디라면 
					isIdUsable=false;
				}else{
					isIdUsable=true;
				}
				
				//아이디 에러 여부 
				var isError1= !isIdUsable || !isIdInput ;
				var isError2= !isIdUsable || !isIdMatch ;
				
				var isErrorReult= isError1 || isError2 ;
				
				//아이디 상태 바꾸기 
				setState("#id", isErrorReult );
			}
		});

		//아이디 에러 여부 
		var isError1= !isIdUsable || !isIdInput ;
		var isError2= !isIdUsable || !isIdMatch ;
		
		var isErrorReult= isError1 || isError2 ;
		
		//아이디 상태 바꾸기 
		setState("#id", isErrorReult );
		
	});
	
	//입력란의 상태를 바꾸는 함수 
	function setState(sel, isErrorReult){
		//일단 UI 를 초기 상태로 바꿔준다.
		$(sel)
		.parent()
		.removeClass("has-success has-error")
		.find(".help-block, .form-control-feedback")
		.hide();
		
		//입력란의 색상과 아이콘을 바꿔주는 작업 
		if(isErrorReult){
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
		//에러가 있다면 에러 메세지 띄우기
		if(isEmailInput && !isEmailMatch){
			$("#email_notmatch").show();
		}
		
 		//pwd 에러가 있다면 에러 메세지 띄우기
		/* 
			[pwd 입력란 에러 메세지 조건]
 			1. pwd를 입력 했는데 조건에 맞지 않은 경우
 			2. pwd를 입력하지 않은 경우 
		*/
		if(!isPwdMatch && isPwdDirty && isPwdInput){ //pwd를 입력 했는데 조건에 맞지 않는 경우
			$("#pwd_notmatch").show();
		}
		if(!isPwdInput && isPwdDirty){ // pwd를 입력하지 않은 경우
			$("#pwd_required").show();
		}
		
		/* 
			[pwd 확인 입력란 에러 메세지 조건]
			1. pwd 확인란 입력하지 않고, pwd와 pwd2가 동일하게 입력되지 않은 경우
		*/
		if(isPwd2Input && !isPwdEqual){ //pwd와 pwd2가 동일하게 입력되지 않은 경우
			$("#pwd_notequal").show();
		}
		if(!isPwd2Input && isPwd2Dirty){ // pwd2를 입력하지 않은 경우
			$("#pwd_required2").show();
		}
		
		//id 에러가 있다면 에러 메세지 띄우기
		if(!isIdMatch && isIdDirty && isIdInput){ //id를 입력했는데 조건에 맞지 않는 경우
			$("#id_notmatch").show();
		}
		if(!isIdUsable && isIdDirty && isIdInput){ //id를 입력했는데 DB에 이미 등록된 ID인 경우
			$("#id_notusable").show();
		}
		if(!isIdInput && isIdDirty){ //id를 입력하지 않은 경우
			$("#id_required").show();
		}

		//버튼의 상태 바꾸기 
		if(isIdUsable && isIdInput && isPwdEqual && 
				isPwdInput && isPwdMatch && isPwd2Input && (!isEmailInput || isEmailMatch) ){
			$("button[type=submit]").removeAttr("disabled");
		}else{
			$("button[type=submit]").attr("disabled","disabled");
		}
	}
	
</script>
</body>
</html>