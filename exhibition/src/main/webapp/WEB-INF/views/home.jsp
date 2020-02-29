<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="include/resource.jsp" />
<!-- fullcalendar -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
    	height: 600,
		plugins: [ 'dayGrid' ],
		defaultView: 'dayGridMonth',
		defaultDate: new Date(),
		header: {
		    left: '',
		    center: 'title',
		    right: 'prev,next today'
		  },
		eventLimit: true,
		eventLimitText: "more",
		eventLimitClick: "popover",
		editable: false,
		droppable: false,
		dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
		events:function(info, successCallback, failureCallback){
			$.ajax({
		           url: '${pageContext.request.contextPath}/getEvents.do',
		           dataType: 'json',
		           success: 
		        	   function(result) {
			               var events = [];
			               if(result!=null){
				            	   $.each(result, function(index, element) {
			            		   var enddate=element.enddate;
									if(enddate==null){
										enddate=element.startdate;
									}
									events.push({
				                       title: element.title,
				                       start: element.startdate,
				                       end: enddate,
				           			   url: "detail.do?seq="+element.seq
				                    }); //.push()
									
				               }); //.each()
			            	   console.log(events);
			               }//if end
			               
			               successCallback(events);	
			           }//success: function end
		          
		       }); //ajax end

		}//events:function end
		
   });//new FullCalendar end

   calendar.render();
   
  });
  
</script>
<!-- owl.carousel -->
<script>
$(document).ready(function(){
  $('.owl-carousel').owlCarousel({
		loop:true,
		margin:10,
		autoplay:true,
		autoplayTimeout:1000,
	    autoplayHoverPause:true,
		responsiveClass:true,
		responsive:{
		    0:{
		        items:3,
		    },
		    600:{
		        items:3,
		    },
		    1000:{
		        items:5,
		        loop:false //Infinity loop. Duplicate last and first items to get loop illusion.
		    }
		}
  })
});
</script>
<style>
	.owl-carousel .item {
	    padding: 1rem;
    }
    .condition{
    	margin: 10px 0 20px 0;
    }
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp" />
<div class="container">
	<div class="condition" align="right">
		<form class="form-inline" action="list.do" method="get"> 
			<div class="form-group">
				<label for="condition">검색조건</label>
				<select class="form-control" name="condition" id="condition">
					<option value="titleName" <c:if test="${condition eq 'titleName' }">selected</c:if>>제목+파일명</option>
					<option value="title" <c:if test="${condition eq 'title' }">selected</c:if>>제목</option>
					<option value="writer" <c:if test="${condition eq 'writer' }">selected</c:if>>작성자</option>
				</select>
				<input class="form-control" type="text" name="keyword" id="keyword" value="${keyword }" placeholder="검색어를 입력하세요" />
				<button class="btn btn-primary type="submit">검색</button>
			</div>
		</form>
	</div>

	<!-- fullcalendar 출력 -->
	<div id='calendar'></div>
	
	<!-- owl.carousel data-->
	<h3>인기 공연</h3>
	<div class="row">
		<div class="large-12 columns">
			<div class="owl-carousel owl-theme">
				<c:forEach var="tmp" items="${list }">
					<div class="item">
						<a href="${pageContext.request.contextPath }/detail.do?seq=${tmp.seq}">
							<img alt="${tmp.title }" src="${tmp.thumbnail }">
						</a>
				    </div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>