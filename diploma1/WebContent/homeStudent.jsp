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
       String sqlAll = null;
       
       if (grade != null && grade.equals("one")){       
   			sql = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
   			    +" where t.grade=1"
   			    +" and ((((ut.topic_id<=(select max(topic_id) from user_topic where"
   			    +" user_id="+session.getAttribute("userId")+" and one>=75"
   			    +" and two>=75 and three>=75 and four>=75 and five>=75 and six>=75)+1)"
   			    +" and ut.topic_id<>1) or (ut.topic_id=1 and ut.user_id="
   			    + session.getAttribute("userId")+")) and ut.topic_id<9)";
   			sqlAll = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
   				+" where t.grade=1 and ut.user_id="+session.getAttribute("userId");
          }
       else if (grade != null && grade.equals("two")){
    	   sql = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
      			    +" where t.grade=2"
      			    +" and ((((ut.topic_id<=(select max(topic_id) from user_topic where"
      			    +" user_id="+session.getAttribute("userId")+" and one>=75"
      			    +" and two>=75 and three>=75 and four>=75 and five>=75 and six>=75)+1)"
      			    +" and ut.topic_id<>9) or (ut.topic_id=9 and ut.user_id="
      			    + session.getAttribute("userId")+")) and ut.topic_id<17 and ut.topic_id>8)";
      		sqlAll = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
       				+" where t.grade=2 and ut.user_id="+session.getAttribute("userId");
       }
       else if (grade != null && grade.equals("three")){
    	   sql = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
     			    +" where t.grade=3"
     			    +" and ((((ut.topic_id<=(select max(topic_id) from user_topic where"
     			    +" user_id="+session.getAttribute("userId")+" and one>=75"
     			    +" and two>=75 and three>=75 and four>=75 and five>=75 and six>=75)+1)"
     			    +" and ut.topic_id<>17) or (ut.topic_id=17 and ut.user_id="
     			    + session.getAttribute("userId")+")) and ut.topic_id<25 and ut.topic_id>16)";
     		sqlAll = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
       				+" where t.grade=3 and ut.user_id="+session.getAttribute("userId");
       }
       else if (grade != null && grade.equals("four")){
    	   sql = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
    			    +" where t.grade=4"
    			    +" and ((((ut.topic_id<=(select max(topic_id) from user_topic where"
    			    +" user_id="+session.getAttribute("userId")+" and one>=75"
    			    +" and two>=75 and three>=75 and four>=75 and five>=75 and six>=75)+1)"
    			    +" and ut.topic_id<>25) or (ut.topic_id=25 and ut.user_id="
    			    + session.getAttribute("userId")+")) and ut.topic_id>24)";
    		sqlAll = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
       				+" where t.grade=4 and ut.user_id="+session.getAttribute("userId");
       }
		PreparedStatement prepStmt = con.prepareStatement(sql);
		ResultSet rs = prepStmt.executeQuery();
		
		PreparedStatement ps=con.prepareStatement(sqlAll);
		ResultSet rsAll=ps.executeQuery();
		
		int i=0;
		while(rsAll.next()){
			if(i%4 == 0){%>
			<div class="row">
		  	<%}%>
		  	<div class="col-md-3 ">
		  		<%
		  			String subject=null;
		  			if(rs.next()){
		  				subject="subject";
		  			}else{
		  				subject="subject disabled";
		  			}
		  		%>
		            <div class="<%=subject%>">
		              <a href="?navPage=trainings&topic_id=<%=rsAll.getLong("topic_id")%>"><img src="img/subjects/<%=rsAll.getLong("topic_id")%>.jpg" class="img-responsive" alt=""></a>
		              <div class="row">
						<div class="col-md-7 ">
							<h3><a href="?navPage=trainings&topic_id=<%=rsAll.getLong("topic_id")%>"><%=rsAll.getString("topic_name") %></a></h3>
						</div>
						<%
							double average=(rsAll.getDouble("one")+rsAll.getDouble("two")+rsAll.getDouble("three")
									+rsAll.getDouble("four")+rsAll.getDouble("five")+rsAll.getDouble("six"))/6;
							if(average==100){
						%>
								<div class="col-md-5 ">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
								</div>	
						<%
							} else if(average>=75&&average<100){
						%>
							<div class="col-md-5 ">
								<img src="img/icons/zvezda_full.png" class="img-star" alt="">
								<img src="img/icons/zvezda_full.png" class="img-star" alt="">
								<img src="img/icons/zvezda.png" class="img-star" alt="">
							</div>	
						<%
							} else if(average>=50&&average<75){
						%>
						   <div class="col-md-5 ">
							   <img src="img/icons/zvezda_full.png" class="img-star" alt="">
							   <img src="img/icons/zvezda.png" class="img-star" alt="">
							   <img src="img/icons/zvezda.png" class="img-star" alt="">
						   </div>		
						<%
							}else{
						%>
						   <div class="col-md-5 ">
							   <img src="img/icons/zvezda.png" class="img-star" alt="">
							   <img src="img/icons/zvezda.png" class="img-star" alt="">
							   <img src="img/icons/zvezda.png" class="img-star" alt="">
						   </div>	
						<%
							}
						%>		  
					  </div>
		            </div>
		     </div>
			<%if((i+1)%4 == 0){%>
			</div>
			<%}
			i++;
		} %>
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