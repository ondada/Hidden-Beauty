package users.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import users.model.EmailSender;
import users.model.UsersDao;
import utility.Email;

@Controller
public class UsersEmailController {
	private final String command = "/email.u";
	private final String viewPage = "usersFindPwResView";
	
	@Autowired
    private EmailSender emailSender;
	@Autowired
	private UsersDao ud;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String email(@RequestParam String toEmail,
					@RequestParam String u_id, HttpServletRequest request) {
		
		//임시 비밀번호 생성 
		String tempPw = UUID.randomUUID().toString().replace("-", ""); //-를 제거
		tempPw = tempPw.substring(0,10);
		// 임시 비밀번호 발급 이메일 발송
		Email email = new Email();
		email.setFromEmail("hiddenbyuti23@gmail.com");
		email.setToEmail(toEmail);
		email.setTitle("Hidden Beauty 임시 비밀번호 안내 이메일입니다.");
		//  margin-left: 40%;
		String content = "";
		content += "<div style='text-align: center;'>";
		content += "<img src='cid:image' style='width: 20%;'><br><hr style='width: 50%;'>";
		content += "<h2>임시 비밀번호 발급 안내</h2>";
		content += u_id+"님,<br>";
		content += "회원님의 임시 비밀번호를 아래와 같이 보내드립니다.</span><br><br>";
		content += "<span style='background-color: #B3B3CE; width: 30%;'>임시 비밀번호: "+tempPw+"</span><br><br>";
		content += "<span style= 'color: graytext'>※ 임시 비밀번호로 로그인 한 후 회원정보변경 페이지에서 다시 비밀번호를 변경해 주세요.</span><br><br>";
		content += "</div>";
		email.setContent(content);
		System.out.println("메일전송: "+emailSender.sendMail(email));
		ud.updatePassword(u_id, tempPw);
		
		return viewPage;
	}
}
