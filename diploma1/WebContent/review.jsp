<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<div class="" style="margin-top: 50px;">
	<h1 class="text-center">Написать отзыв</h1>
</div>

<div class="hr-img">
    <img src="img/hr.png" style="width: 75px;" class="img-centre" alt="">
</div>
        <h3 class="text-center" style="color:#808080;">
          Вы можете написать свой отзыв о нашем сайте здесь! <br>
          Также, если у Вас есть жалобы на работу сайта, или есть предложения <br>
          для улучшения сайта, то Вы можете написать их здесь.<br>
        </h3>
<br>
<% 

String message=null;
	if(request.getParameter("message")!=null){
		message="Ваш отзыв отправлен. Спасибо!";
%>
<div class="" >
	<h3 class="text-center"><font color="green"><%=message %></font></h3>
</div>
<% } %>
<br>
<div class="reg" >

<form class="form-horizontal" id="reviewForm" method="POST" action="ReviewServlet">
	<div class="row">
	<div class="col-sm-8 col-sm-offset-2">
	  <div class="form-group">
	    <div class="">
	      <input type="text" class="form-control reviewTitle" id="reviewTitle" name="reviewTitle" placeholder="Введите тему">
	    </div>
	  </div>
	    <div class="form-group ">
	    <div class="">
	      <textarea class="form-control reviewText" id="reviewText" name="reviewText" placeholder="Введите ваш отзыв, жалобы, пожелания или предложения"></textarea>
	    </div>
	  </div>
	  <br />
	  <div class="form-group">
	    <div class="text-center">
	    	<input type="submit" class="btn btn-yellow " value="Готово" style="margin-right: 10px;">
	      	<input type="reset" class="btn btn-default " value="Очистить отзыв">
	    </div>
	  </div>
	 </div>
  </div>
</form>
</div>