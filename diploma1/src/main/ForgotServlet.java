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
		String message = password;
		try {
			PreparedStatement psSelect = con.prepareStatement("select * from users where email='" + email + "'");
			ResultSet rs = psSelect.executeQuery();
			if (!rs.next()) {
				message = "";
			} else {
				PreparedStatement ps = con.prepareStatement(
						"update users set password='" + shaPassword + "' where email='" + email + "'");
				ps.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("index.jsp?navPage=forgot&message=" + message);
		// sendEmail(email);
	}

	@SuppressWarnings("unused")
	private void sendEmail(String email) {
		// Recipient's email ID needs to be mentioned.
		String to = email;

		// Sender's email ID needs to be mentioned
		String from = "web@gmail.com";

		// Assuming you are sending email from localhost
		String host = "localhost";

		// Get system properties
		Properties properties = System.getProperties();

		// Setup mail server
		properties.setProperty("mail.smtp.host", host);

		// Get the default Session object.
		Session session = Session.getDefaultInstance(properties);

		try {
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));

			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// Set Subject: header field
			message.setSubject("This is the Subject Line!");

			// Now set the actual message
			message.setText("This is actual message");

			// Send message
			Transport.send(message);
			System.out.println("Sent message successfully....");
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
	}
}
