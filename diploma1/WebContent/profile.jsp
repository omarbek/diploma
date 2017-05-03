<%@page import="javax.swing.JOptionPane"%>
<% 
	session=request.getSession(false);
	if(session==null){
		session.invalidate();
	response.sendRedirect("index.jsp");
	}else{
%>
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
        	String sql = "select * from students where user_id="+userID;
        	String sql2 = "select * from users where user_id="+userID;
        	PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			PreparedStatement ps2 = con.prepareStatement(sql2);
			ResultSet rs2 = ps2.executeQuery();
			String schoolName = null;
			String schoolCity = null;
			String studentLastName = null;
			String studentFirstName = null;
			String studentEmail = null;
			String studentClass = null;
			String studentClassLetter = null;
			if (rs.next()){
				studentClass = rs.getString(3);
				studentFirstName = rs.getString(4);
				studentLastName = rs.getString(5);
				schoolName = rs.getString(6);
				schoolCity = rs.getString(7);
				studentClassLetter = rs.getString(8);
			}
			if (rs2.next()){
				studentEmail = rs2.getString(2);
			}
			
			String sqlImg = "SELECT * FROM topics t left join user_topic ut on ut.topic_id=t.topic_id"
       				+" where t.grade="+studentClass+" and ut.user_id="+userID;
			PreparedStatement psImg=con.prepareStatement(sqlImg);
			ResultSet rsImg=psImg.executeQuery();
			int sumOfStars=0;
			while(rsImg.next()){
				double average=(rsImg.getDouble("one")+rsImg.getDouble("two")+rsImg.getDouble("three")
					+rsImg.getDouble("four")+rsImg.getDouble("five")+rsImg.getDouble("six"))/6;
				if(average>=90){
					sumOfStars+=3;
				} else if(average>=75&&average<90){
					sumOfStars+=2;
				} else if(average>=50&&average<75){
					sumOfStars+=1;
				}
			}
			String img=studentClass+"-"+sumOfStars;
			%>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
        </div>
        <div class="profile">
          <div class="row">
            <div class="col-md-5" style="padding-left: 0px;">
              <img src="img/dragons/<%=img %>.png" class="img-responsive" alt="" style="width:350px;">
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
              	| №<%=schoolName%> школа | <%=studentClass%><%=studentClassLetter %> класс<br>        	
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
		       				+" where t.grade="+studentClass + " AND ut.user_id='"+session.getAttribute("userId")+"' AND (one AND two AND three AND four AND five AND six) > 0";
					PreparedStatement psAll = con.prepareStatement(sqlAll);
					ResultSet rsAll = psAll.executeQuery();
					int numberOfTheme = 1;
					boolean enterToLoop=false;
					%>
						<h3>Изучено:</h3>
						<ul class="learnt">
						
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
								} else if(average2>=75&&average2<100){
								%>
								<div class="stars">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda_full.png" class="img-star" alt="">
									<img src="img/icons/zvezda.png" class="img-star" alt="">
								</div>	
								<%
								} else if(average2>=50&&average2<75){
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
						enterToLoop=true;
						}
        
					%>
				</ul>
				<% 	if(!enterToLoop){
					 %>
					<h3>К сожалению, ты еще не прошел ни один урок!</h3>
					<% }
				}
        catch(Exception e){
        	JOptionPane.showMessageDialog(null, e.getLocalizedMessage());
        	e.printStackTrace();
        }%>

            </div>
          </div>
        </div>
        
      </section>
      
    </div>
<% } %>