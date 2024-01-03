package q_board.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

import q_board.model.QBoardBean;
import q_board.model.QBoardDao;
import users.model.UsersBean;


@Controller
public class QBoardUpdateController {

	@Autowired
	private QBoardDao qdao;
	
	public final String command="/qUpdate.qb";
	public final String viewPage="qBoardUpdate";
	public final String viewPage2="alert";
	public final String gotoPage="redirect:/qBoardList.qb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String Form(
				Model model,
				@RequestParam("q_num") int q_num,
				@RequestParam("pageNumber") int pageNumber,
				@RequestParam(value="whatColumn", required=false) String whatColumn,
				@RequestParam(value="keyword", required=false) String keyword,
				HttpSession session
			) {
		
		QBoardBean bb = qdao.selectContent(q_num);
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		String joinType = "탈퇴함";
		try {
			joinType = ub.getU_jointype();
		} catch(NullPointerException e) {}
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("bb",bb);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		model.addAttribute("joinType",joinType);
		
		return viewPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String goUpdate(
			Model model,
			HttpServletResponse response,
			@RequestParam(value="pageNumber",required = false) int pageNumber,
			@RequestParam(value="q_ref",required = false) int q_ref,
			@RequestParam(value="q_re_step",required = false) int q_re_step,
			@RequestParam(value="q_re_level",required = false) int q_re_level,
			@RequestParam("q_password") String q_password,
			@RequestParam("whatColumn") String whatColumn,
			@RequestParam("keyword") String keyword,
			HttpServletRequest request, HttpSession session,
			@ModelAttribute("bb") QBoardBean bb
		) throws IOException {
		
		int q_num = bb.getQ_num();
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");

		String joinType = "탈퇴함";
		try {
			joinType = ub.getU_jointype();
		} catch(NullPointerException e) {}
		
		ModelAndView mav = new ModelAndView();
		QBoardBean bb2 = qdao.selectContent(q_num);
		
		if(q_password.equals(bb2.getQ_password())) {
			mav.setViewName(gotoPage+"?pageNumber="+pageNumber);
			
			bb.setQ_ref(q_ref);
			bb.setQ_subject(bb.getQ_subject());
			bb.setQ_re_step(q_re_step);
			bb.setQ_re_level(q_re_level);
			bb.setQ_ip(request.getRemoteAddr());
			bb.setQ_regdate(new Timestamp(System.currentTimeMillis()));
			
			qdao.updateBoard(bb);
			
			return gotoPage+"?q_num="+q_num+"&pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword;
			
		} else {
		    model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", "qUpdate.qb?q_num="+q_num+"&pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
			model.addAttribute("bb",bb);
			model.addAttribute("joinType",joinType);
			return viewPage2;
		}
	}
}
