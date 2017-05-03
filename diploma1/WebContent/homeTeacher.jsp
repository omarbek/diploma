<% 
	session=request.getSession(false);
	if(session==null){
		session.invalidate();
	response.sendRedirect("index.jsp");
	}else{
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="container"  id="content">
	<section id="main" class="trener">
    	<h1 class="text-center">Выберите класс</h1>    
     	<div class="hr-img">
        	<img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <h3 class="text-center" style="color:#808080;">
          Для того, чтобы увидеть успеваемость учеников на нашем сайте, <br>
          сначала выберите класс, затем выберите букву.
        </h3>
        <br>
        <div class="row">
        	<div class="col-md-10 col-md-offset-1">
	        	<div class="row">
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=classLetters&student_grade=1">
	                     <img src="img/icons/15.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-one">1 класс</span>
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=classLetters&student_grade=2">
	                     <img src="img/icons/16.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-snd-two">2 класс</span>
	                  </a>
	                </div>
	              </div>
	            </div>
	            <div class="row">
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=classLetters&student_grade=3">
	                     <img src="img/icons/17.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-thrd-three">3 класс</span>
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=classLetters&student_grade=4">
	                     <img src="img/icons/18.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-frth-four">4 класс</span>
	                  </a>
	                </div>
	              </div>
	            </div>
			</div>
		</div>
	</section>   
</div>
<%}%>