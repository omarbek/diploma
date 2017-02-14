package main;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItemIterator;
import org.apache.tomcat.util.http.fileupload.FileItemStream;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		Connection con = (new DBConnection()).getConnection();

		String name = null;
		String classNumber = null;
		Long topicId = null;

		boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
		if (isMultiPart) {
			ServletFileUpload upload = new ServletFileUpload();
			try {
				FileItemIterator itr = upload.getItemIterator(request);

				while (itr.hasNext()) {
					FileItemStream item = itr.next();
					if (item.isFormField()) {
						String fieldName = item.getFieldName();
						InputStream is = item.openStream();
						byte[] b = new byte[is.available()];
						is.read(b);
						String value = new String(b);
						response.getWriter().println(fieldName + ":" + value + "<br/>");
						if (fieldName.equalsIgnoreCase("name")) {
							name = value;
						} else {
							classNumber = value;
						}
					} else {
						try {
							PreparedStatement insertPs = con
									.prepareStatement("INSERT INTO `topics` (topic_name,grade) values ('" + name + "', "
											+ classNumber + ")");
							insertPs.executeUpdate();

							PreparedStatement selectPs = con
									.prepareStatement("select topic_id from topics where topic_name='" + name
											+ "' and grade=" + classNumber);
							ResultSet rs = selectPs.executeQuery();
							if (rs.next()) {
								topicId = rs.getLong(1);
							}
						} catch (SQLException e) {
							e.printStackTrace();
						}

						String path = "C:/Users/Омарбек/git/kazakh/diploma1/WebContent";
						// String output =
						// item.getName().substring(item.getName().indexOf('.'),
						// item.getName().length());
						String nameOfImage = topicId + ".jpg";
						Word.processFile(path, item, nameOfImage);

						String grade = Word.getGrade(classNumber);
						response.sendRedirect("admin.jsp?navPage=a_topics&grade=" + grade + "&classId=4");
					}
				}
			} catch (FileUploadException e) {
				e.printStackTrace();
			}
		}
	}
}
