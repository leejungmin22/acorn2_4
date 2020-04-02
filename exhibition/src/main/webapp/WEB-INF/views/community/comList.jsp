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
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="category"/>
</jsp:include>
<div class="container">
	<div class="sub-nav-left">
			<a href="home.do" onclick="javascript:page_link('000000'); return false;">
				<img src="../resources/images/home.png" alt="홈" />
			</a>
			>
			<a href="${pageContext.request.contextPath }/community/comList.do" onclick="javascript:page_link('010000'); return false;">목록</a>
			>
			<a href="${pageContext.request.contextPath }/community/comList.do" onclick="javascript:page_link('010000'); return false;">목록</a>
		</div>	
	
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
					<input class="form-control" type="text" name="keyword" placeholder="검색어를 입력하세요" value="${keyword }"/>
					<button class="img-button" type="submit"></button>
				</select>
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
</html>