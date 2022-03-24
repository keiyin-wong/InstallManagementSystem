package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import model.InstallType;
import model.Product;
import model.ProductDetail;

public class ProductDAO {
	JdbcTemplate template;
	
	public void setTemplate(JdbcTemplate template) {    
	    this.template = template;    
	}
	
	public Product getProduct(String productNum) {
		String qry = "SELECT * FROM product where product_number = " + productNum;
		
		 return template.queryForObject(qry, new RowMapper<Product>() {
			@Override
			public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
				Product p= new Product();
	        	List<ProductDetail> pdList = null;
	        	pdList = getProductDetailList(rs.getString("product_number"));
	        	p.setProductNumber(rs.getString("product_number"));
	        	p.setDate(rs.getDate("date").toLocalDate());
	        	p.setProductDetail(pdList);
	            return p;
			}});
	}

	public List<ProductDetail> getProductDetailList(String productNumber){
		String qry = "SELECT "
				+ "pd.product_number, "
				+ "p.date, "
				+ "pd.type, "
				+ "pd.product_line_number, "
				+ "it.desc_chinese, "
				+ "it.desc_english, "
				+ "pd.width, "
				+ "pd.height, "
				+ "it.diff_price, "
				+ "(CASE WHEN it.diff_price = 1 THEN itdf.price WHEN it.diff_price = 0 THEN it.price END) AS price "
				+ "FROM `product` p "
				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
				+ "JOIN `installation_type` it ON pd.type = it.id "
				+ "LEFT JOIN `installation_type_diff_fees` itdf ON itdf.type = it.id "
				+ "WHERE (p.product_number = "+productNumber+") AND ( "
				+ "(it.diff_price = 1) AND (itdf.size = ROUND(pd.height, -2)) OR it.diff_price = 0)";
		
		return template.query(qry,new RowMapper<ProductDetail>(){    
	        public ProductDetail mapRow(ResultSet rs, int row) throws SQLException {
	        	ProductDetail pd= new ProductDetail();
	        	InstallType it = new InstallType();
	        	pd.setProductNumber(rs.getString("product_number"));
	        	pd.setProductLineNumber(rs.getInt("product_line_number"));
	        	pd.setHeight(rs.getDouble("height"));
	            pd.setWidth(rs.getDouble("width"));
	            
	            it.setId(rs.getInt("type"));
	            it.setDesc_eng(rs.getString("desc_english"));
	            it.setDesc_chinese(rs.getString("desc_chinese"));
	            it.setDiff_price(rs.getBoolean("diff_price"));
	            it.setPrice(rs.getDouble("price"));
	            pd.setType(it);
   
	            return pd;    
	        }    
	    });
	}
	
	
	public List<Product> getProductList(){
		String qry = "SELECT * FROM product";
	    return template.query(qry,new RowMapper<Product>(){    
	        public Product mapRow(ResultSet rs, int row) throws SQLException {    
	        	Product p= new Product();
	        	List<ProductDetail> pdList = null;
	        	pdList = getProductDetailList(rs.getString("product_number"));
	        	p.setProductNumber(rs.getString("product_number"));
	        	p.setDate(rs.getDate("date").toLocalDate());
	        	p.setProductDetail(pdList);
	            return p;    
	        }    
	    });    
	}
}
