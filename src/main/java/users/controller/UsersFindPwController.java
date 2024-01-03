package users.controller;



import java.io.UnsupportedEncodingException;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class UsersFindPwController {
	private final String command = "/findpw.u";
	private final String viewPage = "usersFindPwForm";
	private final String gotoPage = "redirect:/email.u";
	private final String redirect = "redirect";
	
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam(required = false) String u_id,
						@RequestParam(required = false) String u_name) {
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@RequestParam String u_id,
						@RequestParam String u_name,
						Model model) throws UnsupportedEncodingException {
		UsersBean ub = ud.getUserById(u_id);
		if(ub == null) {
			model.addAttribute("msg", "존재하지 않는 회원입니다."); 
			model.addAttribute("url", "findpw.u");
			return redirect;
		}
		if(ub.getU_email().equals("null")) {
			model.addAttribute("msg", "회원정보에서 이메일을 기입해주세요.");
			model.addAttribute("url", "findpw.u");
			return redirect;
		}
		if(!ub.getU_name().equals(u_name)) {
			model.addAttribute("msg", "이름을 다시 확인하세요.");
			model.addAttribute("url", "findpw.u?u_id="+u_id+"&u_name="+u_name);
			return redirect;
		}
		return gotoPage + "?toEmail="+ub.getU_email()+"&u_id="+ub.getU_id();
	}
}
