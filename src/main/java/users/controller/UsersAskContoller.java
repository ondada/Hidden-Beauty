package users.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import users.model.RestoreBean;
import users.model.UsersBean;
import users.model.UsersDao;


@Controller
public class UsersAskContoller {
	private final String command = "/ask.u";
	private final String viewPage = "usersAsk";
	private final String redirect = "redirect";
	
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(Model model) {
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insert(Model model, RestoreBean rb) {
		
		UsersBean ub = ud.getUserById(rb.getU_id());

		if(ub == null) { 
			model.addAttribute("msg", "가입되지 않은 아이디입니다.");
			model.addAttribute("url", "ask.u?u_id="+rb.getU_id()+"&u_email="+rb.getU_email()+"&rs_content="+rb.getRs_content());
		} else {
			
			try {
				ud.insertRestore(rb);
				model.addAttribute("msg", "등록 되었습니다. 회신을 기다려주세요.");
				model.addAttribute("url", "close");
			} catch(DuplicateKeyException e) {
				model.addAttribute("msg", "이미 접수하신 내역이 존재합니다. 회신을 기다려주세요.");
				model.addAttribute("url", "close");
			}
			
		}
		
		return redirect;
	}
	
}
