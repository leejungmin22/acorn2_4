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
	.danger, .form-control-feedback{
		display: none;
	}
	.danger{
		color:#FF0000;
	}
	
	/*화면 가운데정렬*/
	.condition{
		width: 400px; 
		position: absolute; 
		left: 50%; 
		margin-left: -250px;		
	}
	
	#bread{
		background-color: #FAEBD7;		
	}
	
	#signupForm{
		margin-top:40px;
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
	.form-control-feedback{
		position:relative;
		left:550px;	
	}
	
	/*가입버튼 #DEB887 #CD853F*/
	.signup {
    	width:500px;
    	height:70px;
    	font-size:30px;
    	font-weight:bolder;
    	background-color: #D2691E;
    	margin-top: 0.8rem;
    	cursor:pointer;
    	letter-spacing: 0.4rem;
    	color:#fff;
    	border-radius: .5rem;  
		position: absolute; 
		left: 12%;
		  	
   	}
	
	/*성별*/
	.textbox2 { 
		border-radius: .5rem .5rem .5rem .5rem;
		margin-top: 10px;
		position:relative;
		text-align: center;
		width:100px;		
		left: 0;
		border: 2px solid #F5F5F5;
		font-size: 15px;
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
<jsp:include page="../include/navbar.jsp"/>
<div class="container">
	<ol class="breadcrumb" id="bread">
		<li><a href="${pageContext.request.contextPath }/community/comList.do">목록</a></li>
		<li>회원가입</li>
	</ol>
	<div class="condition">
		<form action="signup.do" method="post" id="signupForm">	
			<div class="form-group has-feedback">
				<label class="font" for="name">이름</label><br/>
				<input class="textbox" type="text" id="name" name="name"/>
			</div>
			<div class="form-group has-feedback">
			<label class="control-label" for="profileLink">프로필 이미지</label>
			<input type="file" id="profileImage" name="profileImage" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .PNG">		
		</div>
			<div class="form-group has-feedback">
				<label class="font" for="id">아이디</label><br/>
				<input class="textbox" type="text" id="id" name="id"/>
					<span class="glyphicon glyphicon-remove form-control-feedback"></span>
					<span class="glyphicon glyphicon-ok form-control-feedback"></span>
				<p class="danger" id="id_notusable">사용 불가능한 아이디 입니다.</p>				
				<p class="danger" id="id_required">필수 정보입니다.</p>								
			</div>
			<div class="form-group has-feedback">
				<label class="font" for="pwd">비밀번호</label><br/>
				<input class="textbox" type="password" id="pwd" name="pwd"/>
				<p class="danger" id="pwd_required">필수 정보입니다.</p>
				<p class="danger" id="pwd_notmatch">비밀번호는 영어, 특수문자를 포함하여 8~15자리로 입력해야합니다.</p>
				<span class="glyphicon glyphicon-remove form-control-feedback"></span>
				<span class="glyphicon glyphicon-ok form-control-feedback"></span>
			</div>
			<div class="form-group">
				<label class="font" for="pwd2">비밀번호 확인</label><br/>
				<input class="textbox" type="password" id="pwd2" name="pwd2"/>
				<p class="danger" id="pwd_required">필수 정보입니다.</p>
				<p class="danger" id="pwd_notequal">비밀번호가 일치하지 않습니다.</p>
								
			</div>
			<div class="form-group has-feedback">
				<label class="font" for="email">이메일</label><br/>
				<input class="textbox" type="email" id="email" name="email"/>
					<span class="glyphicon glyphicon-remove form-control-feedback"></span>
					<span class="glyphicon glyphicon-ok form-control-feedback"></span>
				<p class="danger" id="email_notmatch">이메일 형식에 맞게 입력하세요</p>								
			</div>
			<div class="form-group has-feedback">
				<label class="font" for="birth">생년월일</label><br/>
				<input class="textbox" type="text" id="birth" name="birth"/>
			</div>
			<div class="form-group has-feedback">
				<label class="font" for="gender">성별</label><br/>
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
	$("#pwd, #pwd2").on("input", function(){
		//상태값을 바꿔준다. 
		isPwdDirty=true;
		
		//입력한 비밀번호를 읽어온다.
		var pwd=$("#pwd").val();
		var pwd2=$("#pwd2").val();
		//띄어쓰기 불가
		var a=pwd.replace(/ /gi, '');
		var b=pwd2.replace(/ /gi, '');
		$("#pwd").val(a);
		$("#pwd2").val(b);
	
		//pwd 입력 여부 검증
		if(pwd.length == 0){
			isPwdInput=false;
			var isError=true;
			//비밀번호 상태 바꾸기 
			setState("#pwd", isError);
		}else{
			isPwdInput=true;
			//비밀번호 형식에 맞게 입력 했는지 검증
			if(pwd.match(pwdCheck)){ //비밀번호 형식에 맞게 입력했다면
				isPwdMatch=true;
			}else{//형식에 맞지 않다면
				isPwdMatch=false;
			}
			
			if(pwd != pwd2){//두 비밀번호를 동일하게 입력하지 않았다면
				isPwdEqual=false;
				
			}else{
				isPwdEqual=true;
			}
			var isError=!isPwdEqual || !isPwdMatch;
			//비밀번호 상태 바꾸기 
			setState("#pwd", isError);
			setState("#pwd2", isError);
		}
	
	});
	$("#pwd, #pwd2").on("input", function(){
		isPwd2Dirty=true;
		setState("#pwd2", isError);
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
			isError=true;
			setState("#id", isError );
		}else{
			isIdInput=true;
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
					var isError= !isIdUsable || !isIdMatch ;
					//아이디 상태 바꾸기 
					setState("#id", isError );
				}
			});
		
		//아이디 형식에 맞게 입력 했는지 검증
		if(inputId.match(idCheck)){//아이디 형식에 맞게 입력 했다면
			isIdMatch=true;
		}else{//형식에 맞지 않게 입력했다면 
			isIdMatch=false;
		}
		
		//아이디 에러 여부 
		var isError= !isIdUsable || !isIdMatch ;
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
		.find(".danger, .form-control-feedback")
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
		if(!isPwdEqual && isPwd2Dirty && isPwdInput){ //pwd 같지 않은 경우
			$("#pwd_notequal").show();
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