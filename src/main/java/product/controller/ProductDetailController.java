package product.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductDetailController {
	private final String command = "prodView.p";
	private String viewPage = "productDetail";

	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String detail(
			@RequestParam(value = "p_num") String p_num,
			@RequestParam(value = "pageNumber") String pageNumber,
			Model model) {
		 
		ProductBean pb = productDao.getSelectOne(p_num);
		
		model.addAttribute("pb", pb);
		model.addAttribute("pageNumber", pageNumber);
		
		return viewPage;
		
	}
	
}