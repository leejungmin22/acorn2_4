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
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/main.css'/>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/daygrid.min.css'/>
<link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath }/resources/css/fullcalendar/timegrid.min.css'/>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/main.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/interaction.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/daygrid.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/fullcalendar/timegrid.min.js'/>"></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
      defaultView: 'dayGridMonth',
      defaultDate: new Date(),
      header: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
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
          }
        ] 
    });

    calendar.render();
  });


</script>
</head>
<body>

<jsp:include page="include/navbar.jsp" />
<div class="container">
	<h3>공연 일정</h3>
	<div id='calendar'></div>
	
	<h3>인기 공연</h3>
	<div class="popular_wrap">
	
	</div>
</div>
<jsp:include page="include/footer.jsp" />
</body>
