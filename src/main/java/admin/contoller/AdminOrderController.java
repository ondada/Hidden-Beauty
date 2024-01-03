 
package admin.contoller;

 
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
 
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

 
import admin.model.AdminOrderDao;
 
import mall.model.OrderBean;
import mall.model.OrdersProductBean;
import product.model.ProductBean;
import utility.Paging;

@Controller
public class AdminOrderController {
	private final String command = "/orderList.admin";
	private final String deCommand = "/orderDetail.admin";
	private final String upCommand = "/orderStatus.admin";
	 
	private final String viewPage = "adminOrderList";
	private final String dePage = "adminOrderDetail";
	private final String redirect = "redirect";
	private final String upPage = "redirect:/orderList.admin";
	
	/* private final String redirect = "redirect"; */
	
	@Autowired
	private AdminOrderDao dao;
	
	 
	
	/*
	  @Autowired 
	  private AdminDao adminDao;
	 */
	/*
	  @Autowired
	  ServletContext servletContext;
	 */
	
	@RequestMapping(value = command)
	public String orderList(
						@RequestParam(required = false) String whatColumn,
						@RequestParam(required = false) String keyword,
						@RequestParam(required = false) String pageNumber,
						Model model,
						HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");  
		
		System.out.println(pageNumber+"pageNumber��?@???");
		System.out.println(whatColumn+"whatColumn��?@???");
		System.out.println(keyword+"keyword��?@???");
		
		int totalCount = dao.getTotalCountOrder(map);
		String url = request.getContextPath()+command;
		Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
		
		List<OrderBean> ordLists = dao.getAllOrder(pageInfo, map);
		
		
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		
		model.addAttribute("ordLists", ordLists);
		model.addAttribute("pageInfo", pageInfo);
		
		return viewPage;
	}
	
	
	
	@RequestMapping(value = deCommand)
	public String orderDetail(			
			@RequestParam(required = false) String whatColumn,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String pageNumber,
			@RequestParam(required = false) String o_num,
			Model model
						) {
		
		List<OrdersProductBean> ordProdlist = dao.getAllOrdersProduct(o_num);//1�̻� ���ڵ�, ���� �� ����
		
		List<ProductBean> prodList = new ArrayList<ProductBean>();
		
		for(int i = 0; i<ordProdlist.size(); i++) {
			
			ProductBean pb  =	dao.selectPord(Integer.toString(ordProdlist.get(i).getP_num()));
			
			prodList.add(pb);
		}
		
		OrderBean ob =  dao.getOneOrder(o_num);//�ֹ������� �ϳ���
		
		model.addAttribute("ob", ob);
		model.addAttribute("prodList", prodList);
		model.addAttribute("ordProdlist", ordProdlist);
		
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageNumber", pageNumber);
	
		return dePage;
	}
	
	@RequestMapping(value = upCommand)
	public String orderStatus(
			@RequestParam(required = false) String whatColumn,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String o_num,
			@RequestParam(required = false) String u_id,
			@RequestParam(required = false) String pageNumber,
			HttpServletResponse response,
			Model model,
			HttpServletRequest request
						) throws IOException {
		System.out.println("pageNumber �Ѿ������: "+pageNumber);
		System.out.println("whatColumn �Ѿ������: "+whatColumn);
		System.out.println("keyword �Ѿ������: "+keyword);
		
		response.setContentType("text/html; charset=UTF-8");
		
		String stasus = dao.selectOrderStatus(o_num);
		System.out.println("stasus: "+stasus);

		if(stasus.equals("주문완료")) {
			
			dao.updateOrderStatus(o_num);//�ֹ��Ϸ� => ���ۿϷ�
			
			List<OrdersProductBean> ordProdlist = dao.getAllOrdersProduct(o_num);//o_num���� p_num ��ƿ���
			
			List<ProductBean> prodList = new ArrayList<ProductBean>();
			
			System.out.println(ordProdlist.size()+"ordProdlist.size()��");
			for(int i = 0; i<ordProdlist.size(); i++) {
				
				ProductBean pb  =	dao.selectPord(Integer.toString(ordProdlist.get(i).getP_num()));
				
				prodList.add(pb);//�ϳ��� p_num���� p_point���� ��������
			}		
					
			System.out.println(prodList.size()+"prodList.size()�� ������?");
			
			for(int i = 0; i<prodList.size(); i++) {
				
				dao.updateUsersPoint(Integer.toString(prodList.get(i).getP_point()),u_id);
			}	
			
		}else if(stasus.equals("주문취소")) {
			model.addAttribute("msg", "취소된 내역입니다.");
			model.addAttribute("url", request.getContextPath()+"/"+command+"?pageNumber="+pageNumber+"&keyword="+keyword+"&whatColumn="+whatColumn);
			return redirect;
			
		}else if(stasus.equals("배송완료")) {
			model.addAttribute("msg", "이미 배송 완료된 상품입니다.");
			model.addAttribute("url", request.getContextPath()+"/"+command+"?pageNumber="+pageNumber+"&keyword="+keyword+"&whatColumn="+whatColumn);
			return redirect;
		}
		  
		return upPage+"?pageNumber="+pageNumber+"&keyword="+keyword+"&whatColumn="+whatColumn;
		
		
		//return upPage+"?pageNumber="+pageNumber;
		
	}
	
	 
}