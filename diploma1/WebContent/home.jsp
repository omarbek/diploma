<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>


<div id="slider" class="row">
        <ul class="bxslider">
          <li><img src="img/slider/1.jpg" /></li>
          <li><img src="img/slider/2.jpg" /></li>
        </ul>
      </div>
      <section id="main">
      <div class="row">
	      
	      <div class="col-sm-6 col-sm-offset-1" style="margin-top:25px">
	        <h1 class="text-center">
	        <%  if(session.getAttribute("userStatus").equals("1")){
					String userID = (String) session.getAttribute("userId");
					String sql = "select first_name from students where user_id="+userID;
					PreparedStatement ps = con.prepareStatement(sql);
					ResultSet rs = ps.executeQuery();
					if(rs.next()){%>
						Добро пожаловать, <%=rs.getString(1)%>!
				<%	}
				}
	        	else {%>
	        		Добро пожаловать!
	        <%	}%>         
	        </h1>
	        <p class="sp text-center">SpeakKaзakh - это интересный и увлекательный способ изучить казахский язык. <br> Здесь ты будешь учить все самое нужное и необходимое для понимания и освоения основ казахской речи.<br> Чем больше слов ты изучишь, тем больше станет твой дракон!</p>
	      </div>
	      <div class="col-sm-4  ">
	      <img class="img-responsive img-centre" src="img/dragon.png" style="width:300px">
	      </div>
      </div> 
      <div class="row" id="prem">
        <div class="col-sm-3">
          <img class="img-responsive img-centre" src="img/icons/1.png">
          <h3 class="text-center">Основа основ</h3>
          <p class="text-center home-text">Ты будешь изучать самые популярные слова, которые помогут составить базу в освоении языка</p>
        </div>
        <div class="col-sm-3">
          <img class="img-responsive img-centre" src="img/icons/2.png">
          <h3 class="text-center">Очки за достижения</h3>
          <p class="text-center home-text">За правильные ответы тебя ждут баллы и звезды, которые помогут твоему дракону вырасти</p>
        </div>
         <div class="col-sm-3">
          <img class="img-responsive img-centre" src="img/icons/3.png">
          <h3 class="text-center">Тренировки</h3>
          <p class="text-center home-text">Разнообразие тренировок не дадут тебе скучать</p>
        </div>
        <div class="col-sm-3">
          <img class="img-responsive img-centre" src="img/icons/4.png">
          <h3 class="text-center">Проверь себя</h3>
          <p class="text-center home-text">После того, как заработаешь все звезды, ты сможешь проверить свои знания</p>
        </div>
      </div>
      </section>