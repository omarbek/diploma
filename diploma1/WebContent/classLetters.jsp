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
<% String student_grade = request.getParameter("student_grade"); %>
<div class="container"  id="content">
	<section id="main" class="trener">
    	<h1 class="text-center">Выберите класс</h1>    
     	<div class="hr-img">
        	<img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <br>
        <div class="row">
        	<div class="col-md-10 col-md-offset-1">
	        	<div class="row">
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=1">
	                     <img src="img/icons/19.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=2">
	                     <img src="img/icons/20.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=3">
	                     <img src="img/icons/21.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	            </div>
	            <div class="row">
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=4">
	                     <img src="img/icons/22.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=5">
	                     <img src="img/icons/23.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-4">
	                <div class="subject">
	                  <a href="?navPage=studentList&student_grade=<%=student_grade%>&class_letter=6">
	                     <img src="img/icons/24.png" class="" alt="" style="width:175px; margin-left:30px;">
	                  </a>
	                </div>
	              </div>
	            </div>
			</div>
		</div>
	</section>   
</div>
<% } %>