<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mysql.jsp" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

    
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <% String qwerty = null;
	qwerty = request.getParameter("topic_id");
 %>

    <div class="container" id="content">
      

      <section id="main" class="trener">
      <h1 class="text-center">Тренировки</h1>
        
        <div class="hr-img">
          <img src="img/hr.png" style="width: 50px;" class="img-centre" alt="">
        </div>
        <br>
        <div class="row">
          <div class="col-md-10 col-md-offset-1">
            <div class="row">
              <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingOne&topic_id=<%=qwerty %>&questionId=0">
                    <img src="img/icons/5.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>Перевод с русского</h3>
                     <p class="text-center">
                       Дано слово на русском языке, нужно найти перевод на казахском
                    </p>
                  </a>
                </div>
              </div>
               <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingTwo&topic_id=<%=qwerty %>&questionId=0">
                    <img src="img/icons/6.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>Перевод с казахского</h3>
                     <p class="text-center">
                       Дано слово на казахском языке, нужно найти перевод на русском
                    </p>
                  </a>
                </div>
              </div>
               <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingThree&topic_id=<%=qwerty%>&questionId=0">
                    <img src="img/icons/7.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>Собрать слово из букв</h3>
                     <p class="text-center">
                       Нужно составить слово из данных букв
                    </p>
                  </a>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingFour&topic_id=<%=qwerty %>&questionId=0">
                    <img src="img/icons/8.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>4 картинки 1 слово</h3>
                     <p class="text-center">
                       Даны 4 картинки, нужно написать общее слово для этих картинок на казахском
                    </p>
                  </a>
                </div>
              </div>
               <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingFive&topic_id=<%=qwerty %>&questionId=0">
                    <img src="img/icons/9.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>Аудиозапись</h3>
                     <p class="text-center">
                       Нужно прослушать аудиозапись и найти перевод этого слова
                    </p>
                  </a>
                </div>
              </div>
               <div class="col-md-4">
                <div class="subject">
                  <a href="?navPage=trainingSix&topic_id=<%=qwerty %>&questionId=0">
                    <img src="img/icons/10.png" class="img-responsive img-centre" alt="">
                    <br>
                     <h3>Соответствие слов</h3>
                     <p class="text-center">
                       Нужно найти соответствующий перевод слова
                    </p>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        
      </section>
      
    </div>



 