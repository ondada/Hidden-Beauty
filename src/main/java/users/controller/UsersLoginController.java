package users.controller;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
public class UsersLoginController {
	private final String command = "login.u";
	private final String viewPage = "usersLoginForm";
	private final String gotoPage = "redirect:/.main";
	private final String adminPage = "redirect:/selectFeedback.admin";
	private final String redirect = "redirect";
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(@RequestParam(required = false) String u_id) {
		return viewPage;
	}
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@RequestParam String u_id,
						@RequestParam String u_password,
						HttpSession session,
						Model model) {
		
		UsersBean ub = ud.getUserById(u_id);
		if(ud.getUserById(u_id) != null) { // 가입한 회원이라면
			
			if(ub.getU_report() > 5) {
				model.addAttribute("msg","정지된 계정으로는 로그인 하실 수 없습니다.");
				model.addAttribute("url",command+"?u_id="+u_id);
			} else if(!ub.getU_password().equals(u_password)) { // 비밀번호가 틀렸다면
				model.addAttribute("msg","비밀번호가 틀렸습니다.");
				model.addAttribute("url",command+"?u_id="+u_id);
			} else { // 비밀번호가 맞다면
				// 아이디 session 설정
				session.setAttribute("loginInfo", ub);
				if(ub.getU_id().equals("admin"))
					return adminPage;
				else {
					if(session.getAttribute("destination") != null) {
						if(String.valueOf(session.getAttribute("destination")).equals(".main")) {
							return "redirect:/"+String.valueOf(session.getAttribute("destination"));
						} else {
							return String.valueOf(session.getAttribute("destination"));
						}
					}
					return gotoPage;
				}
			}
			
			
		} else { // 가입하지 않은 회원이라면
			model.addAttribute("msg","존재하지 않는 회원입니다.");
			model.addAttribute("url",command+"?u_id="+u_id);
		}
		return redirect;
	}
}