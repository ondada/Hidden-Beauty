package q_board.controller;
import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import q_board.model.QBoardBean;
import q_board.model.QBoardDao;
import users.model.UsersBean;


@Controller
public class QBoardWriteController {

	@Autowired
	private QBoardDao qdao;
	
	public final String command="/write.qb"; 
	public final String viewPage="qBoardWrite";
	public final String gotoPage="redirect:/qBoardList.qb";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
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
		model.addAttribute("joinType",joinType);
		
		return viewPage;
	} 
	
	@RequestMapping(value=command, method=RequestMethod.POST)
	public String gowrite(HttpServletRequest request, Model model, @ModelAttribute("qb") QBoardBean qb, HttpSession session) {
		
		UsersBean ub = (UsersBean)session.getAttribute("loginInfo");

		String joinType = "탈퇴함";
				try {
					joinType = ub.getU_jointype();
				} catch(NullPointerException e) {}
		
		qb.setQ_ip(request.getRemoteAddr());
		qb.setQ_regdate(new Timestamp(System.currentTimeMillis()));
		
		try {
			if(ub.getU_profileimg() == null) {
				qb.setQ_profileimg("");
			} else {
				qb.setQ_profileimg(ub.getU_profileimg());
			}
		} catch(NullPointerException e) {
			qb.setQ_profileimg("");
		}
		
		qdao.writeBoard(qb);
		model.addAttribute("bb", qb);
		model.addAttribute("joinType",joinType); 
		
		return gotoPage;
		
	}
	
}
