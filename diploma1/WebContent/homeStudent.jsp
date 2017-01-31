<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <body>
    <div class="container" id="content">
	<% String grade = request.getParameter("grade"); %>
      <section id="main" class="subjects">
        <h1 class="text-center">
          Уроки
        </h1>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <div class="animatedParent">
        <ul class="list-inline classes animated bounceInLeft">
          <li><a href="?navPage=homeStudent&grade=one" class="active">1 класс</a></li>
          <li><a href="?navPage=homeStudent&grade=two">2 класс</a></li>
          <li><a href="?navPage=homeStudent&grade=three">3 класс</a></li>
          <li><a href="?navPage=homeStudent&grade=four">4 класс</a></li>
        </ul>
        </div>
       <%
       String sql = "SELECT * FROM topics where grade=1";
       
       if (grade != null && grade.equals("one")){       
   		sql = "SELECT * FROM topics where grade=1";
          }
       
       else if (grade != null && grade.equals("two")){       
		sql = "SELECT * FROM topics where grade=2";
       }
       else if (grade != null && grade.equals("three")){       
   		sql = "SELECT * FROM topics where grade=3";
          }
       else if (grade != null && grade.equals("four")){       
   		sql = "SELECT * FROM topics where grade=4";
          }
		PreparedStatement prepStmt = con.prepareStatement(sql);
		ResultSet rs = prepStmt.executeQuery();
		int i=0;
		while(rs.next()){
			if(i%4 == 0){%>
			<div class="row">
		  	<%}%>
		  	<div class="col-md-3 ">
		            <div class="subject">
		              <a href="?navPage=trainings&topic_id=<%=rs.getString(1)%>"><img src="img/subjects/<%=rs.getString(1)%>.jpg" class="img-responsive" alt=""></a>
		              <div><h3><a href="?navPage=trainings&topic_id=<%=rs.getString(1)%>"><%=rs.getString(2) %></a></h3></div>
		            </div>
		     </div>
			<%if((i+1)%4 == 0){%>
			</div>
			<%}
			i++;
		}
		%>
      </section>
      
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.bxslider.js"></script>
    <script src="js/css3-animate-it.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>