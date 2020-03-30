<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	p, .form-group{
		font-size:20px;
		font-family: 'Nanum Pen Script', cursive;
	}

	button{
		vertical-align:middle;
	}
	button.img-button{
		background:url("../resources/images/button_search.png") no-repeat;
		border:none;
		width:38px;
		height:38px;
		cursor:pointer;
	}
	
	#bread{
		background-color: #FAEBD7;
	}
	
</style>
<!-- jQuery UI Datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
        //시작일.
        $('#startDate').datepicker({
            prevText: '이전달', //prev 아이콘의 툴팁.
			nextText: '다음달', //next 아이콘의 툴팁.
            buttonText: "날짜선택",             // 버튼의 대체 텍스트
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            changeYear: true,
            showMonthAfterYear: true,
            //minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
            onClose: function( selectedDate ) {    
                // 시작일(fromDate) datepicker가 닫힐때
                // 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                $("#endDate").datepicker( "option", "minDate", selectedDate );
            }                
        });

        //종료일
        $('#endDate').datepicker({
        	prevText: '이전달', //prev 아이콘의 툴팁.
			nextText: '다음달', //next 아이콘의 툴팁.
            buttonText: "날짜선택",             // 버튼의 대체 텍스트
            dateFormat: "yy-mm-dd",             // 날짜의 형식
            changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
            changeYear: true,
            showMonthAfterYear: true,
            //minDate: 0, // 오늘 이전 날짜 선택 불가
            onClose: function( selectedDate ) {
                // 종료일(toDate) datepicker가 닫힐때
                // 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
                $("#startDate").datepicker( "option", "maxDate", selectedDate );
            }                
        });

	});
</script>
<style type="text/css">
	.ui-datepicker{font-size: 12px; width: 200px;}
	.ui-datepicker select.ui-datepicker-month{width: 100%; font-size: 11px;}
	.ui-datepicker select.ui-datepicker-year{width: 100%; font-size: 11px;}
	.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a {color:#f00;}
	.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a {color:#00f;}
	.form-group{
		max-width:200px;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="category"/>
</jsp:include>
<div class="container">
	<ol class="breadcrumb" id="bread">
		<li><a href="${pageContext.request.contextPath }/community/comList.do">목록</a></li>
		<li>자유게시판</li>
	</ol>
	
	<%-- 글 검색 기능 폼 --%>	
	<div class="condition" align="right">
		<form class="form-inline" action="comList.do" method="get"> 
			<div class="form-group">
				<label for="condition">검색조건</label>
				<select class="form-control" name="condition" id="condition">
					<option value="none">선택하세요</option>
					<option value="title" <c:if test="${condition eq 'title' }">selected</c:if>>제목</option>
					<option value="place" <c:if test="${condition eq 'place' }">selected</c:if>>장소</option>
					<option value="date" <c:if test="${condition eq 'date' }">selected</c:if>>기간</option>
				</select>
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="keyword" id="keyword" value="${keyword }" placeholder="검색어를 입력하세요"/>
				<input class="form-control date" type="text" name="startDate" class="date" id="startDate" value="${startdate }" autocomplete="off" readonly/>
				<span class="date">~</span>
			</div>
			<div class="form-group">				
				<input class="form-control date" type="text" name="endDate" class="date" id="endDate" value="${enddate }" autocomplete="off" readonly/>
				<button class="img-button" type="submit"></button>
			</div>
		</form>
	</div>
	<c:if test="${not empty keyword }">
		<p>
			<strong>${keyword }</strong> 라는 검색어로 
			<strong>${totalRow }</strong> 개의 글이 검색 
			되었습니다.
		</p>
	</c:if>
	
	<table class="table table-hover">
		<colgroup>
			<col class="col-xs-1"/>
			<col class="col-xs-2"/>
			<col class="col-xs-5"/>
			<col class="col-xs-1"/>
			<col class="col-xs-3"/>
		</colgroup>
		<thead>
			<tr>
				<th>글번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="tmp" items="${requestScope.list }">
			<tr>
				<td>${tmp.num }</td>
				<td>${tmp.writer }</td>
				<td>
					<a href="comDetail.do?num=${tmp.num }&condition=${condition }&keyword=${encodedKeyword }">
						${tmp.title }
					</a>
				</td>
				<td>${tmp.viewCount }</td>
				<td>${tmp.regdate }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<a href="insertform.do">새글 작성</a>
	
	<div class="page-display"  style="text-align: center;">
		<ul class="pagination pagination-sm">
		<c:choose>
			<c:when test="${startPageNum ne 1 }">
				<li>
					<a href="comList.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedKeyword }">
						&laquo;
					</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="disabled">
					<a href="javascript:">&laquo;</a>
				</li>
			</c:otherwise>
		</c:choose>
		<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }" step="1">
			<c:choose>
				<c:when test="${i eq pageNum }">
					<li class="active">
					<a href="comList.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="comList.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:choose>
			<c:when test="${endPageNum lt totalPageCount }">
				<li>
					<a href="comList.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedKeyword }">
						&raquo;
					</a>
				</li>
			</c:when>
			<c:otherwise>
				<li class="disabled">
					<a href="javascript:">&raquo;</a>
				</li>
			</c:otherwise>
		</c:choose>
		</ul>		
	</div>	
</div>
<script>
	//select 된 정보를 담을 변수
	var value=$("#condition").val();
	//페이지가 로딩되는 시점에 어떤 값이 선택되었는지 확인 후 그에 맞는 input tag를 보여준다.
	checkeSelectBox(value);
	//select 옵션이 변경된 경우 그에 맞는 input tag를 보여준다.
	$("#condition").change(function(){
		value=$(this).val();
		checkeSelectBox(value);
	});
	//어떤 옵션이 선택되었는지 확인할 함수
	function checkeSelectBox(value){
		if(value=="none"){
			$("#keyword").attr("disabled", "disabled").hide();
			$(".date").attr("disabled", "disabled").hide();
			//$("button[type=submit]").attr("disabled","disabled");
		}
		if(value=="date"){
			$("#keyword").attr("disabled", "disabled").hide();
			$(".date").removeAttr("disabled").show();
			//$("button[type=submit]").removeAttr("disabled");
			console.log("기간 선택");
		}
		if(value=="title"){
			$("#keyword").removeAttr("disabled").show();
			$(".date").attr("disabled", "disabled").hide();
			//$("button[type=submit]").removeAttr("disabled");
			console.log("제목 선택");
		}
		
		if(value=="place"){
			$("#keyword").removeAttr("disabled").show();
			$(".date").attr("disabled", "disabled").hide();
			//$("button[type=submit]").removeAttr("disabled");
			console.log("장소 선택");
		}
		
	}	
	
	//페이지 로딩시 키워드, 시작, 끝 날짜에 입력되어 있는값 갖고오기 
	var keyword=$("#keyword").val();
	var startDate=$("#startDate").val();
	var endDate=$("#endDate").val();
	
	//페이지 로딩시 
	if(!isEmpty(keyword) || (!isEmpty(startDate) && !isEmpty(endDate))){//키워드가 입력되어 있다면 disabled 속성 없애기
		$("button[type=submit]").removeAttr("disabled");
	}else{ //키워드가 입력되지 않은 경우 disabled 속성 추가하기
		$("button[type=submit]").attr("disabled","disabled");
	}
	
	//input#keyword 요소가 변경될때마다 확인해서 disabled 속성 추가하기
 	$("#keyword").on("input", function(){
		keyword=$("#keyword").val();
		if(!isEmpty(keyword)){//키워드가 입력된 경우
			$("button[type=submit]").removeAttr("disabled");
		}else{ //키워드가 입력되지 않은 경우
			$("button[type=submit]").attr("disabled","disabled");
		}

	});
	//input#startDate, #endDate 요소가 변경될때마다 확인해서 disabled 속성 추가하기
	$("#startDate, #endDate").change(function(){
		startDate=$("#startDate").val();
		endDate=$("#endDate").val();
		if(!isEmpty(startDate) && !isEmpty(endDate)){//#startDate, #endDat가 입력된 경우
			$("button[type=submit]").removeAttr("disabled");
		}else{ //#startDate, #endDat가 입력되지 않은 경우
			$("button[type=submit]").attr("disabled","disabled");
		}

	});
	
	//input 요소가 비어있는지 확인할 함수
	function isEmpty(str){
		if(str==" " || str=="" || typeof str == "undefined" || str == null){
			return true;
		}
	}
</script>
</body>
</html>