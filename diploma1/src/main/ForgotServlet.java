package main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Random;

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

import org.apache.commons.codec.digest.DigestUtils;

@WebServlet("/ForgotServlet")
public class ForgotServlet extends HttpServlet {
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
		Connection con = (new DBConnection()).getConnection();

		String email = request.getParameter("email");

		Random randomGenerator = new Random();
		int randomInt = randomGenerator.nextInt(100) + 100;
		String password = String.valueOf(randomInt);
		String shaPassword = DigestUtils.sha1Hex(password);
		String message = email;
		try {
			PreparedStatement psSelect = con.prepareStatement("select * from users where email='" + email + "'");
			ResultSet rs = psSelect.executeQuery();
			if (!rs.next()) {
				message = "";
			} else {
				PreparedStatement ps = con.prepareStatement(
						"update users set password='" + shaPassword + "' where email='" + email + "'");
				ps.executeUpdate();
				sendEmail(email, password);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("index.jsp?navPage=forgot&message=" + message);
	}

	private void sendEmail(String email, String text) {
		final String username = "speakkazakh@gmail.com";
		final String password = "SpKz2017";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("Восстановление пароля");
			message.setText("Ваш пароль изменен на " + text);

			Transport.send(message);

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
}
