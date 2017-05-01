<% 
	session=request.getSession(false);
	if(session==null){
		session.invalidate();
	response.sendRedirect("index.jsp");
	}else{
%>
<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
    <div class="container" id="content">
      <section id="main">
        <h1 class="text-center">
          Мой профиль
        </h1>
        <%  
        try{
    		String userID = (String) session.getAttribute("userId");
        	String sql = "select * from teachers where user_id="+userID;
        	String sql2 = "select * from users where user_id="+userID;
        	PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ResultSet rs2 = ps2.executeQuery();
			String schoolName = null;
			String schoolCity = null;
			String teacherLastName = null;
			String teacherFirstName = null;
			String teacherEmail = null;
			if (rs.next()){
				teacherFirstName = rs.getString(3);
				teacherLastName = rs.getString(4);
				schoolName = rs.getString(5);
				schoolCity = rs.getString(6);
			}
			if (rs2.next()){
				teacherEmail = rs2.getString(2);
			}
			%>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
        </div>
        <div class="profile">
          <div class="row">
            <div class="col-md-8 col-md-offset-2">
            	<div class="profile-block">
              <h1><%=teacherLastName%> <%=teacherFirstName%></h1>
              <div class="row">
              	<div class="col-md-8"><p>
              	<i class="glyphicon glyphicon-envelope"></i> <%=teacherEmail%><br>
              	<i class="glyphicon glyphicon-map-marker"></i> 
              	<%  if (schoolCity.equals("Алматы") || schoolCity.equals("Астана")){ %>
              			г. <%=schoolCity%> <% } 
              		else {%> 
              			<%=schoolCity%> область
              	<%  } %>
              	| №<%=schoolName%> школа <br>        	
              </p>
              </div>
              	<div class="col-md-4">	<p class="text-right"><a href="?navPage=edit_profileTeacher"><i class="glyphicon glyphicon-pencil"></i> Редактировать</a><br/><a href="?navPage=delete_profile" style="color:red;"><i class="glyphicon glyphicon-trash"></i> Удалить Профиль</a></p>
              </div>
              
              </div>
              </div>
			<% 	}
        catch(MySQLNonTransientConnectionException e){
        }%>

            </div>
          </div>
        </div>
        
      </section>
      
    </div>
<% } %>