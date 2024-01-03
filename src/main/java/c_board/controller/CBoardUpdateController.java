package c_board.controller;

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

import c_board.model.CBoardBean;
import c_board.model.CBoardDao;
import users.model.UsersBean;


@Controller
public class CBoardUpdateController {

	@Autowired
	private CBoardDao cdao;
	
	public final String command="/cUpdate.cb";
	public final String viewPage="cBoardUpdate";
	public final String gotoPage="redirect:/cBoardList.cb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String Form(
				Model model,
				@RequestParam("c_num") int c_num,
				@RequestParam("pageNumber") int pageNumber,
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
			@RequestParam(value="c_ref",required = false) int c_ref,
			@RequestParam(value="c_re_step",required = false) int c_re_step,
			@RequestParam(value="c_re_level",required = false) int c_re_level,
			@RequestParam("c_password") String c_password,
			@RequestParam("whatColumn") String whatColumn,
			@RequestParam("keyword") String keyword,
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
		
		ModelAndView mav = new ModelAndView();
		CBoardBean bb2 = cdao.selectContent(c_num);
		
		if(c_password.equals(bb2.getC_password())) {
			mav.setViewName(gotoPage+"?pageNumber="+pageNumber);
			
			bb.setC_ref(c_ref);
			bb.setC_subject(bb.getC_subject());
			bb.setC_re_step(c_re_step);
			bb.setC_re_level(c_re_level);
			bb.setC_ip(request.getRemoteAddr());
			bb.setC_regdate(new Timestamp(System.currentTimeMillis()));
			
			cdao.updateBoard(bb);
			
			return gotoPage+"?c_num="+c_num+"&pageNumber="+pageNumber;
			
		} else {
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.print("<script>alert('잘못된 비밀번호입니다.');</script>");
		    out.flush();
		    model.addAttribute("pageNumber",pageNumber);
			model.addAttribute("bb",bb);
			model.addAttribute("whatColumn",whatColumn);
			model.addAttribute("keyword",keyword);
			model.addAttribute("joinType",joinType);
			return viewPage;
		}
	}
}
