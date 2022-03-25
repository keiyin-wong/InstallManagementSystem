package controller;
 
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.ProductDAO;
import model.InstallType;
import model.Product;
import model.ProductDetail;
 
@Controller
@RequestMapping(value = "/product")

public class ProductController {
	@Autowired
	ProductDAO productDAO;
	
 
	@RequestMapping(value = "/product.html", method = RequestMethod.GET)
	public ModelAndView showMessage() {
		System.out.println("in controller");
 
		ModelAndView mv = new ModelAndView("product");
		return mv;
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
		return productDAO.getProductList();
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
		double width = Double.parseDouble(request.getParameter("width"));
		double height = Double.parseDouble(request.getParameter("height"));
		double price = Double.parseDouble(request.getParameter("price"));
		
		it.setId(type);
		pd.setProductNumber(productNumber);
		pd.setProductLineNumber(lineNumber);
		pd.setType(it);
		pd.setHeight(height);
		pd.setWidth(width);
		pd.setFinalPrice(price);
		
		
		System.out.println("Getting install type list");
		try {
			return new ResponseEntity<>(productDAO.updateProductDetail(pd), HttpStatus.OK);
		}catch(Exception e){
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
		
		System.out.println("Getting install type list");
		try {
			return new ResponseEntity<>(productDAO.updateProduct(productNumber, productDate), HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/createProductDetail", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<?> createProductDetail(@RequestParam String productNumber, HttpServletRequest request){
		int lineNumber = Integer.parseInt(request.getParameter("createLineNumber"));
		int type = Integer.parseInt(request.getParameter("createType"));
		double width = Double.parseDouble(request.getParameter("createWidth"));
		double height = Double.parseDouble(request.getParameter("createHeight"));
		double price = Double.parseDouble(request.getParameter("createPrice"));
		
		System.out.println("Creating product detail");
		try {
			return new ResponseEntity<>(productDAO.createProductDetail(productNumber, lineNumber, type, width, height,price), HttpStatus.OK);
		}catch(Exception e){
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	
	
	
}