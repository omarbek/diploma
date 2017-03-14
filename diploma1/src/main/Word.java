package main;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import org.apache.tomcat.util.http.fileupload.FileItemStream;

public class Word {
	public int id;
	public String rus;
	public String kaz;

	public Word(int id, String rus, String kaz) {
		this.id = id;
		this.rus = rus;
		this.kaz = kaz;
	}

	public static String getGrade(String classNumber) {
		String grade = null;
		if ("1".equals(classNumber)) {
			grade = "one";
		} else if ("2".equals(classNumber)) {
			grade = "two";
		} else if ("3".equals(classNumber)) {
			grade = "three";
		} else {
			grade = "four";
		}
		return grade;
	}

	public static double round(double value, int places) {
		if (places < 0) {
			throw new IllegalArgumentException();
		}

		long factor = (long) Math.pow(10, places);
		value = value * factor;
		long tmp = Math.round(value);
		return (double) tmp / factor;
	}

	public static boolean processFile(String path, FileItemStream item, String nameOfImage, String folder) {
		try {
			File f = new File(path + File.separator + folder);
			if (!f.exists()) {
				f.mkdir();
			}
			File savedFile = new File(f.getAbsolutePath() + File.separator + nameOfImage);
			FileOutputStream fos = new FileOutputStream(savedFile);
			InputStream is = item.openStream();
			int x = 0;
			byte[] b = new byte[1024];
			while ((x = is.read(b)) != -1) {
				fos.write(b, 0, x);
			}
			fos.flush();
			fos.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
