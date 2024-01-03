package users.controller;
import java.io.IOException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import users.model.UsersBean;
import users.model.UsersDao;
  

@Controller
public class UsersRegisterController {
	private final String command = "/register.u";
	private final String viewPage = "usersRegisterForm";
	private final String viewPage2 = "usersWelcomeView";
	
	@Autowired
	private UsersDao ud;
	@Autowired
	private ServletContext application;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction() {
		return viewPage;
	}
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String doAction2(@ModelAttribute("ub") UsersBean ub,
						@RequestParam String u_rePassword,
						HttpServletResponse response) throws IOException {
		
		if(!(Boolean) application.getAttribute("flag")) {
			String u_phone = ub.getU_phone().replace(",","-"); // 010-1234-5678
			ub.setU_phone(u_phone);
			
			// 주소 입력을 안 했을 경우 => 이제 required 라서 입력 안했을 경우는 없을거야!
			/*
			if(ub.getU_address().equals(",,")) {
				ub.setU_address("-");
			}
			*/
			
			/* 이 부분 제이쿼리로 띄우는게 나을거 같아서 수정했어요.
			if(!ub.getU_password().equals(u_rePassword)) {
				PrintWriter out = response.getWriter();
				response.setContentType("text/html; charset=UTF-8");
				out.print("<script>alert('비밀번호가 일치하지 않습니다.');</script>");
				out.flush();
				return viewPage;
			}
			*/
			ub.setU_jointype("S");
			
			String email = ub.getU_email().replace(",", "@");
			ub.setU_email(email);
			
			ub.setU_profileimg("");
			ub.setU_intro("");
			ud.register(ub);
			application.setAttribute("flag", true);
		}
		return viewPage2;
	}
}
