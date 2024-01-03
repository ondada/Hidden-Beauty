package users.controller;
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
public class UsersReportContoller {
	private final String command = "/report.u";
	private final String viewPage = "redirect";
	
	@Autowired
	private UsersDao ud;
	@Autowired
	private CBoardDao cd;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam("u_id") String u_id, 
							@RequestParam("url") String url, 
							@RequestParam("c_num") int c_num,
							@RequestParam(value="pageNumber", required=false) String pageNumber, 
							@RequestParam(value="whatColumn", required=false) String whatColumn, 
							@RequestParam(value="keyword", required=false) String keyword, 
							Model model) {
		
		UsersBean ub = ud.getUserById(u_id);
		
		if(ub == null) {
			model.addAttribute("msg", "탈퇴 회원은 신고할 수 없습니다.");
			model.addAttribute("url", url+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
			
		} else {
			ud.updateReport(u_id); // 계정에 신고누적
			cd.updateReport(c_num); // 게시글에 신고누적
			model.addAttribute("msg", "신고 처리되었습니다.");
			model.addAttribute("url", url+"?pageNumber="+pageNumber+"&whatColumn="+whatColumn+"&keyword="+keyword);
			
			if(ub.getU_report() > 3) {
				// 이쪽에 게시글 글제목 rb로 옮기고 제목 변경하는 코드 넣을 예정.
				// 마이페이지에서 1:1 문의로 신고 게시글 복원 요청할 수 있도록 처리
				// 신고자, 신고 사유까지 구현하기엔 시간도 부족하고, 게시판 특화도 아닌데 과하게 공들이는 느낌
			}
		}

		return viewPage;
	}
	
}
