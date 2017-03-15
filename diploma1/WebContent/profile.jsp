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
        <%  String userID = (String) session.getAttribute("userId");
        	String studentEmail = (String) session.getAttribute("userEmail");
        	String studentFirstName = (String) session.getAttribute("userFirstName");
			String studentLastName = (String) session.getAttribute("userLastName");
			String schoolID = (String) session.getAttribute("studentSchoolId");
			String studentClass = (String) session.getAttribute("studentClass");
        	String sql = "select * from schools where school_id="+schoolID; 
        	PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			String schoolName = null;
			String schoolCity = null;
			if (rs.next()){
				schoolName = rs.getString(2);
				schoolCity = rs.getString(3);
			}
			%>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
        </div>
        <div class="profile">
          <div class="row">
            <div class="col-md-5" style="padding-left: 0px;">
              <img src="img/zamok.png" class="img-responsive" alt="" style="width:350px;">
            </div>
            <div class="col-md-7">
            	<div class="profile-block">
              <h1><%=studentLastName%> <%=studentFirstName%></h1>
              <div class="row">
              	<div class="col-md-8"><p>
              	<i class="glyphicon glyphicon-envelope"></i> <%=studentEmail%><br>
              	<i class="glyphicon glyphicon-map-marker"></i> 
              	<%  if (schoolCity.equals("Алматы") || schoolCity.equals("Астана")){ %>
              			г. <%=schoolCity%> <% } 
              		else {%> 
              			<%=schoolCity%> область
              	<%  } %>
              	| №<%=schoolName%> школа | <%=studentClass%> класс<br>        	
              </p>
              </div>
              	<div class="col-md-4">	<p class="text-right"><a href="?navPage=edit_profile"><i class="glyphicon glyphicon-pencil"></i> Редактировать</a><br/><a href="?navPage=delete_profile" style="color:red;"><i class="glyphicon glyphicon-trash"></i> Удалить Профиль</a></p>
              </div>
              
              </div>
              </div>
             <% String sqlProgress = null;
             	PreparedStatement psProgress;
             	ResultSet rsProgress;
             	if (studentClass.equals("1")){
             		sqlProgress = "SELECT * FROM user_topic where user_id='"+session.getAttribute("userId")+"' and (topic_id >=1 and topic_id<9)";
             	}
             	else if (studentClass.equals("2")){
             		sqlProgress = "SELECT * FROM user_topic where user_id='"+session.getAttribute("userId")+"' and (topic_id >=9 and topic_id<17)";
				}
             	else if (studentClass.equals("3")){
             		sqlProgress = "SELECT * FROM user_topic where user_id='"+session.getAttribute("userId")+"' and (topic_id >=17 and topic_id<25)";
				}
             	else if (studentClass.equals("4")){
             		sqlProgress = "SELECT * FROM user_topic where user_id='"+session.getAttribute("userId")+"' and (topic_id >=25)";
				}
             	psProgress = con.prepareStatement(sqlProgress);
             	rsProgress = psProgress.executeQuery();
             	double averageProgress = 0.0;
             	while (rsProgress.next()){
             		averageProgress+=(rsProgress.getDouble("one")+rsProgress.getDouble("two")+rsProgress.getDouble("three")
							+rsProgress.getDouble("four")+rsProgress.getDouble("five")+rsProgress.getDouble("six"))/6;
             	}
             	int myTrainingProgress = (int) ((averageProgress/8 * 75)/100);
             	int myTestScore = 0;
             	String sqlTestScore = "select score from test where user_id='"+session.getAttribute("userId")+"' and grade='"+studentClass+"'";
             	PreparedStatement psTestScore = con.prepareStatement(sqlTestScore);
				ResultSet rsTestScore = psTestScore.executeQuery();
				if (rsTestScore.next()){
					myTestScore = (int) ((rsTestScore.getDouble(1)*25)/100);
				}
              %>
              	<h3>Успеваемость:</h3>
		        <div class="progress-holder">
		          <div class="percent">
		            <%=(myTrainingProgress+myTestScore)%>%
		          </div>
		          <div class="progress">
		            <div class="progress-bar" role="progressbar" aria-valuenow="<%=(myTrainingProgress+myTestScore)%>%" aria-valuemin="0" aria-valuemax="100" style="width: <%=(myTrainingProgress+myTestScore)%>%;">
		              <span class="sr-only">60%</span>
		            </div>
		          </div>
		          <div class="clear"></div>
		        </div>
		        <br>
		        
		        <%  String sqlAll = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
		       				+" where ut.user_id='"+session.getAttribute("userId")+"' AND (one AND two AND three AND four AND five AND six) > 0";
					PreparedStatement psAll = con.prepareStatement(sqlAll);
					ResultSet rsAll = psAll.executeQuery();
					int numberOfTheme = 2;
					if (rsAll.next()){%>
						<h3>Изучено:</h3>
						<ul class="learnt">
						<li><a href="?navPage=trainings&topic_id=<%=rsAll.getLong("topic_id")%>">Урок 1. <%=rsAll.getString("topic_name")%>
							<%  double average=(rsAll.getDouble("one")+rsAll.getDouble("two")+rsAll.getDouble("three")
										+rsAll.getDouble("four")+rsAll.getDouble("five")+rsAll.getDouble("six"))/6;
								if(average==100){ %>
			        			<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
								</div>
								<%
								} else if(average>=75&&average<100){
								%>
								<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>	
								<%
								} else if(average>=50&&average<75){
								%>
								<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>
								<%
								}else{
								%>
								<div class="stars">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>
								<% } %>
			        		</a></li>
					<%	while (rsAll.next()){ %>
							<li><a href="?navPage=trainings&topic_id=<%=rsAll.getLong("topic_id")%>">Урок <%=numberOfTheme%>. <%=rsAll.getString("topic_name")%>
							<%  double average2=(rsAll.getDouble("one")+rsAll.getDouble("two")+rsAll.getDouble("three")
										+rsAll.getDouble("four")+rsAll.getDouble("five")+rsAll.getDouble("six"))/6;
								if(average2==100){ %>
			        			<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
								</div>
								<%
								} else if(average2>=75&&average<100){
								%>
								<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>	
								<%
								} else if(average2>=50&&average<75){
								%>
								<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>
								<%
								}else{
								%>
								<div class="stars">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>
								<% } %>
			        		</a></li>
						<% numberOfTheme++;
						}
					%>
				</ul>
				<% 	} 
					else { %>
					<h3>К сожалению, ты еще не прошел ни один урок!</h3>
					<% } %>

            </div>
          </div>
        </div>
        
      </section>
      
    </div>
    