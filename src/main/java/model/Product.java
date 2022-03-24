package model;

import java.time.LocalDate;
import java.util.List;


public class Product {
	String productNumber;
	LocalDate date;
	List<ProductDetail> productDetail;
	
	public String getProductNumber() {
		return productNumber;
	}
	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}
	public LocalDate getDate() {
		return date;
	}
	public void setDate(LocalDate date) {
		this.date = date;
	}
	public List<ProductDetail> getProductDetail() {
		return productDetail;
	}
	public void setProductDetail(List<ProductDetail> productDetail) {
		this.productDetail = productDetail;
	}
	
}
