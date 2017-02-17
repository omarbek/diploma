<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<div class="container" id="content">
      <section id="main">
        <h1 class="text-center">
          Мой словарь
        </h1>
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <h3 class="text-center">
          На этой странице находятся все слова, которые Вы изучили. <br>
          Вы можете в любой момент зайти сюда и повторить их, чтобы не забыть!
        </h3>
        <div class="dictionary table-responsive">
          <table class="table table-bordered">
            <thead>
              <th>
                №
              </th>
              <th>
                На казахском
              </th>
              <th>
                На русском
              </th>
              <th>
                Тема
              </th>
            </thead>
            <tbody>
            <%  String userId = (String)session.getAttribute("userId");
            	String studentId = (String)session.getAttribute("studentID");
           		ResultSet rs1, rs2, rs3, rs4;
                String sql1 = "SELECT topic_id FROM user_topic WHERE user_id='"+userId+"' AND (one AND two AND three AND four AND five AND six) > 0"; 
                String sql2 = null;
                String sql3 = null;
                String sql4 = null;
                PreparedStatement prepStmt1 = con.prepareStatement(sql1);
                rs1 = prepStmt1.executeQuery();
                ArrayList <String> wordID = new ArrayList <String>();
                ArrayList <String> topicID = new ArrayList <String>();
                int i=1;
                while (rs1.next()){
                	topicID.add(rs1.getString(1));
                	sql2 = "select topic_word.word_id from topic_word where topic_word.topic_id='"+rs1.getString(1)+"' and topic_word.word_id not in ( select results.word_id from results where results.student_id='"+studentId+"')";
                	PreparedStatement prepStmt2 = con.prepareStatement(sql2);
                	rs2 = prepStmt2.executeQuery();
                	sql4 = "select topic_name from topics where topic_id='"+rs1.getString(1)+"'";
                	PreparedStatement prepStmt4 = con.prepareStatement(sql4);
                	rs4 = prepStmt4.executeQuery();
                	if (rs4.next()){
	                	while (rs2.next()){
	                		//wordID.add(rs2.getString(1));
	                		%>
	                		<tr><td><%=i%></td>
	                		<% sql3 = "select * from words where word_id='"+rs2.getString(1)+"'";
	                		PreparedStatement prepStmt3 = con.prepareStatement(sql3);
	                		rs3 = prepStmt3.executeQuery(); 
	                		if (rs3.next()){%>
		                		<td><%=rs3.getString(3)%></td>
		                		<td><%=rs3.getString(2)%></td>
		                		 <%                		 
	                		}
	                		%>
	                			<td><%=rs4.getString(1)%></td></tr>
	                		<% 	
	                		i++;
                		}        		
                	} 
                }                              
               %>
         
            </tbody>
          </table>
        </div>
        
      </section>
      
    </div>
    