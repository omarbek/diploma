<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="container"  id="content">
	<section id="main" class="trener">
    	<h1 class="text-center">Проверь себя</h1>    
     	<div class="hr-img">
        	<img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <h3 class="text-center" style="color:#808080;">
          Проверь свои знания за прошедший класс! <br>
          Пройди все виды тренировок со словами из разных тем определеного класса.
        </h3>
        <br>
     <% 
 	String studentId = (String)session.getAttribute("studentID");
       	String sql1 = "select studentClass from students where student_id='"+studentId+"'";
       try{
       	PreparedStatement prepStmt1 = con.prepareStatement(sql1);
       	ResultSet rs1 = prepStmt1.executeQuery();
       	if (rs1.next()){%>
        <div class="row">
          <div class="col-md-10 col-md-offset-1">
        <% if (rs1.getString(1).equals("1")){%>
            <div class="row">
              <div class="col-md-6 col-md-offset-3">
                <div class="subject">
                  <a href="?navPage=prover_sebya&test_grade=1&questionId=0">
                     <img src="img/icons/11.png" class="" alt="" style="width:150px;">
                     <span class="prov_sebya castellar">1 класс</span>
                  </a>
                </div>
              </div>
            </div>
         <% }
        	else if (rs1.getString(1).equals("2")){%>
        	<div class="row">
              <div class="col-md-6">
                <div class="subject">
                  <a href="?navPage=prover_sebya&test_grade=1&questionId=0">
                     <img src="img/icons/11.png" class="" alt="" style="width:150px;">
                     <span class="prov_sebya castellar">1 класс</span>
                  </a>
                </div>
              </div>
              <div class="col-md-6">
                <div class="subject">
                  <a href="?navPage=prover_sebya&test_grade=2&questionId=0">
                     <img src="img/icons/12.png" class="" alt="" style="width:150px;">
                     <span class="prov_sebya castellar-snd">2 класс</span>
                  </a>
                </div>
              </div>
            </div>
         <% } 
	        else if (rs1.getString(1).equals("3")){%>
	        	<div class="row">
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=1&questionId=0">
	                     <img src="img/icons/11.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar">1 класс</span>
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=2&questionId=0">
	                     <img src="img/icons/12.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-snd">2 класс</span>
	                  </a>
	                </div>
	              </div>
	           </div>
	           <div class="row">
	              <div class="col-md-6 col-md-offset-3">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=3&questionId=0">
	                     <img src="img/icons/13.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-thrd">3 класс</span>
	                  </a>
	                </div>
	              </div>
	           </div>
	  	 <% } 
		  	 else if (rs1.getString(1).equals("4")){%>
	        	<div class="row">
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=1&questionId=0">
	                     <img src="img/icons/11.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar">1 класс</span>
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=2&questionId=0">
	                     <img src="img/icons/12.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-snd">2 класс</span>
	                  </a>
	                </div>
	              </div>
	            </div>
	            <div class="row">
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=3&questionId=0">
	                     <img src="img/icons/13.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-thrd">3 класс</span>
	                  </a>
	                </div>
	              </div>
	              <div class="col-md-6">
	                <div class="subject">
	                  <a href="?navPage=prover_sebya&test_grade=4&questionId=0">
	                     <img src="img/icons/14.png" class="" alt="" style="width:150px;">
	                     <span class="prov_sebya castellar-frth">4 класс</span>
	                  </a>
	                </div>
	              </div>
	            </div>
	         <% } %>
          </div>
        </div>
       <% }
       }
       catch(MySQLNonTransientConnectionException e){
       }
       	%>
	</section>   
</div>
