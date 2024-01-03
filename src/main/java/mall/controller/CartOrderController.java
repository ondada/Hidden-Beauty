package mall.controller;
 
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mall.model.CartBean;
import mall.model.CartDao;
import mall.model.OrderDao;
 
import product.model.ProductBean;
import users.model.UsersBean;
 


@Controller
public class CartOrderController {

	private final String command = "/cartOrder.mall";
	private String viewPage = "cartOrderInfo";
	
	@Autowired
	private CartDao dao; 
	
	@Autowired
	private OrderDao orderDao;
	
	@RequestMapping(value = command)
	public String cartOrder(
			@RequestParam("total") int total,
			Model model,
			HttpSession session
			) {
		
		String cart_num = session.getId();
		List<CartBean> list = dao.selectCart2(cart_num);
		model.addAttribute("list",list);
		
		List<ProductBean> productList = new ArrayList<ProductBean>();
		if(list != null) {
			for(int i = 0; i<list.size(); i++) {
				ProductBean pb  =	dao.selectPord(list.get(i).getP_num());
				productList.add(pb);
			}
			System.out.println(productList.size()+": productList");
		}
		model.addAttribute("productList",productList);
		
		int deli = 3000;
		if(total>=30000) {
			deli = 0;
		}
		total += deli;
		 
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		ub = orderDao.selectUser(ub.getU_id());
		
		model.addAttribute("name", ub.getU_name());
		model.addAttribute("id", ub.getU_id());
		model.addAttribute("phone", ub.getU_phone());
		model.addAttribute("u_address", ub.getU_address());
		model.addAttribute("deli", deli);
		model.addAttribute("total", total);
		 
		return viewPage;
	}

}