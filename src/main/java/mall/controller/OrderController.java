package mall.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mall.model.OrderBean;
import mall.model.OrderDao;
import mall.model.TempCart;
import product.model.ProductBean;
import users.model.UsersBean;


@Controller
public class OrderController {
	private final String command = "/order.mall";
	private String viewPage = "orderInfo";
	
	@Autowired
	private OrderDao dao;
	
	@RequestMapping(value = command)
	public String list(
			@RequestParam(value = "id", required = false) String id,
			@RequestParam(value = "cart_num", required = false) String cart_num,
			@RequestParam(value = "p_num", required = false) String p_num,
			@RequestParam(value ="oqty", required = false) String cart_qty,
			HttpServletRequest request,
			Model model) {
	 
		Map<String,String> map = new HashMap<String, String>();
		map.put("cart_num", cart_num);
		map.put("p_num", p_num);
		map.put("cart_qty", cart_qty);
		
		dao.deleteTemp(cart_num);
		dao.insertTemp(map);
		
		TempCart tc = dao.selectTemp(cart_num); 
		ProductBean pb = dao.selectProd(p_num);
		
		int deli = 3000;
		int total =  tc.getCart_qty() * pb.getP_price();
		if(total>=30000) {
			deli = 0;
		}
		total += deli;
		
		UsersBean ub = dao.selectUser(id);
		
		model.addAttribute("pb", pb);//p_name, p_price
		model.addAttribute("tc", tc);//oqty
		model.addAttribute("deli", deli);
		model.addAttribute("total", total);
		model.addAttribute("u_address", ub.getU_address());
		model.addAttribute("name", ub.getU_name());
		model.addAttribute("id", id);
		model.addAttribute("phone", ub.getU_phone());
		
		return viewPage;
		
	}
	
}
