package users.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import c_board.model.CBoardDao;
import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class UsersProfileController {
	private final String command = "profile.u";
	private final String viewPage = "usersProfileView";
	private final String redirect = "redirect";
	
	@Autowired
	private UsersDao ud;
	@Autowired
	private CBoardDao cb;
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String profile(@RequestParam String c_writer, Model model) {
		UsersBean ub = ud.getUserById(c_writer); 
		if(ub == null) {
			model.addAttribute("msg", "탈퇴한 회원입니다."); 
			return redirect;
		} 
		model.addAttribute("ub",ub);
		model.addAttribute("c_writer",c_writer);
		model.addAttribute("postCount",cb.getTotalCountOfMainPost(c_writer));
		model.addAttribute("commentCount",cb.getTotalCountOfComment(c_writer));
		return viewPage;
	}
}
