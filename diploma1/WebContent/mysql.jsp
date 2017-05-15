<%@page import="java.sql.Connection"%>
<%@page import="main.DBConnection"%>
<%
 final Connection con = (new DBConnection()).getConnection();
%>