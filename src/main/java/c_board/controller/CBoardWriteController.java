package c_board.controller;
import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
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
public class CBoardWriteController {

	@Autowired
	private CBoardDao cdao;
	
	public final String command="/write.cb"; 
	public final String viewPage="cBoardWrite";
	public final String gotoPage="redirect:/cBoardList.cb";
	
	@RequestMapping(value=command,method=RequestMethod.GET)
	public String writeform(@RequestParam(value="pageNumber", required=false) String pageNumber,
							@RequestParam(value="whatColumn", required=false) String whatColumn,
							@RequestParam(value="keyword", required=false) String keyword,
							Model model, HttpSession session) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		String joinType = "탈퇴함";
		try {
			joinType = ub.getU_jointype();
		} catch(NullPointerException e) {}
		
		model.addAttribute("pageNumber", pageNumber);
		model.addAttribute("whatColumn", whatColumn);
		model.addAttribute("keyword", keyword);
		model.addAttribute("joinType", joinType);
		return viewPage;
	} 
	
	@RequestMapping(value=command,method=RequestMethod.POST)
	public String gowrite(
				HttpServletRequest request, HttpSession session,
				@ModelAttribute("bb") 
				@Valid CBoardBean bb,
				BindingResult br
			) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
		
		if(br.hasErrors()) {
			return viewPage;
		}
		
		bb.setC_ip(request.getRemoteAddr());
		bb.setC_regdate(new Timestamp(System.currentTimeMillis()));
		
		try {
			if(ub.getU_profileimg() == null) {
				bb.setC_profileimg("");
			} else {
				bb.setC_profileimg(ub.getU_profileimg());
			}
		} catch (NullPointerException e) {
			bb.setC_profileimg("");
		}
		bb.setC_subject_rb("");
		cdao.writeBoard(bb);
		return gotoPage;
		
	}
	
}
