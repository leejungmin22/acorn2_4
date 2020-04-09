<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/community/comDetail.jsp</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
	#profileLink{
		width: 35px;
		height: auto;
		border-radius: 50%;
		margin-left: 10px;
		cursor:default;
	}
	#profileForm{
		display: none;
	}

	/* 글 내용을 출력할 div 에 적용할 css */
	.contents{
		width: 100%;
		border: 1.5px groove rgb(17, 46, 70);
		opacity: .5;
		margin-top:15px;
		margin-bottom:15px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	.table,  th{
		border:none;
		margin-bottom:60px;
	}
	td, tr{
		border-top:hidden;		
		border-bottom:1px solid #ddd;
	}
	.num{
		font-size:20px;
		color: rgb(17, 46, 70);
		opacity: .5;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
		font-weight:lighter;
		
	}
	.title{
		font-size:30px;
		color: rgb(17, 46, 70);
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	.writer{
		font-size:22px;
		color: rgb(17, 46, 70);
		cursor:pointer;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
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
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	#insert, #delete, #prevNum, #nextNum{
		display:inline;
		border:1px solid #bcbcbc;
		padding:10px;
		margin:10px 5px 20px 5px;
		float:right;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	
	/* 댓글에 관련된 css */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments ul li{
		border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 26px;
	}
	.comments form textarea, .comments form button{
		float: left;
		font-size:15px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	.comments li{
		clear: left;
	}
	.comments form textarea{
		width: 85%;
		height: 100px;
	}
	.comments form button{
		width: 15%;
		height: 100px;
		font-size:15px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
	.comment form{
		display: none;
	}
	.comment{
		position: relative;
		margin-top:20px;
		font-size:15px;
		font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	}
	.comment .reply_icon{
		width: 8px;
		height: 8px;
		position: absolute;
		top: 10px;
		left: 30px;
	}
	.comments .user-img{
		width: 20px;
		height: 20px;
		border-radius: 50%;
	}
	pre{
	font-size:15px;
	font-family: "Noto Sans KR","맑은 고딕","Malgun Gothic";
	background-color:#FFFFFF;
}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="community" name="category"/>
</jsp:include>
<div class="container">
	<div class="sub-nav-left">
		<a href="${pageContext.request.contextPath }/home.do" onclick="javascript:page_link('000000'); return false;">
			<img src="../resources/images/home.png" alt="홈" />
		</a>
		>
		<a href="${pageContext.request.contextPath }/community/comList.do" onclick="javascript:page_link('010000'); return false;">목록</a>
		>
		<a href="${pageContext.request.contextPath }/community/comDetail.do?num=${dto.num }" onclick="javascript:page_link('010100'); return false;">${dto.title }</a>
	</div>	
	<c:if test="${not empty keyword }">
		<p> <strong>${keyword }</strong> 검색어로 검색</p>
	</c:if>
	<table class="table">
		<colgroup>
			<col class="col-xs-1"/>
			<col class="col-xs-1"/>
		</colgroup>
		<tr>
			<td class="num">${dto.num }</td>
		</tr>
		<tr>
			<td class="title">${dto.title }</td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td>
				<c:choose>
				<c:when test="${empty dto3.profile }">
					<img id="profileLink" src="${pageContext.request.contextPath }/resources/images/default_user.jpeg"/>
				</c:when>
				<c:otherwise>
					<img id="profileLink" src="${pageContext.request.contextPath }${dto3.profile}"/>
				</c:otherwise>
				</c:choose>
			</td>			
			<td class="writer">
				<c:choose>
					<c:when test="${admin eq 1 || dto.writer eq id }">
						<a href="/exhibition/users/info.do">${dto.writer}</a>
					</c:when>
					<c:otherwise>
						${dto.writer}
					</c:otherwise>
				</c:choose>				
			</td>
			<td class="num">${dto.regdate }</td>
		</tr>
		
	</table>
	
	<div class="contents">${dto.content }</div>
	<c:if test="${dto.prevNum ne 0 }">
		<a href="comDetail.do?num=${dto.prevNum }&condition=${condition}&keyword=${encodedKeyword}" id="prevNum">이전글</a>
	</c:if>

	<c:if test="${dto.nextNum ne 0 }">
		<a href="comDetail.do?num=${dto.nextNum }&condition=${condition}&keyword=${encodedKeyword}" id="nextNum">다음글</a>
	</c:if>	
	<%-- 
		글 작성자와 로그인 된 아이디가 같을때만 기능을 제공해 준다. 
		즉, 본인이 작성한 글만 수정할수 있도록 하기 위해
	--%>
	<c:if test="${ admin eq 1 || dto.writer eq id }">
		<a href="updateform.do?num=${dto.num }" id="insert"style="margin-right:10px;">수정</a>
		<a href="javascript:deleteConfirm()" id="delete" >삭제</a>
	</c:if>
	<div class="row">
		<div class="col-sm-12">
			<div class="comments">
				<div class="comment_form">
					<form class="comment-insert-form" action="comment_insert.do" method="post">
						<input type="hidden" name="ref_group" value="${dto.num }" />						
						<!-- 원글의 작성자 id(댓글의 대상자) -->
						<input type="hidden" name="target_id" value="${dto.writer }"/>
						<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
						<button type="submit">등록</button>
					</form>
				</div>
				<ul>		
			<c:forEach items="${comCommentList }" var="tmp" varStatus="status">
					<c:choose>
						<c:when test="${tmp.deleted ne 'yes' }">
							<li class="comment" id="comment${tmp.num }" 
								<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if> >
								<c:if test="${tmp.num ne tmp.comment_group }">
									<img class="reply_icon" src="${pageContext.request.contextPath}/resources/images/re.gif"/>
								</c:if>
								
								<dl>
									<dt>
									<c:choose>	
										<c:when test="${empty tmp.profile }">
											<img class="user-img" src="${pageContext.request.contextPath}/resources/images/default_user.jpeg"/>
										</c:when>
										<c:otherwise>
	
											<img class="user-img" src="${pageContext.request.contextPath}${tmp.profile}"/>
										</c:otherwise>
									</c:choose>										
									<span>${tmp.writer }</span>
									<c:if test="${tmp.num ne tmp.comment_group }">
										to <strong>${tmp.target_id }</strong>
									</c:if>
								</dt>
								<dd>
									<pre>${tmp.content }</pre>
								</dd>
								<dd>
									<span>${tmp.regdate }</span>
									<a href="javascript:" class="reply_link">답글</a> |
									<c:choose>
										<%-- 로그인된 아이디와 댓글의 작성자가 같으면 --%>
										<c:when test="${id eq tmp.writer }">
											<a href="javascript:" class="comment-update-link">수정</a>&nbsp;&nbsp;
											<a href="javascript:deleteComment(${tmp.num })">삭제</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:">신고</a>
										</c:otherwise>
									</c:choose>
								</dd>
							</dl>
							<form class="comment-insert-form" action="comment_insert.do" method="post">
								<!-- 덧글 그룹 -->
								<input type="hidden" name="ref_group" value="${dto.num }" />
								<!-- 덧글 대상 -->
								<input type="hidden" name="target_id" value="${tmp.writer }" />
								<input type="hidden" name="comment_group" value="${tmp.comment_group }" />
								<textarea name="content"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
								<button type="submit">등록</button>
							</form>	
							<!-- 로그인한 아이디와 댓글의 작성자와 같으면 수정폼 출력 -->				
							<c:if test="${id eq tmp.writer }">
								<form class="comment-update-form" action="comment_update.do" method="post">
									<input type="hidden" name="num" value="${tmp.num }" />
									<textarea name="content">${tmp.content }</textarea>
									<button type="submit">수정</button>
								</form>
							</c:if>
						</li>
					</c:when>
						<c:otherwise>
							<li class="comment" id="comment${tmp.num }"
								<c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
								<c:if test="${tmp.num ne tmp.comment_group }">
									<img class="reply_icon"
										src="${pageContext.request.contextPath}/resources/images/re.gif" />
								</c:if>
								<dl>
									<dt>
										<c:choose>
											<c:when test="${empty tmp.profile }">
												<img class="user-img"
													src="${pageContext.request.contextPath}/resources/images/default_user.jpeg" />
											</c:when>
												<c:otherwise>
													<img class="user-img"
														src="${pageContext.request.contextPath}${tmp.profile}" />
												</c:otherwise>
											</c:choose>
											<span>${tmp.writer }</span>
											<c:if test="${tmp.num ne tmp.comment_group }">
										 	to <strong>${tmp.target_id }</strong>
											</c:if>
											<span>${tmp.regdate }</span>
										</dt>
										<dd>
											<pre>삭제된 댓글 입니다.</pre>
										</dd>
									</dl>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					</ul>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	</div>
<script>
	//댓글 수정 링크를 눌렀을때 호출되는 함수 등록
	$(".comment-update-link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-update-form")
		.slideToggle(200);
	});
	
	//댓글 수정 폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
	$(".comment-update-form").on("submit", function(){
		// "comment_update.do"
		var url=$(this).attr("action");
		//폼에 작성된 내용을 query 문자열로 읽어온다.
		// num=댓글번호&content=댓글내용
		var data=$(this).serialize();
		//이벤트가 일어난 폼을 선택해서 변수에 담아 놓는다.
		var $this=$(this);
		$.ajax({
			url:url,
			method:"post",
			data:data,
			success:function(responseData){
				// responseData : {isSuccess:true}
				if(responseData.isSuccess){
					//폼을 안보이게 한다 
					$this.slideUp(200);
					//폼에 입력한 내용 읽어오기
					var content=$this.find("textarea").val();
					//pre 요소에 수정 반영하기 
					$this.parent().find("pre").text(content);
				}
			}
		});
		//폼 제출 막기 
		return false;
	});
	
	//댓글 삭제를 눌렀을때 호출되는 함수
	function deleteComment(num){
		var isDelete=confirm("확인을 누르면 댓글이 삭제 됩니다.");
		if(isDelete){
			//페이지 전환 없이 ajax 요청을 통해서 삭제 하기 
			$.ajax({
				url:"comment_delete.do", 
				method:"post",
				data:{"num":num}, // num 이라는 파라미터명으로 삭제할 댓글의 번호 전송
				success:function(responseData){
					if(responseData.isSuccess){
						var sel="#comment"+num;
						$(sel).text("삭제된 댓글 입니다.");
					}
				}
			});
		}
}
	
	//폼에 submit 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form").on("submit", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			alert("로그인 페이지로 이동 합니다.");
			location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/community/comDetail.do?num=${dto.num}";
			return false;//폼 전송 막기 
		}
	});
	//폼에 click 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comments form textarea").on("click", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin==false){
			var isMove=confirm("로그인 페이지로 이동 하시겠습니까?");
			if(isMove){
				location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/community/comDetail.do?num=${dto.num}";
			}
		}
	});	
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(".comment .reply_link").click(function(){
		$(this)
		.parent().parent().parent()
		.find(".comment-insert-form")
		.slideToggle(200);
		
		// 답글 <=> 취소가 서로 토글 되도록 한다. 
		if($(this).text()=="답글"){
			$(this).text("취소");
		}else{
			$(this).text("답글");
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("글을 삭제 하시 겠습니까?");
		if(isDelete){
			location.href="delete.do?num=${dto.num}";
		}
	}
</script>
</body>
</html>