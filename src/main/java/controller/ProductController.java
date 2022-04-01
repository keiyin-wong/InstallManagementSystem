package controller;
 
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.jasperreports.JasperReportsMultiFormatView;

import dao.ProductDAO;
import model.InstallType;
import model.Product;
import model.ProductDetail;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
 
@Controller
@RequestMapping(value = "/product")

public class ProductController {
	@Autowired
	ProductDAO productDAO;
	
	@Autowired
	DriverManagerDataSource ds;
	
 
	@RequestMapping(value = "/product.html", method = RequestMethod.POST)
	public ModelAndView showMessage(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("in controller");
		HttpSession session=request.getSession();  
		 if(session!=null){  
			 ModelAndView mv = new ModelAndView("product");
			return mv;
		 }else {
			 return new ModelAndView("login");
		 }
	}
	
	@RequestMapping(value = "/productDetail.html", method = RequestMethod.GET)
	public ModelAndView showDetailMessage(@RequestParam String productNumber) {
		System.out.println("showing detail message");
 
		ModelAndView mv = new ModelAndView("product-detail");
		return mv;
	}
	
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public @ResponseBody List<Product> getPriceDetails() {
		System.out.println("Getting price");
		return productDAO.getProductList(1, 1000);
	}
	
	@RequestMapping(value = "/productListPag", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> productListPag(@RequestParam(required=false, defaultValue = "1")int currentPage, 
			@RequestParam(required=false, defaultValue = "10")int currentLimit) {
		System.out.println("Getting product list with pagination");
		int start = (currentPage -1 )  * currentLimit;
		List<Product> productList = productDAO.getProductList(start, currentLimit);
		
		Map<String, Object> parameterMap = new HashMap<>();
		parameterMap.put("totalResult",  productDAO.getProductTotalCount());
		parameterMap.put("currentPage", currentPage);
		parameterMap.put("currentLimit", currentLimit);
		parameterMap.put("currentSize", productList ==null? 0 :productList.size());
		parameterMap.put("result", productList);
		
		return new ResponseEntity<>(parameterMap, HttpStatus.OK); 
	}
	
	@RequestMapping(value = "/getProduct", method = RequestMethod.GET)
	public @ResponseBody Product getProduct(@RequestParam String productNumber) {
		System.out.println("Getting product");
		return productDAO.getProduct(productNumber);
	}
	
	@RequestMapping(value = "/createProduct", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<?> createProduct(HttpServletRequest request){
		String productNumber = request.getParameter("createProductNumber");
		String date = request.getParameter("createProductDate");
		
		System.out.println("Creating product");
		try {
			return new ResponseEntity<>(productDAO.createProduct(productNumber, date), HttpStatus.OK);
		}catch(DuplicateKeyException e) {
			return new ResponseEntity<>("Duplicate product number", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		catch(Exception e){
			return new ResponseEntity<>(e, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	@RequestMapping(value = "/getInstallTypeList", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> getInstallTypeList() {
		System.out.println("Getting install type list");
		try {
			return new ResponseEntity<>(productDAO.getInstallTypeList(), HttpStatus.OK);
		}catch(EmptyResultDataAccessException e) {
			System.out.println(e);
			return new ResponseEntity<>("Item not found",HttpStatus.NOT_FOUND);
		}catch(Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Server Error",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/getInstallTypeDiffPrice", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> getInstallTypeDiffPrice(@RequestParam int type, @RequestParam double height) {
		System.out.println("Getting install type list");
		try {
			return new ResponseEntity<>(productDAO.getInstallTypeDiffPrice(type, height), HttpStatus.OK);
		}catch(EmptyResultDataAccessException e) {
			System.out.println(e);
			return new ResponseEntity<>("Item not found",HttpStatus.NOT_FOUND);
		}catch(Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Server Error",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/getProductDetail", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> getProductDetail(@RequestParam String productNumber, @RequestParam int lineNumber) {
		System.out.println("Getting product detail");
		
		try {
			return new ResponseEntity<>(productDAO.getProductDetail(productNumber, lineNumber), HttpStatus.OK);
		}catch(EmptyResultDataAccessException e) {
			System.out.println(e);
			return new ResponseEntity<>("Item not found",HttpStatus.NOT_FOUND);
		}catch(Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Server Error",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/deleteProductDetail", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> deleteProductDetail(@RequestParam String productNumber, @RequestParam int lineNumber) {
		System.out.println("Deleting product detail");
		
		try {
			return new ResponseEntity<>(productDAO.deleteProductDetail(productNumber, lineNumber), HttpStatus.OK);
		}catch(EmptyResultDataAccessException e) {
			System.out.println(e);
			return new ResponseEntity<>("Item not found",HttpStatus.NOT_FOUND);
		}catch(Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Server Error",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/updateProductDetail", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<?> updateProductDetail(@RequestParam String productNumber, HttpServletRequest request){
		ProductDetail pd = new ProductDetail();
		InstallType it = new InstallType();
		int lineNumber = Integer.parseInt(request.getParameter("lineNumber"));
		int type = Integer.parseInt(request.getParameter("type"));
		double width = (request.getParameter("width") == "" || request.getParameter("width") == null)? 0.0: Double.parseDouble(request.getParameter("width"));
		double height = (request.getParameter("height") == "" || request.getParameter("height") == null)? 0.0: Double.parseDouble(request.getParameter("height"));
		double price = Double.parseDouble(request.getParameter("price"));
		String description = request.getParameter("description") == null ? "" : request.getParameter("description");
		
		it.setId(type);
		pd.setProductNumber(productNumber);
		pd.setProductLineNumber(lineNumber);
		pd.setType(it);
		pd.setHeight(height);
		pd.setWidth(width);
		pd.setFinalPrice(price);
		pd.setDescription(description);
		
		
		System.out.println("Getting install type list");
		try {
			return new ResponseEntity<>(productDAO.updateProductDetail(pd), HttpStatus.OK);
		}catch(Exception e){
			System.out.println(e);
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
	}
	
	@RequestMapping(value = "/updateProduct", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<?> updateProduct(HttpServletRequest request){
		String productNumber = null;
		String productDate = null;
		if(request.getParameter("productNumber")!=null)
			productNumber = request.getParameter("productNumber");
		else
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR); 
		
		if(request.getParameter("productDate")!=null)
			productDate = request.getParameter("productDate");
		else
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR); 
		
		System.out.println("Updating product");
		try {
			return new ResponseEntity<>(productDAO.updateProduct(productNumber, productDate), HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/deleteProduct", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<?> deleteProduct(@RequestParam String productNumber) {
		System.out.println("Deleting product");
		
		try {
			return new ResponseEntity<>(productDAO.deleteProduct(productNumber), HttpStatus.OK);
		}catch(EmptyResultDataAccessException e) {
			System.out.println(e);
			return new ResponseEntity<>("Item not found",HttpStatus.NOT_FOUND);
		}catch(Exception e) {
			System.out.println(e);
			return new ResponseEntity<>("Server Error",HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/createProductDetail", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<?> createProductDetail(@RequestParam String productNumber, HttpServletRequest request){
		int lineNumber = Integer.parseInt(request.getParameter("createLineNumber"));
		int type = Integer.parseInt(request.getParameter("createType"));
		double width = (request.getParameter("createWidth") == "" || request.getParameter("createWidth") == null)? 0.0: Double.parseDouble(request.getParameter("createWidth"));
		double height = (request.getParameter("createHeight") == "" || request.getParameter("createHeight") == null)? 0.0: Double.parseDouble(request.getParameter("createHeight"));
		double price = Double.parseDouble(request.getParameter("createPrice"));
		String description = request.getParameter("createDescription") == null ? "" : request.getParameter("createDescription");
		
		System.out.println("Creating product detail");
		try {
			return new ResponseEntity<>(productDAO.createProductDetail(productNumber, lineNumber, type, width, height,price,description), HttpStatus.OK);
		}catch(Exception e){
			System.out.println(e);
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value="/generateProductDetailReport.do")
	public void generateProductDetailReport(@RequestParam String productNumber, HttpServletRequest request, HttpServletResponse response) {
		
		// Method 1, used with the JasperReportMultipleViewFormat
		
//		Map<String, Object> model = new HashMap<String, Object>();
//		String filename = "keiyin.pdf";
//		
//		model.put("view", "productDetailReport");
//		model.put("format", "pdf");
//		model.put("productNumber", productNumber);
//		return new ModelAndView("productDetailReport", model);
		

		Map<String, Object> parameterMap = new HashMap<String, Object>();
		String filename = productNumber + ".pdf";
		
		parameterMap.put("productNumber", productNumber);

		
		try {
			InputStream inputStream = this.getClass().getResourceAsStream("/reports/Invoice.jrxml");
			JasperReport jasperDesign = JasperCompileManager.compileReport(inputStream);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperDesign, parameterMap, ds.getConnection());
			
			 response.setContentType("application/pdf");
	         response.addHeader("Content-disposition", "inline; filename=" +filename);
	         OutputStream outputStream = response.getOutputStream();
	         JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}