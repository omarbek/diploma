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
    <title>SpeakKaзakh</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- bxSlider CSS file -->
    <link href="css/jquery.bxslider.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="css/style.css?v=1.24">
    <link rel="stylesheet" type="text/css" href="css/circle.css">
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
	String userId = (String)session.getAttribute("userId");
	String userStatus = (String)session.getAttribute("userStatus");
	String navPage = request.getParameter("navPage");

	PreparedStatement ps=con.prepareStatement("select studentClass from students where user_id="+userId);
	ResultSet rs = ps.executeQuery();
	String classId=null;
	if(rs.next()){
		classId=rs.getString(1);
	}
	%>
  <body  <%
		if((userId == null)){
			%>
			class="login"
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
            <a href="index.jsp">Главная</a>
          </li>
          <li>
            <a href="?navPage=homeStudent&grade=one&classId=<%=classId%>">Уроки</a>
          </li>
          <li>
            <a href="?navPage=tests">Проверь себя</a>
          </li>
          <li>
            <a href="?navPage=dictionary">Мой словарь</a>
          </li>
          <li>
            <a href="?navPage=profile">Мой профиль</a>
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
		else{
			if(navPage == null){
				%>
			<jsp:include page="home.jsp" />
				<%
				}
			else if(navPage.equals("homeStudent")){	
					
					%>
			<jsp:include page="homeStudent.jsp" />
					<%
				}
			else if(navPage.equals("dictionary")){	
				
				%>
		<jsp:include page="dictionary.jsp" />
				<%
			}
			else if(navPage.equals("profile")){	
				
				%>
		<jsp:include page="profile.jsp" />
				<%
			}
			else if(navPage.equals("delete_profile")){	
				
				%>
		<jsp:include page="delete_profile.jsp" />
				<%
			}
			else if(navPage.equals("tests")){	
				
				%>
		<jsp:include page="tests.jsp" />
				<%
			}
			else if(navPage.equals("prover_sebya")){	
				
				%>
		<jsp:include page="prover_sebya.jsp" />
				<%
			}
			else if(navPage.equals("trainings")){	
					%>
			<jsp:include page="trainings.jsp" />
					<%			
				}
			
			else if(navPage.equals("trainingOne")){	
					%>
			<jsp:include page="trainingOne.jsp" />
					<%			
				}
			else if(navPage.equals("trainingTwo")){	
					%>
			<jsp:include page="trainingTwo.jsp" />
					<%			
				} 
			else if(navPage.equals("trainingThree")){
					%>
			<jsp:include page="trainingThree.jsp" />
					<%			
				}else if(navPage.equals("trainingFour")){
					%>
			<jsp:include page="trainingFour.jsp" />
					<%			
				}else if(navPage.equals("trainingFive")){
					%>
			<jsp:include page="trainingFive.jsp" />
					<%			
				}else if(navPage.equals("trainingSix")){
					%>
			<jsp:include page="trainingSix.jsp" />
					<% 
				}else if(navPage.equals("forgot")){
					%>
			<jsp:include page="forgot.jsp" />	
					<%
				}
					}%>
    </div>






    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.bxslider.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>
