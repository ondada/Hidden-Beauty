package users.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import users.model.UsersBean;
import users.model.UsersDao;

@Controller
public class UsersFindIdController {
	private final String command = "/findid.u";
	private final String viewPage = "usersFindIdForm";
	private final String viewPage2 = "usersFindIdResView";
	
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return viewPage;
	}
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@ModelAttribute("ub") UsersBean ub, Model model) {
		String u_phone = ub.getU_phone().replace(",","-"); // 010-1234-5678
		ub.setU_phone(u_phone);
		 
		List<UsersBean> u_lists = ud.findId(ub);
		model.addAttribute("u_lists",u_lists);
		return viewPage2;
	}
}
