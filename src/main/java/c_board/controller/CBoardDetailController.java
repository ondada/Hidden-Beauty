package c_board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import c_board.model.CBoardBean;
import c_board.model.CBoardDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class CBoardDetailController {
	
	@Autowired
	private CBoardDao cdao;
	 
	public final String command="/detail.cb";
	public final String viewPage="cBoardDetail";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String toDetailList(
			Model model,
			@RequestParam("c_num") int c_num,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword) throws Exception {
		cdao.updateReadcount(c_num);
		CBoardBean bb = cdao.selectContent(c_num);
		UsersBean ub = cdao.getUserByCWriter(bb.getC_writer());
		String joinType = "탈퇴함";
		
		try {
			joinType = ub.getU_jointype(); // 테이블에 유저 정보가 없으면? => 탈퇴한 회원입니다 노출되게
		} catch(NullPointerException e){}
		
		model.addAttribute("pageNumber",pageNumber);
		model.addAttribute("whatColumn",whatColumn);
		model.addAttribute("keyword",keyword);
		model.addAttribute("bb",bb);
		model.addAttribute("joinType", joinType);
		
		return viewPage;
			
	}
}