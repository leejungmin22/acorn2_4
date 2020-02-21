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
        
		//샘플 data
		events: [
		  {
		    title: 'All Day Event',
		    start: '2020-02-01'
		  },
		  {
		    title: 'Long Event',
		    start: '2020-02-07',
		    end: '2020-02-10'
		  },
		  {
		    groupId: '999',
		    title: 'Repeating Event',
		    start: '2020-02-09T16:00:00'
		  },
		  {
		    groupId: '999',
		    title: 'Repeating Event',
		    start: '2020-02-16T16:00:00'
		  },
		  {
		    title: 'Conference',
		    start: '2020-02-11',
		    url: 'http://google.com/',
		    end: '2020-02-13'
		  },
		  {
		    title: 'Meeting',
		    start: '2020-02-12T10:30:00',
		    end: '2020-02-12T12:30:00'
		  },
		  {
		    title: 'Lunch',
		    start: '2020-02-12T12:00:00'
		  },
		  {
		    title: 'Meeting',
		    start: '2020-02-12T14:30:00'
		  },
		  {
		    title: 'Birthday Party',
		    start: '2020-02-13T07:00:00'
		  },
		  {
		    title: 'Click for Google',
		    url: 'http://google.com/',
		    start: '2020-02-28'
		  },
		  {
		      title: 'hi',
		      url: 'http://google.com/',
		      start: '2020-02-28'
		    }
		] 
   });

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
    height: 10rem;
    background: #4DC7A0;
    padding: 1rem;
    }
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp" />
<div class="container">
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
	<h3>공연 일정</h3>
	<div id='calendar'></div>
	
	<!-- owl.carousel 샘플 data-->
	<h3>인기 공연</h3>
	<div class="row">
		<div class="large-12 columns">
			<div class="owl-carousel owl-theme">
				<div class="item">
			      <h4>1</h4>
			    </div>
			    <div class="item">
			      <h4><a href="${pageContext.request.contextPath }/detail.do?seq=${seq}">2</a></h4>
			    </div>
			    <div class="item">
			      <h4>3</h4>
			    </div>
			    <div class="item">
			      <h4>4</h4>
			    </div>
			    <div class="item">
			      <h4>5</h4>
			    </div>
			    <div class="item">
			      <h4>6</h4>
			    </div>
			    <div class="item">
			      <h4>7</h4>
			    </div>
			    <div class="item">
			      <h4>8</h4>
			    </div>
			    <div class="item">
			      <h4>9</h4>
			    </div>
			    <div class="item">
			      <h4>10</h4>
			    </div>	
			</div>
		</div>
	</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
</html>