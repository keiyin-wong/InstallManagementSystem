package controller;
 
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
 
@Controller
@RequestMapping(value = "/order")
public class OrderController {
	String message = "Welcome to Spring Order!";
 
	@RequestMapping(value = "/list.html", method = RequestMethod.GET)
	public ModelAndView showMessage() {
		System.out.println("in controller");
 
		ModelAndView mv = new ModelAndView("order");
		mv.addObject("message", message);
		return mv;
	}
	
//	@RequestMapping(value = "/price", method = RequestMethod.GET)
//	public @ResponseBody InstallPrice getPriceDetails() {
//		System.out.println("Getting price");
// 
//		InstallPrice installPrice = new InstallPrice();
//		installPrice.setDesc_eng("wall unit");
//		installPrice.setPrice(20);
//		
//		return installPrice;
//	}
}