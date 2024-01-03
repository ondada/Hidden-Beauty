package users.controller;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import users.model.UsersBean;
import users.model.UsersDao;
import utility.NaverApi;


@Controller
public class UsersNaverController {
	private final String command = "/naver.u";
	private final String commandDis = "/disnaver.u";
	
	private final String viewPage = "usersWelcomeView2";
	private final String gotoPage = "redirect:/";
	
	@Autowired
	private UsersDao ud;
	private String accessToken;
	private String refreshToken;
	
	// 로그인
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String naverLogin(@RequestParam String code, @RequestParam String state,
							HttpSession session, HttpServletResponse response) {
		NaverApi naverApi = new NaverApi();
		boolean flag = false;
		// 1. 인가 코드 받기
		// 2. 토큰 받기
		Map<String, String> tokens = naverApi.getAccessToken(code, state);
		this.accessToken = tokens.get("accessToken");
		this.refreshToken = tokens.get("refreshToken");
		
		// 3. 사용자 정보 받기
		Map<String, Object> userInfo = naverApi.getUserInfo(this.accessToken);
		String name = String.valueOf(userInfo.get("name"));
	    String id = String.valueOf(userInfo.get("id"));
	    String email = String.valueOf(userInfo.get("email"));
	    String profileImg = String.valueOf(userInfo.get("profile_image"));
	    System.out.println("name = " + name);
	    System.out.println("id = " + id);
	    System.out.println("email = " + email);
	    System.out.println("profileImg = " + profileImg);
	    System.out.println("accessToken = " + this.accessToken);
	   // String uploadPath = servletContext.getRealPath("/resources/uploadFolder/product/");  
	    UsersBean ub = new UsersBean();
      	ub.setU_id(id);
      	ub.setU_name(name);
      	ub.setU_password("");
      	ub.setU_phone("");
      	ub.setU_address(",,");
      	ub.setU_jointype("N");
      	ub.setU_color("잘 모르겠음");
      	ub.setU_email(email);
      	ub.setU_profileimg(profileImg);
      	ub.setU_intro("안녕하세요~!");
      	
      	if(ud.getUserById(id) != null) { // 로그인 한 네이버 계정이 users 테이블에 저장되어있으면
      		flag = true;
      	} else {
      		ud.register(ub);
      	}
      	session.setAttribute("loginInfo", ub);
      	if(flag) {
      		if(session.getAttribute("destination") != null) {
      			return String.valueOf(session.getAttribute("destination"));
      		} else {
      			return gotoPage; // 메인화면
      		}
      	} else {
      		return viewPage; // 웰컴화면
      	}
	}
	// 연동해제
	@RequestMapping(value = commandDis)
	public String naverDisconnect(@RequestParam(required = false) String admin) {
		NaverApi naverApi = new NaverApi();
		// 연동해제 1단계. 접근 토큰 유효성 체크
		String message = naverApi.isTokenValid(this.accessToken);
		// 2단계. 접근 토큰이 유효하지 않다면 재발급. 유효하다면 3단계로 가기.
		if(!message.equals("success")) {
			this.accessToken = naverApi.getAccessTokenAgain(this.refreshToken);
		} 
		// 3단계. 연동해제(접근 토큰 삭제)
		String result = naverApi.naverDisconnect(this.accessToken);
		System.out.println(result+": 네이버 연동해제 성공");
		
		if(admin == null)
			return gotoPage + ".main";
		else
			return gotoPage + "usersList.admin";
	}
}
