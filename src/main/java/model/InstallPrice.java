package model;

public class InstallPrice {
	String desc_eng;
	String desc_chinese;
	boolean diff_price;
	double price;
	
	
	public String getDesc_eng() {
		return desc_eng;
	}
	public void setDesc_eng(String desc_eng) {
		this.desc_eng = desc_eng;
	}
	public String getDesc_chinese() {
		return desc_chinese;
	}
	public void setDesc_chinese(String desc_chinese) {
		this.desc_chinese = desc_chinese;
	}
	public boolean isDiff_price() {
		return diff_price;
	}
	public void setDiff_price(boolean diff_price) {
		this.diff_price = diff_price;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
}
