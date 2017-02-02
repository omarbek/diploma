package main;

public class Word {
	public int id;
	public String rus;
	public String kaz;

	public Word(int id, String rus, String kaz) {
		this.id = id;
		this.rus = rus;
		this.kaz = kaz;
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
}
