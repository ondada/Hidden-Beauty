package mall.controller;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mall.model.CartBean;
import mall.model.CartDao;
import mall.model.KakaoApproveResponse;
import mall.model.OrderBean;
import mall.model.OrderDao;
import mall.model.TempCart;
import product.model.ProductBean;
import users.model.UsersBean;


@Controller
public class CartOrderCompletedController {

	private final String command = "/cartOrderCompleted.mall";
	private String viewPage = "orderCompleted";
	private String kakaopay = "kakaopay";
	
	@Autowired
	private OrderDao dao; 
	
	@Autowired
	private CartDao cartDao; 
	
	@Autowired
	private ServletContext application;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String list(
			@RequestParam(value ="cart_num", required = false) String cart_num,
			
			@RequestParam(value = "u_id", required = false) String u_id,
			@RequestParam(value = "o_name", required = false) String o_name,
			@RequestParam(value = "o_phone1", required = false) String o_phone1,
			@RequestParam(value = "o_phone2", required = false) String o_phone2,
			@RequestParam(value = "o_phone3", required = false) String o_phone3,
			
			@RequestParam(value = "o_message", required = false) String o_message,
			
			@RequestParam(value = "addr1", required = false) String addr1,
			@RequestParam(value = "addr2", required = false) String addr2,
			@RequestParam(value = "addr3", required = false) String addr3,
			@RequestParam(value ="addr4", required = false) String addr4,
			@RequestParam(value ="addr5", required = false) String addr5,
			
			@RequestParam(value = "way", required = false) String way,
			@RequestParam(value = "pay_bank", required = false) String pay_bank,
			@RequestParam(value = "pay_name", required = false) String pay_name,
			@RequestParam(value = "deli", required = false) String deli,
			@RequestParam(value = "totalPrice", required = false) int totalPrice,
			@RequestParam(value = "totalPoint", required = false) String totalPoint,

			
			HttpServletRequest request,
			Model model,
			HttpSession session) {
		 
		 System.out.println(totalPrice+"totalPrice는?");
		OrderBean ob = new OrderBean();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String currentDate = LocalDate.now().format(formatter);
		
		ob.setU_id(u_id);
		ob.setO_name(o_name);
		ob.setO_message(o_message);
		ob.setWay(way);
		if(pay_bank.equals("")) {
			ob.setPay_bank("다른 결제 방법 선택");
			ob.setPay_name("다른 결제 방법 선택");
		}else {
			ob.setPay_bank(pay_bank);
			ob.setPay_name(pay_name);
		}
	 
		ob.setO_status("주문완료");
		ob.setO_date(currentDate);
		ob.setO_status("주문완료");
		ob.setO_phone(o_phone1+"-"+o_phone2+"-"+o_phone3);
		
		if(addr1.length() < 4) {
			UsersBean ub = dao.selectUser(u_id);
			ob.setO_addr(ub.getU_address());
		} else {
			addr1 = addr1.replace(",", "");
			addr2 = addr2.replace(",", "");
			addr5 = addr5.replace(",", "");
			ob.setO_addr(addr1+", "+addr2+", "+addr5);
		}
		
		int MaxO_num = 0;
		MaxO_num = dao.selectMaxO_num();
		MaxO_num = MaxO_num+1;
		 
		ob.setO_num(MaxO_num);
		ob.setO_totalamount(totalPrice);
			
		List<CartBean> list = cartDao.selectCart2(cart_num);
		
		if(!(Boolean)application.getAttribute("flag")) {
			for(int i = 0; i<list.size(); i++) {
				dao.downStockPord(list.get(i));
				dao.upSalevolumePord(list.get(i));
				dao.insertCartOrderPord(list.get(i),MaxO_num);
			}
			dao.insertOrderInfo(ob);
			dao.deleteAllCart(cart_num);
			application.setAttribute("flag", true);
		} 
		
		model.addAttribute("ob", ob); // 주문 정보가 담긴 객체 '주문완료' 페이지로 전달.
		model.addAttribute("deli", deli); // 배송비 정보 담아서 전달
		model.addAttribute("totalPrice", totalPrice); // 총 합계금액 정보 담아서 전달
		model.addAttribute("totalPoint", totalPoint); // 총 포인트 적립금액 정보 담아서 전달
		System.out.println(cart_num+"cart_num뭔데");
		dao.deleteAllCart(cart_num);
		
		if(way.equals("무통장 입금")) {
			return viewPage;
		}else {
			
			KakaoApproveResponse kao = new KakaoApproveResponse();
			
			kao.getAmount().setTotal(totalPrice);
			kao.setPartner_order_id( "KAKAOHB"+MaxO_num);
			kao.setPartner_user_id(u_id);
			
			session.setAttribute("kao", kao);
			session.setAttribute("o_num", MaxO_num);
			
			return kakaopay;
		}
	}

}