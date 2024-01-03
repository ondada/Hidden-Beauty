package mall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mall.model.CartBean;
import mall.model.CartDao;
import product.model.ProductBean;

@Controller
public class CartController {
	private final String command = "/cart.mall";
	private String viewPage = "confirm";
	
	@Autowired 
	private CartDao dao;
	@Autowired
	private ServletContext application;
	
	@RequestMapping(value = command)
	public String cart(
			@RequestParam(value = "p_num", required = false) String p_num,
			@RequestParam(value = "cart_num", required = false) String cart_num,
			@RequestParam(value = "oqty", required = false) String oqty,
			Model model) {
		
		 System.out.println(cart_num+"cart_num2");
		 System.out.println(p_num+"p_num2");
		 System.out.println(oqty+"oqty2");
		 
		if(!(Boolean) application.getAttribute("flag")) {
			CartBean cb = new CartBean();
			cb.setCart_num(cart_num);
			cb.setP_num(p_num);
			cb.setCart_qty(Integer.parseInt(oqty));
			
			
			int cnt = dao.selectCart(cb); 
			
			if(cnt==0) {//장바구니에 기존 상품 없음
				
				dao.insertCart(cb);
				
			}else {////장바구니에 기존 상품 있음
				
				dao.updateCart(cb);
				
			}
			
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
			application.setAttribute("flag", true);
		}else {
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
		}
		return viewPage;
		
	}
	
}