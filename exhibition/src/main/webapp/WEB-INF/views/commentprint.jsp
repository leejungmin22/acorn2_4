<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<c:forEach items="${commentList }" var="tmp">
	<c:choose>
		<c:when test="${tmp.deleted ne 'yes' }">
			<li class="comment" id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if> >
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
						<a href="javascript:" class="reply_link">답글</a> 
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
					<input type="hidden" name="ref_group" value="${tmp.num }" />
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
			<li class="comment" id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }">style="padding-left:50px;"</c:if>>
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