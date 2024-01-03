package users.controller;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import users.model.UsersBean;
import users.model.UsersDao;
import utility.KakaoApi;


@Controller
public class UsersKakaoController {
	private final String command = "/kakao.u";
	private final String commandDis = "/diskakao.u";
	
	private final String viewPage = "usersWelcomeView2";
	private final String gotoPage = "redirect:/";
	
	@Autowired
	private UsersDao ud;
	private String accessToken;
	private String refreshToken;
	
	// 로그인
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam String code, HttpSession session) {
		KakaoApi kakaoApi = new KakaoApi();
		boolean flag = false;
		// 1. 인가 코드 받기 (@RequestParam String code)

	    // 2. 토큰 받기
		Map<String, String> tokens = kakaoApi.getAccessToken(code);
		this.accessToken = tokens.get("accessToken");
		this.refreshToken = tokens.get("refreshToken");
		
	    // 3. 사용자 정보 받기
	    Map<String, Object> userInfo = kakaoApi.getUserInfo(this.accessToken);

	    String nickname = String.valueOf(userInfo.get("nickname"));
	    String id = String.valueOf(userInfo.get("id"));
	    String email = String.valueOf(userInfo.get("email"));
	    String profileImg = String.valueOf(userInfo.get("profile_image_url"));

	    System.out.println("nickname = " + nickname);
	    System.out.println("id = " + id);
	    System.out.println("email = " + email);
	    System.out.println("profileImg = " + profileImg);
	    System.out.println("accessToken = " + this.accessToken);

	    UsersBean ub = new UsersBean();
      	ub.setU_id(id);
      	ub.setU_name(nickname);
      	ub.setU_password("");
      	ub.setU_phone("");
      	ub.setU_address(",,");
      	ub.setU_jointype("K");
      	ub.setU_color("잘 모르겠음");
      	ub.setU_email(email);
      	ub.setU_profileimg(profileImg);
      	ub.setU_intro("안녕하세요~!");
      	
      	if(ud.getUserById(id) != null) { // 로그인 한 카카오 계정이 users 테이블에 저장되어있으면
      		flag = true;
      	} else {
      		ud.register(ub);
      	}
      	session.setAttribute("loginInfo", ub);
      	if(flag)
      		if(session.getAttribute("destination") != null) {
      			System.out.println("목적지 있음");
      			return String.valueOf(session.getAttribute("destination"));
      		} else {
      			System.out.println("목적지 없음");
      			return gotoPage; // 메인화면
      		}
	    else 
	    	return viewPage;
	}
	
	// 연동해제
	@RequestMapping(value = commandDis)
	public String kakaoDisconnect(@RequestParam(required = false) String admin) {
		KakaoApi kakaoApi = new KakaoApi();
		// 연동해제 1단계. 접근 토큰 유효성 체크
		String id = kakaoApi.isTokenValid(this.accessToken);
		// 2단계. 접근 토큰이 유효하지 않아서 id에 null이 들어온다면 접근 토큰 재발급. 유효하다면 3단계로 가기.
		if(id.equals("null")) {
			this.accessToken = kakaoApi.getAccessTokenAgain(this.refreshToken);
		}
		// 3단계. 연동해제(접근 토큰 삭제)
		id = kakaoApi.kakaoDisconnect(this.accessToken);
		System.out.println("연동해제한 카카오 회원 id: "+id);
		
		if(admin == null)
			return gotoPage + ".main";
		else
			return gotoPage + "usersList.admin";
	}
}
