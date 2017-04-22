<%@page import="main.DBConnection"%>
<%@page import="java.sql.Connection"%>
<%
 final Connection con = (new DBConnection()).getConnection();
%>