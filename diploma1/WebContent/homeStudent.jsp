<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<div class="container">
<h2>Уроки</h2>
<%
String sql = "SELECT * FROM topics where topic_id<10";
PreparedStatement prepStmt = con.prepareStatement(sql);
ResultSet rs = prepStmt.executeQuery();
int i=0;
while(rs.next()){
	if(i%3 == 0){%>
	<div class="row">
  	<%}%>
  	    <div class="col-sm-3 well" style="background-color:pink;" align="center">
		    <a href="?navPage=trainings&topic_id=<%=rs.getString(1)%>"><%=rs.getString(2) %></a>
	   	</div>
	<%if((i+1)%3 == 0){%>
	</div>
	<%}
	i++;
}
%>
</div>