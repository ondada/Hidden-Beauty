package admin.contoller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.model.AdminDao;
import c_board.model.CBoardBean;
import q_board.model.QBoardBean;
import utility.Paging;

@Controller
public class AdminQBoardController {

	@Autowired
	private AdminDao adminDao;

	public final String listCommand="/qBoardList.admin";
	public final String viewPage="adminQBoard";
	public final String deleteCommand="/qBoardDelete.admin";
	public final String gotoPage="redirect:/qBoardList.admin";
	private final String commandDetail = "/qBoardDetail.admin";
	private final String viewPageDetail = "adminQBoardDetail";
	public final String replyCommand="/qReply.admin";
	public final String viewPageR="adminQReplyPopUp";
	
	@RequestMapping(value=listCommand,method=RequestMethod.GET)
	public String goAdmin(
				Model model,
				@RequestParam(value="whatColumn",required = false) String whatColumn,
				@RequestParam(value="keyword",required = false) String keyword,
				@RequestParam(value="pageNumber",required = false) String pageNumber,
				HttpServletRequest request
			) {
		
		Map<String,String> map = new HashMap<String,String>(); 
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%"+keyword+"%");
		
		int totalCount = adminDao.getTotalCount(map);
		String url = request.getContextPath()+listCommand;
		
		String ps="1000";
		
		Paging pageInfo = new Paging(pageNumber,ps,totalCount,url,whatColumn,keyword);
		
		List<QBoardBean> list = adminDao.getAllBoardList(pageInfo,map);
		
		model.addAttribute("list",list);
		model.addAttribute("pageInfo",pageInfo);
		
		return viewPage;
	}
	
	@RequestMapping(value=deleteCommand,method=RequestMethod.GET)
	public String delete(
				Model model,
				@RequestParam("q_num") int q_num
			) {
		
		QBoardBean bb = adminDao.selectContent(q_num);
		
		model.addAttribute("bb",bb);
		
		adminDao.deleteBoard(q_num);
		
		return gotoPage;
	}
	
	@RequestMapping(value=commandDetail,method=RequestMethod.GET)
	public String toDetailList(
			Model model,
			@RequestParam("q_num") int q_num,
			@RequestParam("pageNumber") int pageNumber
			) throws Exception {
		
		QBoardBean bb = adminDao.selectContent(q_num);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("bb",bb);
		
		return viewPageDetail;
		
		
	}
	
	@RequestMapping(value=replyCommand,method=RequestMethod.GET)
	public String reply(
			Model model,
			@RequestParam("q_num") int q_num,
			@RequestParam("pageNumber") int pageNumber,
			@RequestParam("q_ref") int q_ref,
			@RequestParam("q_re_step") int q_re_step,
			@RequestParam("q_re_level") int q_re_level,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword
			) throws Exception {
		
		QBoardBean bb = adminDao.selectContent(q_num);
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("q_ref",q_ref);
		model.addAttribute("q_re_step",q_re_step);
		model.addAttribute("q_re_level",q_re_level);
		model.addAttribute("bb",bb);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		
		return viewPageR;
	}
	
	@RequestMapping(value=replyCommand,method=RequestMethod.POST)
	public String goReply(
			Model model,
			HttpServletResponse response,
			@RequestParam(value="pageNumber",required = false) int pageNumber,
			@RequestParam(value="q_ref",required = false) int q_ref,
			@RequestParam(value="q_re_step",required = false) int q_re_step,
			@RequestParam(value="q_re_level",required = false) int q_re_level,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			HttpServletRequest request,
			@ModelAttribute("bb") @Valid QBoardBean bb,
			BindingResult br
		) throws IOException {
		
		int q_num = bb.getQ_num();
		
		if(br.hasErrors()) {
			
			model.addAttribute("pageNumber",pageNumber);
			model.addAttribute("q_num",q_num);
			model.addAttribute("bb", bb);
			model.addAttribute("whatColumn",whatColumn);
			model.addAttribute("keyword",keyword);
			
			return viewPageR;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
	
		bb.setQ_ref(q_ref);
		bb.setQ_subject("[답글] "+bb.getQ_subject());
		bb.setQ_re_step(q_re_step);
		bb.setQ_re_level(q_re_level);
		bb.setQ_ip(request.getRemoteAddr());
		bb.setQ_regdate(new Timestamp(System.currentTimeMillis()));
		
		adminDao.replyProc(bb);
		
		return gotoPage+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword;
	}
	
	
	
}