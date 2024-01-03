package users.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import users.model.UsersDao;


@Controller
public class UsersDupCheckController {
	
	@Autowired
	private UsersDao ud;
	private final String command = "/id_check_proc.u";

	@RequestMapping(value = command)
	@ResponseBody // 이 어노테이션을 붙여주면 앞뒤로 prefix, suffix 가 붙지않은채로 리턴됨
	public String check(@RequestParam("u_id") String u_id) {
		System.out.println("u_id : " + u_id);
		boolean found = ud.findU_id(u_id);
		
		if(found) {
			return "yes";
		} else {
			return "no";
		}
	}
}
