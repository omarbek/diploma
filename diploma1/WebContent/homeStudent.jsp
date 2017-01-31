<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <body>
    <div class="container" id="content">
	<% 
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
          	if("one".equals(grade)){
          		%>
		          <li><a href="?navPage=homeStudent&grade=one&classId=<%=classId %>" class="active">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=homeStudent&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=homeStudent&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=homeStudent&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else if("two".equals(grade)){
          		%>
		          <li><a href="?navPage=homeStudent&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=homeStudent&grade=two&classId=<%=classId %>" class="active">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=homeStudent&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=homeStudent&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else if("three".equals(grade)){
          		%>
		          <li><a href="?navPage=homeStudent&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=homeStudent&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=homeStudent&grade=three&classId=<%=classId %>" class="active">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=homeStudent&grade=four&classId=<%=classId %>">4 класс</a></li>
          		<%
		          }
          	}else{
          		%>
		          <li><a href="?navPage=homeStudent&grade=one&classId=<%=classId %>">1 класс</a></li>
		          <% if(classId>=2){ %>
		          <li><a href="?navPage=homeStudent&grade=two&classId=<%=classId %>">2 класс</a></li>
		          <% } if(classId>=3){ %>
		          <li><a href="?navPage=homeStudent&grade=three&classId=<%=classId %>">3 класс</a></li>
		          <% } if(classId>=4){ %>
		          <li><a href="?navPage=homeStudent&grade=four&classId=<%=classId %>" class="active">4 класс</a></li>
          		<%
		          }
          	}
          %>
        </ul>
        </div>
       <%
       String sql = null;
       
       if (grade != null && grade.equals("one")){       
   		sql = "SELECT t.* FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
				     +" where t.grade=1 and ut.user_id="+session.getAttribute("studentID")
				     +" and (ut.topic_id<=(select max(topic_id) from user_topic where one>=75"
				     +" and two>=75 and three>=75 and four>=75 and"
				     +" five>=75 and six>=75)+1 and ut.topic_id<9)";
          }
       else if (grade != null && grade.equals("two")){       
      		sql = "SELECT t.* FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
				     +" where t.grade=1 and ut.user_id="+session.getAttribute("studentID")
				     +" and (ut.topic_id<=(select max(topic_id) from user_topic where one>=75"
				     +" and two>=75 and three>=75 and four>=75 and"
				     +" five>=75 and six>=75)+1 and ut.topic_id>8 and ut.topic_id<17)";
         }
       else if (grade != null && grade.equals("three")){       
     		sql = "SELECT t.* FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
				     +" where t.grade=1 and ut.user_id="+session.getAttribute("studentID")
				     +" and (ut.topic_id<=(select max(topic_id) from user_topic where one>=75"
				     +" and two>=75 and three>=75 and four>=75 and"
				     +" five>=75 and six>=75)+1 and ut.topic_id>16 and ut.topic_id<25)";
        }
       else if (grade != null && grade.equals("four")){       
     		sql = "SELECT t.* FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
				     +" where t.grade=1 and ut.user_id="+session.getAttribute("studentID")
				     +" and (ut.topic_id<=(select max(topic_id) from user_topic where one>=75"
				     +" and two>=75 and three>=75 and four>=75 and"
				     +" five>=75 and six>=75)+1 and ut.topic_id>24)";
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