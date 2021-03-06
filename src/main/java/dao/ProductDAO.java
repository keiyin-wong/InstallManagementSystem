package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
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
		
		//return (Double) template.queryForObject(qry, Double.class);
		
		return template.queryForObject(qry, new RowMapper<Double>() {
			@Override
			public Double mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				return Double.valueOf(rs.getDouble(1));
			}
			
		});
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
	        	if(rs.getDate("date")!=null) {
	        		p.setDate(rs.getDate("date").toLocalDate());
	        	}
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
				+ "pd.desc, "
				+ "pd.quantity, "
				+ "it.diff_price, "
				+ "it.is_direct_price "
				+ "FROM `product` p "
				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
				+ "JOIN `installation_type` it ON pd.type = it.id "
				+ "WHERE (p.product_number = "+productNum+") "
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
	            pd.setDescription(rs.getString("desc"));
	            pd.setQuantity(rs.getInt("quantity"));
	            
	            it.setId(rs.getInt("type"));
	            it.setDesc_eng(rs.getString("desc_english"));
	            it.setDesc_chinese(rs.getString("desc_chinese"));
	            it.setDiff_price(rs.getBoolean("diff_price"));
	            it.setPrice(0);
	            it.setDirectPrice(rs.getBoolean("is_direct_price"));
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
				+ "pd.desc, "
				+ "pd.quantity, "
				+ "pd.final_price, "
				+ "it.diff_price, "
				+ "it.is_direct_price "
				+ "FROM `product` p "
				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
				+ "JOIN `installation_type` it ON pd.type = it.id "
				+ "WHERE (p.product_number = "+productNumber+")"
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
	            pd.setDescription(rs.getString("desc"));
	            pd.setQuantity(rs.getInt("quantity"));
	            
	            it.setId(rs.getInt("type"));
	            it.setDesc_eng(rs.getString("desc_english"));
	            it.setDesc_chinese(rs.getString("desc_chinese"));
	            it.setDiff_price(rs.getBoolean("diff_price"));
	            it.setPrice(0);
	            it.setDirectPrice(rs.getBoolean("is_direct_price"));
	            pd.setType(it);
   
	            return pd;    
	        }    
	    });
	}
	
//	public List<ProductDetail> getProductDetailListLimit(String productNumber, int start, int limit ){
//		String qry = "SELECT * "
//				+ "FROM `product` p "
//				+ "JOIN `product_details` pd ON p.product_number = pd.product_number "
//				+ "JOIN `installation_type` it ON pd.type = it.id "
//				+ "WHERE p.product_number = '" + productNumber + "' "
//				+ "ORDER BY pd.product_line_number ASC "
//				+ "LIMIT " + start + ", " + limit;
//		
//		return template.query(qry,new RowMapper<ProductDetail>(){    
//	        public ProductDetail mapRow(ResultSet rs, int row) throws SQLException {
//	        	ProductDetail pd= new ProductDetail();
//	        	InstallType it = new InstallType();
//	        	pd.setProductNumber(rs.getString("product_number"));
//	        	pd.setProductLineNumber(rs.getInt("product_line_number"));
//	        	pd.setHeight(rs.getDouble("height"));
//	            pd.setWidth(rs.getDouble("width"));
//	            pd.setFinalPrice((rs.getDouble("final_price")));
//	            
//	            it.setId(rs.getInt("type"));
//	            it.setDesc_eng(rs.getString("desc_english"));
//	            it.setDesc_chinese(rs.getString("desc_chinese"));
//	            it.setDiff_price(rs.getBoolean("diff_price"));
//	            it.setPrice(rs.getDouble("price"));
//	            pd.setType(it);
//   
//	            return pd;    
//	        }    
//	    });
//	}
	
	
	public List<Product> getProductList(int start, int limit){
		String qry = "SELECT * "
				+ "FROM `product` p "
				+ "ORDER BY p.product_number DESC "
				+ "LIMIT " + start + ", " + limit;
	    return template.query(qry,new RowMapper<Product>(){    
	        public Product mapRow(ResultSet rs, int row) throws SQLException {    
	        	Product p= new Product();
	        	List<ProductDetail> pdList = null;
	        	pdList = getProductDetailList(rs.getString("product_number"));
	        	p.setProductNumber(rs.getString("product_number"));
	        	if(rs.getDate("date")!=null) {
	        		p.setDate(rs.getDate("date").toLocalDate());
	        	}
	        	p.setProductDetail(pdList);
	            return p;    
	        }    
	    });    
	}
	
	public Integer getProductTotalCount() {
		String qry = "SELECT COUNT(*) AS size FROM product";	
		
		return template.queryForObject(qry, new RowMapper<Integer>() {
			@Override
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				// TODO Auto-generated method stub
				return Integer.valueOf(rs.getInt(1));
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
	            it.setDirectPrice(rs.getBoolean("is_direct_price"));
	            return it;    
	        }    
	    });    
	}
	
	public int updateProductDetail(ProductDetail pd){    
	    String qry = "UPDATE `product_details` "
	    		+ "SET `type` = " + pd.getType().getId() +", `width` = "+pd.getWidth()+",`height` = "+pd.getHeight() 
	    		+ ",`final_price` = " + pd.getFinalPrice() + ",`desc` = '" + pd.getDescription() + "' " + ",`quantity`=" + pd.getQuantity()
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
	
	public int deleteProduct(String productNumber){    
	    String qry = "DELETE FROM `product` "
	    		+ "WHERE product_number = '" + productNumber + "'";
	    return template.update(qry);    
	}
	
	public int createProductDetail(String productNumber, int lineNumber, int type, double width, double height, double price, String description, int quantity){    
	    String qry = "INSERT INTO `product_details` VALUE ('"+productNumber+"',"+lineNumber+","+type+", "+width+", "+height+", "+ price + ", '" + description +"'," + quantity +")";
	    return template.update(qry);    
	}
	
	public int createProduct(String productNumber, String date) throws DuplicateKeyException{    
	    String qry = "INSERT INTO `product` VALUE ('" + productNumber + "', '" + date + "')";
	    return template.update(qry);    
	}
	
}
