package main;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String reviewTitle = request.getParameter("reviewTitle");
		String reviewText = request.getParameter("reviewText");
		HttpSession session = request.getSession();
		String userEmail = (String) session.getAttribute("userEmail");
		String text = "Вы получили отзыв от пользователя. Электронный адрес пользователя: " + userEmail
				+ "\n\n Отзыв: \n\n";
		String msg = "sent";
		final String username = "speakkazakh@gmail.com";
		final String password = "SpKz2017";
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session1 = Session.getInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session1);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(username));
			message.setSubject(reviewTitle);
			message.setText(text + reviewText);

			Transport.send(message);

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}

		response.sendRedirect("index.jsp?navPage=review&message=" + msg);
	}
}
