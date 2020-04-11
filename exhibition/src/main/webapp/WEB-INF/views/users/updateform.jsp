<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
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
	.help-block, .form-control-feedback{
	   display: none;
	
	}
</style>
</head>
<body>
<div class="container">
<jsp:include page="../include/navbar.jsp" />
	<h1>회원정보 수정폼</h1>
	<form action="update.do" method="post">
		<input type="hidden" name="id" value="${id }"/>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" id="id" value="${id }" disabled/>
		</div>
		<input type="hidden" name="name" value="${dto.name }"/>
		<div class="form-group">
			<label for="name">이름</label>
			<input class="form-control" type="text" id="name" value="${dto.name }" disabled/>
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="text" id="email" name="email" value="${dto.email }"/>
			<p class="help-block" id="email_notmatch">이메일 형식에 맞게 입력하세요</p>
            <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            <span class="glyphicon glyphicon-ok form-control-feedback"></span>
		</div>
		<div class="form-group">
			<label for="birth">생년월일</label>
			<input class="form-control date" type="text" id="birth" name="birth" value="${dto.birth }" readonly="readonly"/>
		</div>
		<div class="form-group">
			<label for="gender">성별</label>
			<select class="form-control" name="gender" id="gender">
				<option value="f" <c:if test="${dto.gender eq 'f' }">selected</c:if>>여</option>
				<option value="m" <c:if test="${dto.gender eq 'm' }">selected</c:if>>남</option>
			</select>
		</div>
		
	
		<button class="btn btn-primary" type="submit">수정확인</button>
		<button class="btn btn-warning" type="reset">취소</button>
	</form>
		
</div>
<script type="text/javascript">
var isEmailMatch=false;
var isEmailInput=false;

var emailCheck = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$/;

//이메일을 입력할때 실행할 함수 등록
$("#email").on("input", function(){
   var email=$("#email").val();    
   var removeSpace=email.replace(/ /gi, '');
   $("#email").val(removeSpace);
   
   if(email.length == 0){ //이메일을 입력하지 않았다면
      isEmailInput=false;
   }else{//이메일을 입력 했다면 
      isEmailInput=true;
   }
   
   if(email.match(emailCheck)){//이메일 형식에 맞게 입력 했다면
      isEmailMatch=true;
   }else{//형식에 맞지 않게 입력했다면 
      isEmailMatch=false;
   }
   
   //이메일 에러 여부 
   var isErrorReult=isEmailInput && !isEmailMatch;
   //이메일 상태 바꾸기 
   setState("#email", isErrorReult);
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
   
	if(isEmailInput && !isEmailMatch){
		$("#email_notmatch").show();
	}
		
   //버튼의 상태 바꾸기 
   if(!isEmailInput || isEmailMatch){
      $("button[type=submit]").removeAttr("disabled");
   }else{
      $("button[type=submit]").attr("disabled","disabled");
   }
}
</script>
</body>
</html>










