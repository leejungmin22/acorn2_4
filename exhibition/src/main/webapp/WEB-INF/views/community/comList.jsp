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
		background-color: #bdbdbd;
		color: #FFFFFF;
	}
	
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="category"/>
</jsp:include>
<div class="container">
	<ol class="breadcrumb" id="bread">
		<li>자유게시판</li>
		<li><a href="${pageContext.request.contextPath }/community/comList.do">목록</a></li>	
	</ol>
	
	<%-- 글 검색 기능 폼 --%>	
	<div class="condition" align="right">
		<form class="form-inline" action="comList.do" method="get"> 
			<div class="form-group">
				<label for="condition">검색조건</label>
				<select class="form-control" name="condition" id="condition">
					<option value="none">선택하세요</option>
					<option value="title" <c:if test="${condition eq 'title' }">selected</c:if> >제목</option>
					<option value="titlecontent" <c:if test="${condition eq 'titlecontent' }">selected</c:if> >제목+내용</option>					
					<option value="writer" <c:if test="${condition eq 'writer' }">selected</c:if> >작성자</option>

				</select>
					<input class="form-control" type="text" name="keyword" id="keyword" value="${keyword }" placeholder="검색어를 입력하세요"/>
					<button class="img-button" type="submit" disabled="disabled"></button>
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
</body>
<script>
	var keyword=$("#keyword").val();
	//페이지 로딩시 
	if(!isEmpty(keyword)){//키워드가 입력되어 있다면 disabled 속성 없애기
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
 	//input 요소가 비어있는지 확인할 함수
	function isEmpty(str){
		if(str==" " || str=="" || typeof str == "undefined" || str == null){
			return true;
		}
	}
</script>
</html>
