package controller;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dao.ProductDAO;
import model.Product;
 
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
	
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public @ResponseBody List<Product> getPriceDetails() {
		System.out.println("Getting price");
		return productDAO.getProductList();
	}
	
	@RequestMapping(value = "/getProduct", method = RequestMethod.GET)
	public @ResponseBody Product getProduct(@RequestParam String productNumber) {
		System.out.println("Getting price");
		return productDAO.getProduct(productNumber);
	}
}