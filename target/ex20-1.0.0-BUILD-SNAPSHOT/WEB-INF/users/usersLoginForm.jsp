<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ include file="../views/header.jsp" %>

<style>
	table{
		font-family: 'RIDIBatang'; 
		font-size: 11pt;
		width: 400px;
		height: 100px; 
	}
	body{
		padding-top: 90px;
	}
	#loginBtn{
		width: 100%;
		height: 90%;
		margin-left: 5px;
		color: white;
		background: #7C81BB;
		border: none;
		border-radius: 3px;
	}
	#loginBtn:hover{
		background: #B3B3CE;
	}
	#verticalLine{
		width: 1px;
		height: 100%;
		background: #D5D5D5; 
		margin: auto;
		display: inline-block;
		top: -10px;
		position: relative;
	}
	#etcBtn{
		width: 100px;
		height: 30px;
		margin-left: 5px;
		background: #EAEAEA;
		border: none;
		border-radius: 3px;
		font-size: 10pt;
	}
	#etcBtn:hover {
		background: #BDBDBD;
		color: white;
	}
}
</style>
<script>
function goQnA(){ // 브라우저 사이즈 기준으로 팝업창 가운데 뜨게 설정.
    var popupW = 500;
	var popupH = 600;
	var popupX = Math.round(window.screenX + (window.outerWidth/2) - (popupW/2));
	var popupY = Math.round(window.screenY + (window.outerHeight/2) - (popupH/2));
	
	var popupWindow = window.open('ask.u', 'login', 'status=no, height='+popupH+', width='+popupW+', left='+popupX+', top='+popupY);
	popupWindow.onresize = (_=>{popupWindow.resizeTo(popupW+20,popupH+70);}) // 팝업창으로 열리는 화면은 사이즈 조절하지 못하도록 설정해두기.
}
</script>

<div id="center" style="text-align: center;">
<br><br><br><br>
<div>
	<span style="font-family: 'MaruBuri-Regular'; font-size: 40pt; font-weight: bold;">LOGIN</span><br>
	<span style="font-family: 'RIDIBatang'; font-size: 12pt; color: graytext;">회원 전용 서비스</span><br><br><br>
	<span style="font-family: 'RIDIBatang'; font-size: 12pt; line-height: 180%;">
		로그인 이후에 이용하실 수 있습니다.<br>
		아이디와 비밀번호를 입력해주세요.<br>
		아직 회원이 아니시라면, 회원가입을 먼저 진행해주세요.
	</span>
</div>
<br><br><br>

<hr style="width: 70%; margin: auto;">
<br><br>
<form action="login.u" method="post">
	<table style="margin: auto;">
		<tr>
			<td>
				<table>
					<tr>
						<td width="20%">아이디</td> 
						<td width="60%"><input type="text" name="u_id" value="${param.u_id }" class="form-control" required></td>
						<td width="20%" rowspan="2"><input type="submit" value="로그인" id="loginBtn"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="u_password" class="form-control" required></td>
					</tr>
				</table><br>
				<%
				    String clientId = "7e2tSZMcps1aVtINdSJv";//애플리케이션 클라이언트 아이디값";
				    String redirectURI = URLEncoder.encode("http://localhost:8080/ex20/naver.u", "UTF-8");
				    SecureRandom random = new SecureRandom(); // 클라이언트 시크릿A98jpGEn8v
				    String state = new BigInteger(130, random).toString();
				    // 네이버 로그인 인증을 요청하는 apiURL
				    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
				    apiURL += "&client_id=" + clientId;
				    apiURL += "&redirect_uri=" + redirectURI;
				    apiURL += "&state=" + state;
				    session.setAttribute("state", state);
				    
				%>
				<div id="IdLogin" align="left">
					<!-- 네이버 로그인 버튼 생성 위치 -->
					&nbsp;&nbsp;<a href="<%=apiURL%>"><img  height="50" src="<%=request.getContextPath()%>/resources/image/btnW_완성형.png"></a>
					<!-- 카카오 로그인 버튼 생성 위치 -->
					<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=a8d5622ce00b9080e03be1948663093a&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fex20%2Fkakao.u"><img  height="48" src="<%=request.getContextPath()%>/resources/image/kakao_login_medium_narrow.png"></a>
				</div>
			</td>
			<td align="right" valign="middle">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<div id="verticalLine"></div>
			</td>
			<td>
				<table style="text-align: left; margin-left: 20px; width: 320px;" id="loginTable">
					<tr>
						<td>아직 회원이 아니신가요?</td>
						<td><input type="button" value="회원가입" id="etcBtn" onClick="location.href='register.u'"></td>
					</tr>
					<tr>
						<td>아이디를 잃어버리셨나요?</td>
						<td><input type="button" value="아이디 찾기" id="etcBtn" onClick="location.href='findid.u'"></td>
					</tr>
					<tr>
						<td>비밀번호를 잃어버리셨나요?</td>
						<td><input type="button" value="비밀번호 찾기" id="etcBtn" onClick="location.href='findpw.u'"></td>
					</tr>
					<tr>
						<td>계정이 정지되셨나요?</td>
						<td><input type="button" value="문의하기" id="etcBtn" onClick="goQnA()"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
<br><br>
<hr style="width: 70%; margin: auto;"> 
</div>
<%@ include file="../views/footer.jsp" %>