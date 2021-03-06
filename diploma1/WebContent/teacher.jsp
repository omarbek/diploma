<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Тіл Кемел</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- bxSlider CSS file -->
    <link href="css/jquery.bxslider.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  	<script src="js/jquery-3.1.1.min.js"></script>
  	<script src="js/bootstrap.min.js"></script>
  	<script src="js/main.js"></script>
  </head>
  	<%
  	try{
	String userId = (String)session.getAttribute("userId");
	String userStatus = (String)session.getAttribute("userStatus");
	String navPage = request.getParameter("navPage");

	%>
  <body <%
		if((userId == null)){
			%>
			class="login"
			<%
		}
		else {
			%>
			class="authorized"
			<%
		}%>>

    <div class="container" id="content">
      <div id="nav" class="row" href="sad">
        <nav class="list-inline">
		<%
          if(userId==null){
          	  %><a href="?login.jsp"></a> <%
        		}
        		else{
        		%>
          <li>
            <a href="teacher.jsp">Главная</a>
          </li>
          <li>
            <a href="?navPage=homeTeacher">Успеваемость учеников</a>
          </li>
          <li>
            <a href="?navPage=profileTeacher">Мой профиль</a>
          </li>
		  <% } %>
        </nav>
        <ul class="user-link list-inline">
          <li>
            <%
	          if(userId==null){
	          	  %><a href="index.jsp"><span class="glyphicon glyphicon-log-in"></span> Войти</a> <%
	          }
        	  else{
        		%>
        		<form action="LogoutServlet" method="post" id="logoutForm"></form>
				<a href="#" id="logout"><span class="glyphicon glyphicon-log-in"></span> Выйти</a>
			  <%} %>
          </li>
        </ul>
      </div>
       <%
		if((userId == null) && (navPage == null)){
			%>
			<jsp:include page="login.jsp" />
			<%
		}
		else if ((userId == null) && (navPage.equals("registration"))){
			%>
			<jsp:include page="registration.jsp"/>
			<%
		}
		else if ((userId == null) && (navPage.equals("registrationTeacher"))){
			%>
			<jsp:include page="registrationTeacher.jsp"/>
			<%
		}
		else{
			if(navPage == null){
				%>
			<jsp:include page="home.jsp" />
				<%
				}
			else if(navPage.equals("homeTeacher")){
					
					%>
			<jsp:include page="homeTeacher.jsp" />
					<%
				}
			else if(navPage.equals("profileTeacher")){	
				
				%>
		<jsp:include page="profileTeacher.jsp" />
				<% 	}
			else if(navPage.equals("delete_profile")){	
				
				%>
		<jsp:include page="delete_profile.jsp" />
				<%
			}
			else if(navPage.equals("edit_profileTeacher")){	
				
				%>
		<jsp:include page="edit_profileTeacher.jsp" />
				<%
			} else if(navPage.equals("classLetters")){
				%>
		<jsp:include page="classLetters.jsp" />
				<%
			}  else if(navPage.equals("studentList")){
				%>
		<jsp:include page="studentList.jsp" />
				<%
			}}
  	} catch(Exception e){

    	session = request.getSession(false);
    	if (session == null) {
    		JOptionPane.showMessageDialog(null, "Ваша сессия истекла. \nПожалуйста, зайдите заново!");
    		response.sendRedirect("?login.jsp");
    	} else {
    		JOptionPane.showMessageDialog(null, "index.jsp\n"+e.getLocalizedMessage());
    	}
    
  	}
			
			%>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.bxslider.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>
