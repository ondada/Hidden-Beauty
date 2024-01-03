package mall.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import mall.model.OrderBean;
import mall.model.OrderDao;
import mall.model.OrdersProduct;
import mall.model.TempCart;
import product.model.ProductBean;
import users.model.UsersBean;
import users.model.UsersDao;


@Controller
public class kakaopaySuccessController {
	@Autowired
	private OrderDao dao;
	
	private final String command = "/success.mall";
	private String viewPage = "success";
	  
	@RequestMapping(value = command)
	public String list(@RequestParam("approvedAt") String approvedAt,
			Model model) {
		model.addAttribute("approvedAt",approvedAt);
		return viewPage;
		 
	}
	
	private final String kakaoOrderSelect = "/kakaoOrderSelect.mall";
	private String viewPage2 = "orderCompleted";
	
	@RequestMapping(value = kakaoOrderSelect)
	public String orderCompleted(HttpSession session,
			Model model) {
		
		int o_num = (Integer) session.getAttribute("o_num");
		
		OrderBean ob = dao.selectOrders(o_num);
		
		List<OrdersProduct> list = new ArrayList<OrdersProduct>();
		
		list = dao.getCartInfo(o_num);
		
		int totalPoint = 0;
		
		for(int i =0; i<list.size();i++) {
			OrdersProduct ordersProduct = list.get(i);
			
			  int p_num = ordersProduct.getP_num();
			  
			  int p_point =  dao.selectPoint(Integer.toString(p_num));
			  
			  System.out.println(i+"번째:"+p_point);
			  totalPoint += p_point;
		}
		System.out.println(totalPoint+"p_point는?");
		
		model.addAttribute("ob", ob);
		model.addAttribute("totalPoint", totalPoint);
		
		return viewPage2;
		
	}

}