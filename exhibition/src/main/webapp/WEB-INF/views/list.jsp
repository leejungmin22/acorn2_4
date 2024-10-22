<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체공연보기</title>
<jsp:include page="include/resource.jsp" />
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css);
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
	/*검색버튼*/
	button.img-button{
		background:url("resources/images/button_search.png") no-repeat;
		border:none;
		width:38px;
		height:38px;
		cursor:pointer;
	}
	/*thead 색상변경*/
    .condition{
   		margin: 10px 0 20px 0;
    }
    td, th{
    	text-align: center;
    }
    .heart{
		width: 20px;
		height: auto;
	}
	button.img-button{
		background:url("resources/images/button_search.png") no-repeat;
		border:none;
		width:38px;
		height:38px;
		cursor:pointer
	}
.ui-datepicker{font-size: 12px; width: 200px;}
.ui-datepicker select.ui-datepicker-month{width: 50%; font-size: 11px;}
.ui-datepicker select.ui-datepicker-year{width: 50%; font-size: 11px;}
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:first-child a {color:#f00;}
.ui-datepicker-calendar > tbody td.ui-datepicker-week-end:last-child a {color:#00f;}

.sub_option li{
	float:right;
}

ol, ul {
    list-style-type: none;
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
</head>
<body>
<jsp:include page="include/navbar.jsp">
	<jsp:param value="list" name="category"/>
</jsp:include>
<div class="container">
	<div class="sub-nav-left">
		<a href="home.do" onclick="javascript:page_link('000000'); return false;">
			<img src="resources/images/home.png" alt="홈" />
		</a>
		>
		<a href="list.do" onclick="javascript:page_link('010000'); return false;">목록</a>
		>
		<a href="list.do" onclick="javascript:page_link('010000'); return false;">날짜별 목록</a>
	</div>
	
	<div class="condition" align="right">
		<div>
			<c:if test="${not empty keyword }">
				<p>
					<strong>${keyword }</strong> 라는 검색어로 
					<strong>${totalRow }</strong> 개의 공연을 찾았습니다.
				</p>
			</c:if>
			<c:if test="${not empty startdate and not empty enddate }">
				<p>
					<strong>${startdate }~${enddate }</strong> 에는 
					<strong>${totalRow }</strong> 개의 공연이 있습니다.
				</p>
			</c:if>
		</div>
		<form class="form-inline" action="list.do" method="get"> 
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
				<input class="form-control" type="text" name="keyword" id="keyword" value="${keyword }" placeholder="검색어를 입력하세요" />
				<input class="form-control date" type="text" name="startDate" class="date" id="startDate" value="${startdate }" autocomplete="off" readonly/>
				<span class="date">~</span>
			</div>
			
			<div class="form-group">
				<input class="form-control date" type="text" name="endDate" class="date" id="endDate" value="${enddate }" autocomplete="off" readonly/>
				<button class="btn img-button" type="submit" disabled="disabled"></button>
			</div>
		</form>
		
		
		</div>
		<div class="option_tab _tabContainer" data-tab="sort">
		<ul class="sub_option">
			<li class="_tab" data-value role="tab" ><a class ="sort" href="javascript:" id="favorite" >인기순</a></li>
			<li  class="_tab" data-value role="default.asc" ><a class ="sort" type="javascript:" id="pastdate">날짜순</a></li>
		</ul>
		</div>
	<table class="table table-hover">

		<colgroup>
			<col class="col-xs-6"/>
			<col class="col-xs-1"/>
			<col class="col-xs-2"/>
			<col class="col-xs-3"/>
		</colgroup>
		<thead>
			<tr class="title">
				<th>공연명 </th>
				<th>좋아요</th>
				<th>장소</th>
				<th>공연기간</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tmp" items="${requestScope.list }">
				<tr class="tr">
					<td>
						<a href="detail.do?seq=${tmp.seq }">
							${tmp.title }
						</a>				
					</td>				
					<td>
						<img class="heart" src="${pageContext.request.contextPath }/resources/images/red-heart.png" alt="" />
						${tmp.likeCount }
					</td>				
					<td>${tmp.place }</td>
					<td>${tmp.startdate } ~ ${tmp.enddate }</td>
				</tr>	
			</c:forEach>
		</tbody>	
	</table>
	
	<div class="page-display" style="text-align: center;">
		<ul class="pagination pagination-sm">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li>
						<c:choose>
							<c:when test="${encodedKeyword ne null }">
								<a href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&keyword=${encodedKeyword }">&laquo;</a>
							</c:when>
							<c:when test="${startdate ne null and enddate ne null   }">
								<a href="list.do?pageNum=${startPageNum-1 }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">&laquo;</a>
							</c:when>
							<c:otherwise>
								<a href="list.do?pageNum=${startPageNum-1 }">&laquo;</a>
							</c:otherwise>
						</c:choose>
					</li>
				</c:when>
				<c:otherwise>
					<li class="disabled">
						<a href="javascript:">&laquo;</a>
					</li>
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${requestScope.startPageNum }" end="${requestScope.endPageNum }" step="1">
				<c:choose>
					<c:when test="${i eq pageNum }">
						<li class="active">
							<c:choose>
								<c:when test="${encodedKeyword ne null  }">
									<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a>
								</c:when>
								<c:when test="${startdate ne null and enddate ne null  }">
									<a href="list.do?pageNum=${i }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">${i }</a>

								</c:when>
								<c:otherwise>
									<a href="list.do?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<c:choose>
								<c:when test="${encodedKeyword ne null }">
									<a href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedKeyword }">${i }</a>
								</c:when>
								<c:when test="${startdate ne null and enddate ne null}">
									<a href="list.do?pageNum=${i }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">${i }</a>

								</c:when>
								<c:otherwise>
									<a href="list.do?pageNum=${i }">${i }</a>
								</c:otherwise>
							</c:choose>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:choose>
				<c:when test="${endPageNum < totalPageCount }">
					<li>
						<c:choose>
							<c:when test="${encodedKeyword ne null }">
								<a href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&keyword=${encodedKeyword }">&raquo;</a>
							</c:when>
							<c:when test="${startdate ne null and enddate ne null }">
								<a href="list.do?pageNum=${endPageNum+1 }&condition=${condition }&startDate=${startdateFormat }&endDate=${enddateFormat }">&raquo;</a>
							</c:when>
							<c:otherwise>
								<a href="list.do?pageNum=${endPageNum+1 }">&raquo;</a>
							</c:otherwise>
						</c:choose>
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
	var value=${sort}

	
	$("#favorite").click(function(){
		location.href="listfavor.do"
	});
	$("#pastdate").click(function(){
		location.href="list.do"
	});
	
	//select 옵션이 변경된 경우 그에 맞는 input tag를 보여준다.
	$("#condition").change(function(){
		value=$(this).val();
		checkeSelectBox(value);
	});
	
	//어떤 옵션이 선택되었는지 확인할 함수
	function checkeSelectBox(value){
		
			if(value=="none" ){
				$("#keyword").attr("disabled", "disabled").hide();
				$(".date").attr("disabled", "disabled").hide();
				//$("button[type=submit]").attr("disabled","disabled");
			}
			
			if(value=="date" ){
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