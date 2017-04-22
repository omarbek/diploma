<%@page import="com.mysql.jdbc.exceptions.MySQLNonTransientConnectionException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
<h2>Уроки</h2>
 
<%
try{
String sql = "SELECT * FROM classes";
PreparedStatement prepStmt = con.prepareStatement(sql);
ResultSet rs = prepStmt.executeQuery();

int i=0;
while(rs.next()){
	if(i%3 == 0){%>
		<div class="container-fluid center" align=center>
  			<div class="row">
  	<%}%>
  	<div class="col-sm-3 well" style="background-color:pink;">
		<p><%=rs.getString(3) %></p>
	   	</div>
	<%if((i+1)%3 == 0){%>
			</div>
		</div>
	<%}
}
}
catch(MySQLNonTransientConnectionException e){
}
%>
