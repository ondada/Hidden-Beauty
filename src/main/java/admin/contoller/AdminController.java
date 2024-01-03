package admin.contoller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import admin.model.AdminDao;


@Controller
public class AdminController {

	@Autowired
	private AdminDao adminDao;
	private final String command = "/.admin";
	private final String viewPage = "adminMain";
	 
	@RequestMapping(value=command, method=RequestMethod.GET)
	public String doAction() {
		return viewPage;
	} 
	
}