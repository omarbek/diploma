<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>  
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <body>
    <div class="container" id="content">
	<% 
	if(con==null){
   		con = (new DBConnection()).getConnection();
   	   }
	try{
		String grade = request.getParameter("grade"); 
	    int classId = Integer.parseInt(request.getParameter("classId")); 
	%>
      <section id="main" class="subjects">
        <h1 class="text-center">
          Уроки
        </h1>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <div class="animatedParent">
        <ul class="list-inline classes animated bounceInLeft">
          <% 
          	if("one".equals(grade)){ ////
          		%>
		          <li><a href="?navPage=a_topics&grade=one&classId=<%=classId %>" class="active">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=a_topics&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=a_topics&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=a_topics&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else if("two".equals(grade)){
          		%>
		          <li><a href="?navPage=a_topics&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=a_topics&grade=two&classId=<%=classId %>" class="active">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=a_topics&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=a_topics&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else if("three".equals(grade)){
          		%>
		          <li><a href="?navPage=a_topics&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=a_topics&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=a_topics&grade=three&classId=<%=classId %>" class="active">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=a_topics&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else{
          		%>
		          <li><a href="?navPage=a_topics&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=a_topics&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=a_topics&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=a_topics&grade=four&classId=<%=classId %>" class="active">4 класс</a></li>
          		<%
		          }
          	}
          %>
        </ul>
        </div>
       <%
       String sql = null;
       
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
		              <a href="?navPage=words&topic_id=<%=rs.getLong("topic_id")%>"><img src="img/subjects/<%=rs.getLong("topic_id")%>.jpg" class="img-responsive" alt=""></a>
		              <div class="row">
						<div class="col-md-7 ">
							<h3><a href="?navPage=words&topic_id=<%=rs.getLong("topic_id")%>"><%=rs.getString("topic_name") %></a></h3>
						</div>
						<div class="col-md-5 ">
							<a href="?navPage=add_topic&topic_id=<%=rs.getLong("topic_id")%>">Изменить</a>
							<form action="TopicServlet" method="post">
								<input type="hidden" name="page" value="remove">
								<input type="hidden" name="topic_id" value="<%=rs.getLong("topic_id")%>">
								<button>Удалить</button>
							</form>
						</div>	
					  </div>
		            </div>
		     </div>
			<%if((i+1)%4 == 0){%>
			</div>
			<%}
			i++;
		} 
				}
        catch(MySQLNonTransientConnectionException e){
        	con = (new DBConnection()).getConnection();
        }%>
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