package users.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class UsersChangepwController {
	private final String command = "changepw.u";
	private final String viewPage = "usersChangepwForm";
	private final String gotoPage = "redirect";
	
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam(required = false) String old_password,
					@RequestParam(required = false) String new_password,
					@RequestParam(required = false) String new_password_chk) {
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@RequestParam String u_id,
						@RequestParam String old_password,
						@RequestParam String new_password,
						@RequestParam String new_password_chk,
						HttpSession session,
						Model model) {
		
		UsersBean ub = ud.getUserById(u_id); 
		
		if(ub.getU_password().equals(old_password)) {
			if(new_password.equals(new_password_chk)) { 
				ud.updatePassword(u_id, new_password);
				model.addAttribute("msg", "비밀번호가 변경되었습니다.");
				model.addAttribute("url", "update.u?u_id="+u_id);
			} else {
				model.addAttribute("msg", "변경하실 비밀번호가 일치하지 않습니다.");
				model.addAttribute("url", command+"?old_password="+old_password+"&new_password="+new_password+"&new_password_chk="+new_password_chk);
			}
		} else {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("url", command+"?old_password="+old_password+"&new_password="+new_password+"&new_password_chk="+new_password_chk);
		}
		return gotoPage;
	}
}
