<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container" id="footer">
    <!----------- Footer ------------>
    <footer class="footer-bs">
        <div class="row">
        	<div class="col-md-3 footer-brand animated fadeInLeft">
            	<img class="logoimg" src="${pageContext.request.contextPath }/resources/images/main_logo.png" alt="" />					
                <p>2020 Acorn Final Project</p>
            </div>
            
            	<h4>Menu</h4>
            	<div class="col-md-3">
                    <a href="${pageContext.request.contextPath }/home.do">Home</a>
                </div>
                <div class="col-md-3">
                	<a href="${pageContext.request.contextPath }/list.do">전체공연</a>
                </div>
                <div class="col-md-3">
                	<a href="${pageContext.request.contextPath }/map.do">지도</a>
                </div>
                <div class="col-md-3">
                	<a href="${pageContext.request.contextPath }/community/comList.do">자유게시판</a></li>
                </div>
                
        </div>
        <section style="text-align:center; margin:10px auto;">
	    				<p>Developer JM Lee, SH Joo, SJ Park, HK Kim</p>
	    </section>	
    </footer>
   
</div>