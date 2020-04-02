<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>조이름 : 회원가입</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<link href="http://fonts.googleapis.com/earlyaccess/hanna.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumpenscript.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	/* 페이지 로딩 시점에 도움말과 피드백 아이콘은 일단 숨기기 */
	.help-block, .form-control-feedback{
		display: none;
	
	}

	/*화면 가운데정렬*/
	.condition{
		width: 400px; 
		position: absolute; 
		margin-left: -250px;
		left: 50%;

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
	
	/*화면 가운데정렬*/
	.condition{
		width: 400px; 
		position: absolute; 
		margin-left: -150;
		left:38%;
	}	
	#signupForm{
		margin-top:10px;
	}

	
	/*입력필드*/
	.textbox{ 
		border-radius: .5rem .5rem .5rem .5rem;
		margin-top: 10px;
		position:relative;
		text-align: left;				
		left: 0;	
		color: #999; 
		cursor: text;
		width: 600px; /* 칸 너비 설정 */
		height:40px; /*칸 높이*/
		border: 2px solid #F5F5F5;		
	}
	
	
	/*가입버튼 #DEB887 #CD853F*/

	.signup {
    	width:300px;
    	height:60px;
    	font-size:30px;
    	font-weight:bolder;
    	background-color: #111111;
    	margin-top: 0.8rem;
    	cursor:pointer;
    	letter-spacing: 0.4rem;
    	color:#fff;
    	border-radius: .5rem;  
		position: absolute; 
		left: 10%;
		  	
   	}
	
	/*성별*/
	
	
	
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
<jsp:include page="../include/navbar.jsp"/>
<div class="container">
	<div class="sub-nav-left">
		<a href="home.do" onclick="javascript:page_link('000000'); return false;">
			<img src="../resources/images/home.png"" alt="홈" />
		</a>
		>
				<a href="${pageContext.request.contextPath }/users/loginform.do" onclick="javascript:page_link('010100'); return false;">로그인</a>
		>
		<a href="${pageContext.request.contextPath }/users/signup_form.do" onclick="javascript:page_link('010000'); return false;">회원가입</a>
	</div>
	
 	<div class="condition" > 
	<form action="signup.do" method="post" id="signupForm" enctype="multipart/form-data">
		<div class="form-group has-feedback"> 
			<label class="control-label" for="name">이름</label><br/>
			<input class="form-control" type="text" id="name" name="name"/>
			<p class="help-block" id="name_required">필수 정보입니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
			
		</div>
		<div class="form-group">
			<label class="control-label" for="profileLink">프로필 이미지</label>
			<input type="file" id="profileImage" name="profileImage" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG">		
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="id">아이디</label>
			<input class="form-control" type="text" id="id" name="id"/>
			<p class="help-block" id="id_notusable">사용 불가능한 아이디 입니다.</p>
			<p class="help-block" id="id_required">필수 정보입니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd">비밀번호</label>
			<input class="form-control" type="password" id="pwd" name="pwd"/>
			<p class="help-block" id="pwd_required">필수 정보입니다.</p>
			<p class="help-block" id="pwd_notmatch">비밀번호는 영어, 특수문자를 포함하여 8~15자리로 입력해야합니다.</p>
			<span class="glyphicon glyphicon-remove form-control-feedback"></span>
			<span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<label class="control-label" for="pwd2">비밀번호 확인</label>
			<input class="form-control" type="password" id="pwd2" name="pwd2"/>
			<p class="help-block" id="pwd2_required">필수 정보입니다.</p> 
			<p class="help-block" id="pwd2_notequal">비밀번호와 동일하게 입력하세요</p>
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
				<label class="control-label" for="birth">생년월일</label><br/>
				<input class="form-control" type="text" id="birth" name="birth"/>
			</div>
			<div class="form-group has-feedback">
				<label class="control-label" for="gender">성별</label><br/>
				<select class="textbox2" name="gender" id="gender">
					<option value="f">여</option>
					<option value="m">남</option>
				</select>
			</div>
			<button disabled="disabled" class="signup" type="submit">가 입 하 기</button>
		</form>
		</div>
</div>
	<%-- jquery form  플러그인 javascript 로딩 --%>
	<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
	<script>	
	
	var isNameInput=false; //이름을 입력했는지 여부
	
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
	

	//이메일을 형식에 맞게 입력했는지 여부 
	var isEmailMatch=false;
	//이메일을 입력했는지 여부
	var isEmailInput=false;
	
	var isNameDirty=false;
	//아이디 입력란에 한번이라도 입력한 적이 있는지 여부
	var isIdDirty=false;
	//비밀 번호 입력란에 한번이라도 입력한 적이 있는지 여부
	var isPwdDirty=false;
	//비밀 번호 확인란에 한번이라도 입력한 적이 있는지 여부
	var isPwd2Dirty=false;
	
	// id 체크 정규식 : 숫자, 영문(대문자, 소문자)만 1개이상 15개이하 입력 가능
	var idCheck = /^[0-9a-zA-Z]{1,15}$/gi
	// email 체크 정규식 
	var emailCheck = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$/;
	// pwd 체크 정규식 : 영어(대,소)와 특수문자를 포함한 8자리 이상 15자리 이하로 입력할것.
	var pwdCheck=/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=.]).*$/g
	
	
	//이름을 입력할때 실행할 함수 등록
	$("#name").on("input", function(){
		isNameDirty=true;
		var inputName=$("#name").val();
		//띄어쓰기 불가
		var a=inputName.replace(/ /gi, '');
		$("#name").val(a);
		if(inputName.length == 0){ //이메일을 입력하지 않았다면
			isNameInput=false;
		}else{//이메일을 입력 했다면 
			isNameInput=true;
		}
		//이메일 에러 여부 
		var isError=isNameDirty && !isNameInput;
		//이메일 상태 바꾸기 
		setState("#name", isError);
	});
	
	
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
		//띄어쓰기 불가
		var pwd=$("#pwd").val();
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

		var isError=!isPwdMatch || !isPwdInput;
		//비밀번호 상태 바꾸기 
		setState("#pwd", isError);
	});
	
	$("#pwd2").on("input", function(){
		
		isPwd2Dirty=true; //입력이 한번이라도 되었을 경우

		//입력한 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
		var b=pwd2.replace(/ /gi, '');
		
		$("#pwd2").val(b);

		//pwd 입력 여부 검증
		if(pwd2.length == 0){
			isPwd2Input=false;
// 			var isError=true;
// 			setState("#pwd2", isError);
		}else{
			isPwd2Input=true;
			
			if(pwd != pwd2){//두 비밀번호를 동일하게 입력하지 않았다면
				isPwdEqual=false;
			}else{
				isPwdEqual=true;
			}
			
			var isError=!isPwdEqual && isPwd2Input ;
			setState("#pwd2", isError);
		}
		
	});
	
	//아이디를 입력할때 실행할 함수 등록 
	$("#id").on("input", function(){
		isIdDirty=true;
		//1. 입력한 아이디를 읽어온다.
		var inputId=$("#id").val();
		//띄어쓰기 불가
		var a=inputId.replace(/ /gi, '');
		$("#id").val(a);
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

				var isError= !isIdUsable || !isIdInput ;
				//아이디 상태 바꾸기 
				setState("#id", isError );
			}
		});
		//id 입력여부 검증
		if(inputId.length == 0){
			isIdInput=false;
		}else{
			isIdInput=true;
			//아이디 형식에 맞게 입력 했는지 검증
			if(inputId.match(idCheck)){//아이디 형식에 맞게 입력 했다면
				isIdMatch=true;
			}else{//형식에 맞지 않게 입력했다면 
				isIdMatch=false;
		}
		
		//아이디 에러 여부 
		var isError= !isIdUsable || !isIdInput;
		//아이디 상태 바꾸기 
		setState("#id", isError );
		
		}
		
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
		
		if(isNameDirty && !isNameInput){
			$("#name_required").show();
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
 			3. pwd2를 입력하지 않은 경우
 			4. pwd2를 입력했는데 같지 않은 경우
		*/
		if(!isPwdMatch && isPwdDirty && isPwdInput){ //pwd를 입력 했는데 조건에 맞지 않는 경우
			$("#pwd_notmatch").show();
		}
		if(!isPwdInput && isPwdDirty){ // pwd를 입력하지 않은 경우
			$("#pwd_required").show();
		}
		if(!isPwd2Input && isPwd2Dirty){ //pwd2 입력하지 않은 경우
			$("#pwd2_required").show();
		}
		if(!isPwdEqual && isPwdInput && isPwd2Input){ //pwd 같지 않은 경우
			$("#pwd2_notequal").show();
		}
	
		//id 에러가 있다면 에러 메세지 띄우기
		if(!isIdMatch && isIdDirty && isIdInput){ //id를 입력했는데 조건에 맞지 않는 경우
			$("#id_notmatch").show();
		}
		if(!isIdUsable && isIdDirty ){ //id를 입력했는데 DB에 이미 등록된 ID인 경우
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