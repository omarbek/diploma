<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<div class="container" id="content">
	<section id="main">
    <div class="row">
    	<div class="col-md-8 col-md-offset-2">
    		<div class="delete_area text-center">
    		<form method="POST" action="DeleteEditProfileServlet">
    		<input type="hidden" name="function_type" value="deleteProfile">
    			<h2>Вы действительно хотите удалить свой профиль?</h2>
    			<input type="submit" class="btn-danger btn" name="deleteProfile" value="Да" style="font-size: 18px;">
    			<% String userStatus = (String)session.getAttribute("userStatus");
     			if(userStatus.equals("1")){%>
     				<a class="btn-default btn" href="?navPage=profile" style="font-size: 18px;">Нет</a>
    			<% } else if (userStatus.equals("3")) {%>
     				<a class="btn-default btn" href="?navPage=profileTeacher" style="font-size: 18px;">Нет</a>
     			<%}%>
    		</form>
    		</div>
    	</div>
    </div> 
    </section>
</div>