package c_board.controller;

import java.io.IOException;
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

import c_board.model.CBoardBean;
import c_board.model.CBoardDao;
import users.model.UsersBean;


@Controller
public class CBoardReplyController {

	@Autowired
	private CBoardDao cdao;
	
	public final String command="/cReply.cb";
	public final String viewPage="cBoardReply";
	public final String gotoPage="redirect:/cBoardList.cb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String replyform(
				Model model,
				@RequestParam("c_num") int c_num,
				@RequestParam("pageNumber") int pageNumber,
				@RequestParam("c_ref") int c_ref,
				@RequestParam("c_re_step") int c_re_step,
				@RequestParam("c_re_level") int c_re_level,
				@RequestParam(value="whatColumn", required=false) String whatColumn,
				@RequestParam(value="keyword", required=false) String keyword,
				HttpSession session
			) {
		
		CBoardBean bb = cdao.selectContent(c_num);
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		String joinType = "탈퇴함";
		try {
			joinType = ub.getU_jointype();
		} catch(NullPointerException e) {}
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("c_ref",c_ref);
		model.addAttribute("c_re_step",c_re_step);
		model.addAttribute("c_re_level",c_re_level);
		model.addAttribute("bb",bb);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		model.addAttribute("joinType",joinType);
		
		return viewPage;
	}
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String goReply(
			Model model,
			HttpServletResponse response,
			@RequestParam(value="pageNumber",required = false) int pageNumber,
			@RequestParam(value="c_ref",required = false) int c_ref,
			@RequestParam(value="c_re_step",required = false) int c_re_step,
			@RequestParam(value="c_re_level",required = false) int c_re_level,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			HttpServletRequest request,
			@ModelAttribute("bb") @Valid CBoardBean bb,
			BindingResult br, HttpSession session
		) throws IOException {
		
		int c_num = bb.getC_num();
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		
		String joinType = "탈퇴함";
		try {
			joinType = ub.getU_jointype();
		} catch(NullPointerException e) {}
		
		if(br.hasErrors()) {
			
			model.addAttribute("pageNumber",pageNumber);
			model.addAttribute("c_num",c_num);
			model.addAttribute("bb", bb);
			model.addAttribute("whatColumn",whatColumn);
			model.addAttribute("keyword",keyword);
			model.addAttribute("joinType",joinType);
			
			return viewPage;
		}
		
		bb.setC_ref(c_ref);
		bb.setC_subject("[답글] "+bb.getC_subject());
		bb.setC_re_step(c_re_step);
		bb.setC_re_level(c_re_level);
		bb.setC_ip(request.getRemoteAddr());
		bb.setC_regdate(new Timestamp(System.currentTimeMillis()));
		System.out.println("답글 작성자의 프로필:"+bb.getC_profileimg());
		cdao.replyProc(bb);
		
		return gotoPage+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword;
	}
	
}
