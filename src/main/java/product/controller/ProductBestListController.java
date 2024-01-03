package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductBean;
import product.model.ProductDao;
import utility.Paging;

@Controller
public class ProductBestListController {
	private final String command = "/productBestList.p";
	private final String viewPage = "productBestList";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(command)
	public String list(Model model, HttpServletRequest request) {

		List<ProductBean> product_BLists = productDao.getBestProductList();
		model.addAttribute("product_BLists",product_BLists);
		return viewPage;
	}
	
}