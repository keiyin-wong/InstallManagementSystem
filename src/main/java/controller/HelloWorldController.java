package controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import model.InstallPrice;
 
@Controller
@RequestMapping(value = "/hello")
public class HelloWorldController {
	String message = "Welcome to Spring MVC!";
 
	@RequestMapping(value = "/list.html", method = RequestMethod.GET)
	public ModelAndView showMessage(
			@RequestParam(value = "name", required = false, defaultValue = "World") String name) {
		System.out.println("in controller");
 
		ModelAndView mv = new ModelAndView("helloworld");
		mv.addObject("message", message);
		mv.addObject("name", name);
		return mv;
	}
	
	@RequestMapping(value = "/price", method = RequestMethod.GET)
	public @ResponseBody InstallPrice getPriceDetails() {
		System.out.println("Getting price");
 
		InstallPrice installPrice = new InstallPrice();
		installPrice.setDesc_eng("wall unit");
		installPrice.setPrice(20);
		
		return installPrice;
	}
}