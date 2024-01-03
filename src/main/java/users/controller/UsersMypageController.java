package users.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import c_board.model.CBoardBean;
import c_board.model.CBoardDao;
import mall.model.OrderBean;
import mall.model.OrderDao;
import mall.model.OrdersProduct;
import mall.model.OrdersProductBean;
import product.model.ProductBean;
import q_board.model.QBoardBean;
import q_board.model.QBoardDao;
import users.model.FeedbackBean;
import users.model.FeedbackDao;
import users.model.UsersBean;
import users.model.UsersDao;
import utility.Paging;


@Controller
public class UsersMypageController {
	
	@Autowired
	private UsersDao ud;
	@Autowired
	private FeedbackDao fd;
	@Autowired
	private CBoardDao cd;
	@Autowired
	private QBoardDao qd;
	@Autowired
	private OrderDao od;
	
	private final String command = "/mypage.u";
	private final String command_delForm = "/deleteForm.u";
	private final String command_del = "/delete.u";
	private final String command_c_board = "/c_board.u";
	private final String command_c_boardChkDel = "/c_boardChkDel.u";
	private final String command_c_boardDel = "/c_boardDel.u";
	private final String command_c_boardDetail = "/c_boardDetail.u";
	private final String command_c_boardUpdate = "/c_boardUpdate.u";
	private final String command_q_board = "/q_board.u";
	private final String command_q_boardChkDel = "/q_boardChkDel.u";
	private final String command_q_boardDel = "/q_boardDel.u";
	private final String command_q_boardDetail = "/q_boardDetail.u";
	private final String command_q_boardUpdate = "/q_boardUpdate.u";
	private final String command_order = "/order.u";
	private final String command_orderDetail = "/orderDetail.u";
	private final String viewPage = "usersMypage";
	private final String viewPage_delForm = "usersMypageDelId";
	private final String viewPage_del = "redirect";
	private final String viewPage_c_board = "usersMypageCboard";
	private final String viewPage_c_boardRedirct = "redirect:/c_board.u";
	private final String viewPage_c_boardDetail = "usersMypageCboardDetail";
	private final String viewPage_c_boardUpdate = "usersMypageCboardUpdate";
	private final String viewPage_q_board = "usersMypageQboard";
	private final String viewPage_q_boardRedirct = "redirect:/q_board.u";
	private final String viewPage_q_boardDetail = "usersMypageQboardDetail";
	private final String viewPage_q_boardUpdate = "usersMypageQboardUpdate";
	private final String viewPage_order = "usersMypageOrder";
	private final String viewPage_orderDetail = "usersMypageOrderDetail";
	
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam String u_id, Model model) {
		UsersBean ub = ud.getUserById(u_id);
		model.addAttribute("ub", ub);
		return viewPage;
	}
	
	@RequestMapping(value = command_delForm, method = RequestMethod.GET)
	public String delForm(HttpSession session) {
		return viewPage_delForm; 
	}
	
	@RequestMapping(value = command_del, method = RequestMethod.POST)
	public String delId(@RequestParam String u_id, @RequestParam String reason, @RequestParam String u_jointype, Model model, HttpSession session) {
		FeedbackBean fb = new FeedbackBean();
		fb.setU_id(u_id);
		fb.setU_jointype(u_jointype);
		fb.setFb_content(reason);
		
		if(u_jointype.equals("S")) {
			fb.setFb_requestApi("no");
		} else if(u_jointype.equals("N") || u_jointype.equals("K")) {
			fb.setFb_requestApi("yes");
		}
		fd.insertFeedback(fb);
		
		ud.deleteUsers(u_id);
		session.invalidate();
		// 유저의 프로필 사진 업로드 폴더에서 내리기 => 이거 아직 안함!!!
		
		model.addAttribute("msg", "탈퇴 처리되었습니다. 이용해주셔서 감사합니다.");
		if(u_jointype.equals("N")) {
			// 네이버 연동 해제
			model.addAttribute("url", "disnaver.u");
		} else if(u_jointype.equals("K")) {
			// 카카오 연동 해제
			model.addAttribute("url", "diskakao.u");
		} else {
			model.addAttribute("url", ".main");
		}
		return viewPage_del;
 	}
	
	@RequestMapping(value = command_c_board, method = RequestMethod.GET)
	public String c_board(HttpSession session, Model model, HttpServletRequest request,
							@RequestParam(value="whatColumn",required = false) String whatColumn,
							@RequestParam(value="keyword",required = false) String keyword,
							@RequestParam(value="pageNumber",required = false) String pageNumber) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("c_writer", ub.getU_id());
		
		int totalCount = cd.getTotalCountById(map);
		String url = request.getContextPath()+command_c_board;
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);
		
		List<CBoardBean> c_boardLists = cd.getBoardById(pageInfo,map);
		model.addAttribute("c_boardLists", c_boardLists);
		model.addAttribute("pageInfo",pageInfo);
		return viewPage_c_board;
	}
	
	@RequestMapping(value = command_c_boardDel, method = RequestMethod.GET)
	public String c_boardDel(Model model, @RequestParam("c_num") int c_num, @RequestParam("pageNumber") String pageNumber) {
		cd.deleteBoard(c_num);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_c_boardRedirct;
	}
	
	@RequestMapping(value = command_c_boardChkDel, method = RequestMethod.GET)
	public String c_boardChkDel(Model model, @RequestParam("check") int[] checks, @RequestParam("pageNumber") String pageNumber) {
		cd.deleteChkBoard(checks);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_c_boardRedirct;
	}
	
	@RequestMapping(value = command_c_boardDetail, method = RequestMethod.GET)
	public String c_boardDetail(Model model, @RequestParam("c_num") int c_num, @RequestParam("pageNumber") String pageNumber) {
		//cd.updateReadcount(c_num); => 마이페이지 내에서 본인이 조회할 때는 조회수가 오르지 않음.
		CBoardBean cb = cd.selectContent(c_num);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("cb", cb);
		return viewPage_c_boardDetail;
	}
	
	@RequestMapping(value = command_c_boardUpdate, method = RequestMethod.GET)
	public String c_boardUpdateForm(Model model, @RequestParam("c_num") int c_num, @RequestParam("pageNumber") int pageNumber) {
		CBoardBean cb = cd.selectContent(c_num);
		model.addAttribute("cb", cb);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_c_boardUpdate;
	}
	
	@RequestMapping(value = command_c_boardUpdate, method = RequestMethod.POST)
	public String c_boardUpdate(Model model, @ModelAttribute("cb") CBoardBean cb, @RequestParam("pageNumber") int pageNumber) {
		
		cd.updateBoard(cb);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_c_boardRedirct;
	}
	
	@RequestMapping(value = command_q_board, method = RequestMethod.GET)
	public String q_board(HttpSession session, Model model, HttpServletRequest request,
							@RequestParam(value="whatColumn",required = false) String whatColumn,
							@RequestParam(value="keyword",required = false) String keyword,
							@RequestParam(value="pageNumber",required = false) String pageNumber) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("q_writer", ub.getU_id());
		
		int totalCount = qd.getTotalCountById(map);
		String url = request.getContextPath()+command_q_board;
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);
		
		List<CBoardBean> q_boardLists = qd.getBoardById(pageInfo,map);
		model.addAttribute("q_boardLists", q_boardLists); 
		model.addAttribute("pageInfo",pageInfo);
		return viewPage_q_board;
	}
	
	@RequestMapping(value = command_q_boardDel, method = RequestMethod.GET)
	public String q_boardDel(Model model, @RequestParam("q_num") int q_num, @RequestParam("pageNumber") String pageNumber) {
		qd.deleteBoard(q_num);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_q_boardRedirct;
	}
	
	@RequestMapping(value = command_q_boardChkDel, method = RequestMethod.GET)
	public String q_boardChkDel(Model model, @RequestParam("check") int[] checks, @RequestParam("pageNumber") String pageNumber) {
		qd.deleteChkBoard(checks);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_q_boardRedirct;
	}
	
	@RequestMapping(value = command_q_boardDetail, method = RequestMethod.GET)
	public String q_boardDetail(Model model, @RequestParam("q_num") int q_num, @RequestParam("pageNumber") String pageNumber) {
		QBoardBean qb = qd.selectContent(q_num);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("qb", qb);
		return viewPage_q_boardDetail;
	}
	
	@RequestMapping(value = command_q_boardUpdate, method = RequestMethod.GET)
	public String q_boardUpdateForm(Model model, @RequestParam("q_num") int q_num, @RequestParam("pageNumber") int pageNumber) {
		QBoardBean qb = qd.selectContent(q_num);
		model.addAttribute("qb", qb);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_q_boardUpdate;
	}
	
	@RequestMapping(value = command_q_boardUpdate, method = RequestMethod.POST)
	public String q_boardUpdate(Model model, @ModelAttribute("qb") QBoardBean qb, @RequestParam("pageNumber") int pageNumber) {
		qd.updateBoard(qb);
		model.addAttribute("pageNumber", pageNumber);
		return viewPage_q_boardRedirct;
	}
	
	@RequestMapping(value = command_order, method = RequestMethod.GET)
	public String order(HttpServletRequest request, HttpSession session, Model model, @RequestParam(value="pageNumber", required=false) String pageNumber) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		String url = request.getContextPath()+command_order;
		int totalCount = od.getOrdersCountByU_id(ub.getU_id());
		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, "", "");
		
		List<OrderBean> obList = od.getOrdersByU_id(ub.getU_id(), pageInfo);
		
		model.addAttribute("obList", obList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("pageNumber", pageInfo.getPageNumber());
		
		return viewPage_order;
	}
	
	@RequestMapping(value = command_orderDetail, method = RequestMethod.GET)
	public String orderDetail(HttpSession session, Model model,
							@RequestParam("o_num") String o_num, @RequestParam("num") String num, 
							@RequestParam(value="pageNumber", required=false) String pageNumber) {

		List<OrdersProductBean> ordProdlist = od.getAllOrdersProduct2(o_num);
		
		List<ProductBean> prodList = new ArrayList<ProductBean>();
		for(int i = 0; i<ordProdlist.size(); i++) {
			ProductBean pb  =	od.selectPord2(Integer.toString(ordProdlist.get(i).getP_num()));
			prodList.add(pb);
		} 
		
		OrderBean ob =  od.getOneOrder2(o_num); 
		
		model.addAttribute("ob", ob);
		model.addAttribute("prodList", prodList);
		model.addAttribute("ordProdlist", ordProdlist);
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("num", num+1);
		
		return viewPage_orderDetail;
	}
	 
}