package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DuplicateKeyException;
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
	
	public Double getInstallTypeDiffPrice(int type, double height) {
		String qry = "SELECT price FROM `installation_type_diff_fees` "
				+ "WHERE size = TRUNCATE(" + height + ", -2) AND `type` = " + type;
		
		return (Double) template.queryForObject(qry, Double.class);
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
	
	public ProductDetail getProductDetail(String productNum, int lineNum) {
		String qry = "SELECT "
				+ "pd.product_number, "
				+ "p.date, "
				+ "pd.type, "
				+ "pd.product_line_number, "
				+ "it.desc_chinese, "
				+ "it.desc_english, "
				+ "pd.width, "
				+ "pd.height, "
				+ "pd.final_price, "
				+ "it.diff_price, "
				+ "(CASE WHEN it.diff_price = 1 THEN itdf.price WHEN it.diff_price = 0 THEN it.price END) AS price "
				+ "FROM `product` p "
				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
				+ "JOIN `installation_type` it ON pd.type = it.id "
				+ "LEFT JOIN `installation_type_diff_fees` itdf ON itdf.type = it.id "
				+ "WHERE (p.product_number = "+productNum+") "
				+ "AND ((it.diff_price = 1) AND (itdf.size = TRUNCATE(pd.height, -2)) OR it.diff_price = 0) "
				+ "AND (pd.product_line_number = " + lineNum + ")"
				+ "ORDER BY pd.product_line_number ASC";
		
		return template.queryForObject(qry,new RowMapper<ProductDetail>(){    
	        public ProductDetail mapRow(ResultSet rs, int row) throws SQLException {
	        	ProductDetail pd= new ProductDetail();
	        	InstallType it = new InstallType();
	        	pd.setProductNumber(rs.getString("product_number"));
	        	pd.setProductLineNumber(rs.getInt("product_line_number"));
	        	pd.setHeight(rs.getDouble("height"));
	            pd.setWidth(rs.getDouble("width"));
	            pd.setFinalPrice((rs.getDouble("final_price")));
	            
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
				+ "pd.final_price, "
				+ "it.diff_price, "
				+ "(CASE WHEN it.diff_price = 1 THEN itdf.price WHEN it.diff_price = 0 THEN it.price END) AS price "
				+ "FROM `product` p "
				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
				+ "JOIN `installation_type` it ON pd.type = it.id "
				+ "LEFT JOIN `installation_type_diff_fees` itdf ON itdf.type = it.id "
				+ "WHERE (p.product_number = "+productNumber+") AND ( "
				+ "(it.diff_price = 1) AND (itdf.size = TRUNCATE(pd.height, -2)) OR it.diff_price = 0) "
				+ "ORDER BY pd.product_line_number ASC";
		
		return template.query(qry,new RowMapper<ProductDetail>(){    
	        public ProductDetail mapRow(ResultSet rs, int row) throws SQLException {
	        	ProductDetail pd= new ProductDetail();
	        	InstallType it = new InstallType();
	        	pd.setProductNumber(rs.getString("product_number"));
	        	pd.setProductLineNumber(rs.getInt("product_line_number"));
	        	pd.setHeight(rs.getDouble("height"));
	            pd.setWidth(rs.getDouble("width"));
	            pd.setFinalPrice((rs.getDouble("final_price")));
	            
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
	
	public List<InstallType> getInstallTypeList(){
		String qry = "SELECT * FROM `installation_type`";
	    return template.query(qry,new RowMapper<InstallType>(){    
	        public InstallType mapRow(ResultSet rs, int row) throws SQLException {    
	        	InstallType it= new InstallType();
	        	it.setId(rs.getInt("id"));
	        	it.setDesc_eng(rs.getString("desc_english"));
	            it.setDesc_chinese(rs.getString("desc_chinese"));
	            it.setDiff_price(rs.getBoolean("diff_price"));
	            it.setPrice(rs.getDouble("price"));
	            return it;    
	        }    
	    });    
	}
	
	public int updateProductDetail(ProductDetail pd){    
	    String qry = "UPDATE `product_details` "
	    		+ "SET `type` = " + pd.getType().getId() +", `width` = "+pd.getWidth()+",`height` = "+pd.getHeight() + ",`final_price` = " + pd.getFinalPrice()
	    		+ " WHERE product_number='"+pd.getProductNumber()+"' AND product_line_number="+pd.getProductLineNumber();
	    return template.update(qry);    
	}
	
	public int deleteProductDetail(String productNumber, int lineNumber){    
	    String qry = "DELETE FROM `product_details` "
	    		+ "WHERE product_number = '" + productNumber + "' AND product_line_number = " + lineNumber;
	    return template.update(qry);    
	}
	
	public int updateProduct(String productNumber, String date){    
	    String qry = "UPDATE `product` "
	    		+ "SET `date`='"+date+"'"
	    		+ " WHERE product_number='"+productNumber+"'";
	    return template.update(qry);    
	}
	
	public int createProductDetail(String productNumber, int lineNumber, int type, double width, double height, double price){    
	    String qry = "INSERT INTO `product_details` VALUE ('"+productNumber+"',"+lineNumber+","+type+", "+width+", "+height+", "+ price +")";
	    return template.update(qry);    
	}
	
	public int createProduct(String productNumber, String date) throws DuplicateKeyException{    
	    String qry = "INSERT INTO `product` VALUE ('" + productNumber + "', '" + date + "')";
	    return template.update(qry);    
	}
	
}
