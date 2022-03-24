package model;

public class ProductDetail {
	String productNumber;
	InstallType type;
	int productLineNumber;
	double width;
	double height;
	
	public String getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}
	
	public InstallType getType() {
		return type;
	}
	public void setType(InstallType type) {
		this.type = type;
	}
	public int getProductLineNumber() {
		return productLineNumber;
	}
	public void setProductLineNumber(int productLineNumber) {
		this.productLineNumber = productLineNumber;
	}
	public double getWidth() {
		return width;
	}
	public void setWidth(double width) {
		this.width = width;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
}
