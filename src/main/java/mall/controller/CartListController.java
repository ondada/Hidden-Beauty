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
import product.model.ProductBean;

@Controller
public class CartListController {
	private final String command = "/cartList.mall";
	private final String command_qtyUp = "/qtyUp.mall";
	private String viewPage = "cartList";
	private String redirect = "redirect:/cartList.mall";
	
	@Autowired
	private CartDao dao;
	 	
	@RequestMapping(value = command)
	public String cart(HttpSession session, Model model) {
		 
			String cart_num = session.getId();
			List<CartBean> list = dao.selectCart2(cart_num);
			model.addAttribute("list",list);
			
			int totalAmount = 0;
			List<ProductBean> productList = new ArrayList<ProductBean>();
			if(list != null) {
				for(int i = 0; i<list.size(); i++) {
					ProductBean pb = dao.selectPord(list.get(i).getP_num());
					totalAmount = totalAmount+pb.getP_price();
					productList.add(pb);
				}
			}
			model.addAttribute("productList",productList);
			model.addAttribute("totalAmount",totalAmount);
		 
		return viewPage;
		
	}
	
	@RequestMapping(value = command_qtyUp)
	public String qtyUp(CartBean cb) {

		System.out.println("cb.getP_num() : " + cb.getP_num());
		System.out.println("cb.getCart_num() : " + cb.getCart_num());
		System.out.println("cb.getCart_qty() : " + cb.getCart_qty());
		
		dao.updateCartQty(cb);
		return redirect;
	}
	
}
