<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>

<%  int class_letter_number = Integer.parseInt(request.getParameter("class_letter"));
	int student_grade = Integer.parseInt(request.getParameter("student_grade"));
	String clsas_letter = null;
	switch (class_letter_number){
	case 1: clsas_letter="А";
			break;
	case 2: clsas_letter="Б";
			break;
	case 3: clsas_letter="В";
			break;
	case 4: clsas_letter="Г";
			break;
	case 5: clsas_letter="Д";
			break;
	case 6: clsas_letter="Ж";
			break;
	}%>

<div class="container" id="content">
      <section id="main">
        <h1 class="text-center">
          Успеваемость учеников <%=student_grade%><%=clsas_letter%> класса
        </h1>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <%  
        try{
        	String userId = (String)session.getAttribute("userId");
	    	String teacher_id = (String)session.getAttribute("teacherID");
	    	String sqlFindSchool = "SELECT school_name, city FROM teachers where teacher_id="+teacher_id;
	    	PreparedStatement prepStmt1 = con.prepareStatement(sqlFindSchool);
	    	ResultSet rs1 = prepStmt1.executeQuery();
	    	if (rs1.next()){
	    		String sqlFindStudents = "SELECT * from students where school_name="+rs1.getInt(1)+" and city='"+rs1.getString(2)
	    				+"' and studentClass="+student_grade+" and classLetter='"+clsas_letter+"' ORDER BY last_name ASC";
	    		PreparedStatement prepStmt2 = con.prepareStatement(sqlFindStudents);
		    	ResultSet rs2 = prepStmt2.executeQuery();
		    	int i=1; 
		        boolean enterToLoop=false;
		    	while (rs2.next()){
                	if (i==1){%>
                	<div class="dictionary table-responsive">
			          <table class="table table-bordered">
			            <thead>
			            <tr>
			              <th style="text-align: center">
			                №
			              </th>
			              <th>
			                Имя ученика
			              </th>
			              <th style="text-align: center">
			                Тема 1
			              </th>
			              <th style="text-align: center">
			                Тема 2
			              </th>
			              <th style="text-align: center">
			                Тема 3
			              </th>
			              <th style="text-align: center">
			                Тема 4
			              </th>
			              <th style="text-align: center">
			                Тема 5
			              </th>
			              <th style="text-align: center">
			                Тема 6
			              </th>
			              <th style="text-align: center">
			                Тема 7
			              </th>
			              <th style="text-align: center">
			                Тема 8
			              </th>
			              <th style="text-align: center">
			                Проверь себя
			              </th>
			              <th style="text-align: center">
			                Общая
			              </th>
			              </tr>
			              </thead>
			            <tbody>
			          
                	<%}
                		int student_user_id = rs2.getInt(2);
                		int student_id = rs2.getInt(1);
                		String sqlFindUserTopic = "";
                		int lastMark = 0;
                		int trainMark = 0;
                		int testMark = 0;
                		if(student_grade==1){
                			sqlFindUserTopic = "select (one+two+three+four+five+six)/6 from user_topic where user_id="+student_user_id+" and topic_id<9";
                		}
                		else if(student_grade==2){
                			sqlFindUserTopic = "select (one+two+three+four+five+six)/6 from user_topic where user_id="+student_user_id+" and topic_id>8 and topic_id<17";
                		}
                		else if(student_grade==3){
                			sqlFindUserTopic = "select (one+two+three+four+five+six)/6 from user_topic where user_id="+student_user_id+" and topic_id>16 and topic_id<25";
                		}
                		else {
                			sqlFindUserTopic = "select (one+two+three+four+five+six)/6 from user_topic where user_id="+student_user_id+" and topic_id>24";
                		}
                		String sqlFindTest = "select score from test where user_id="+student_user_id+" and grade="+student_grade;
                		PreparedStatement prepStmtFindUserTopic = con.prepareStatement(sqlFindUserTopic);
            	    	ResultSet rsFindUserTopic = prepStmtFindUserTopic.executeQuery();
                	%>
                	<tr>
                	<td align="center"><%=i%></td>
                	<td><%=rs2.getString(5)%> <%=rs2.getString(4)%></td>
                	<% while(rsFindUserTopic.next()){
                				trainMark = rsFindUserTopic.getInt(1);
                				lastMark += trainMark;%>
                			<td align="center"><%=trainMark%></td>
                	<%	}
	                	PreparedStatement prepStmtFindTest = con.prepareStatement(sqlFindTest);
	        	    	ResultSet rsFindTest = prepStmtFindTest.executeQuery();
	        	    	lastMark = (lastMark/8 * 75)/100;
	        	    	if(rsFindTest.next()){
	        	    			testMark = rsFindTest.getInt(1);%>
	        	    		<td align="center"><%=testMark%></td>
	        	    <%	}
	        	    	testMark = (testMark*25)/100;
	        	    	lastMark = lastMark+testMark;
                	%>
                		<td align="center">
                		<%=lastMark%>
                		</td>
                		
                	</tr>
		    <% enterToLoop = true;
		    i++;
		    }
		    	if (enterToLoop){%>                              
                </tbody>
		          </table>
		        </div>
		        <% }
                else if (!enterToLoop){ %>
		        	<h3 class="text-center">
			          К сожалению, в этом классе пока нет учеников. </h3>
	       <%  }
			 }                            

        }
        catch(MySQLNonTransientConnectionException e){
        }
 %>
      </section>
      
    </div>
    