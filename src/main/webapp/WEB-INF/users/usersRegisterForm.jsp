<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	application.setAttribute("flag", false);
%>

<style>
	table{
		margin: auto; 
		width: 800px;
		height: 650px;
		font-family: 'RIDIBatang';
	}
	th{
		background: #EAEAEA; 
		padding-left: 30px;
	}
	td{
		padding: 0px 10px 0px 10px; 
	}
	body{
		padding-top: 90px;
	}
	#btn{
		width: 100px;
		height: 35px;
		margin-left: 5px;
		background: #EAEAEA;
		border: none;
		border-radius: 3px;
		font-size: 11pt;
	}
	#btn:hover{
		background: #BDBDBD;
		color: white;
	}
	#searchBtn{
		width: 120px;
		height: 35px;
		margin-left: 5px;
		background: #EAEAEA;
		border: none;
		border-radius: 3px;
		font-size: 11pt;
	}
	#searchBtn:hover{
		background: #BDBDBD;
		color: white;
	}
	#subBtn{
		width: 120px;
		height: 40px;
		margin-left: 5px;
		color: white;
		background: #8C8C8C;
		border: none;
		border-radius: 3px;
		font-size: 11pt;
	}
	#subBtn:hover{
		background: #EAEAEA;
		color: black;
	}
	#resetBtn{
		width: 120px;
		height: 40px;
		margin-left: 5px;
		background: #EAEAEA;
		border: none;
		border-radius: 3px;
		font-size: 11pt;
	}
	#resetBtn:hover {
		background: #BDBDBD;
		color: white;
	}
}
</style>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	

	function zipClick(){
		document.getElementById("searchBtn").click();
	}
	function inputDomain(){
		var select = document.getElementById("selectDomain");
		var domainArea = document.getElementById("domainArea");
		
		domainArea.value = "";
		if(select.value != "직접 입력"){
			domainArea.value = select.value;
		}
	}

	$(function() {
		var use;
		var isDupCheck = false;
		var regex = RegExp(/^[a-z0-9]{4,16}$/); // ^[a-z0-9]{4,16}$
		var regexPw = RegExp(/^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/); // ^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$
		var pwSame = false;
		
		$("input[name='dupCheck']").click(function() {
			//alert();
			
			if ($("input[name='u_id']").val() == "") {
				alert("아이디를 입력하세요.");
				$("input[name='u_id']").focus();
				return false;
			}
			
			if (!regex.test($("input[name='u_id']").val())) {
				alert("아이디는 영문 소문자/숫자만 사용하여 4~16자로 입력하세요.");
				$("input[name='u_id']").focus();
				return false;
			}

			isDupCheck = true; // 중복체크 진행했다는 의미

			$.ajax({ // ajax 함수 사용하기
				url : "id_check_proc.u", // 클릭 시 이쪽으로 갈 수 있도록 url 설정.
				data : ({ // data로는 id 값을 가져가도록 설정. 
					u_id : $('input[name="u_id"]').val()
				}),
				success : function(data) { // 성공한다면 data 값을 알림으로 띄우도록 설정.
					if ($.trim(data) == "yes") { // trim() 을 이용해 양쪽 공백 제거한 후 비교
						$("#titleMessage").html("<font color=red>중복된 아이디입니다.</font>");
						$("#titleMessage").show(); // 비교 결과에 따라 span 태그 안에 내용 넣어주고 보이도록 설정하기.
						use = "impossible"
					} else {
						$("#titleMessage").html("등록 가능합니다.");
						$("#titleMessage").show();
						use = "possible"
					}
				}
			});
		});
		
		$('input[name=u_id]').keydown(function() {
			isDupCheck = false;
			use = "";
			$("#titleMessage").hide();
		});
		// 비밀번호란에서 키업이벤트가 발생하면, 그때 비밀번호를 가져와서
		// 정규표현식 테스트를 진행한다.
		// 만약 false면 정규표현식을 만족하지 않는다는 alert를 띄운다.
		$('#u_password').keyup(function() {
			if(!regexPw.test($("input[name='u_password']").val())){
				// border를 붉은 색 처리.
				$('#u_password').css("border-color","red");
			} else {
				$('#u_password').css("border-color","green");
			}
		});
		$('#u_rePassword').keyup(function() {
			var u_password = $('#u_password').val();
			var u_rePassword = $('#u_rePassword').val();
			$('#pwMessage').css({"display":"block"});
			
			if(u_password == u_rePassword){
				$('#u_rePassword').css("border-color","green");
				pwSame = true;
				$('#pwMessage').html("일치합니다.");
			} else {
				$('#u_rePassword').css("border-color","red");
				pwSame = false;
				$('#pwMessage').html("<font color='red'>일치하지 않습니다.</font>");
			}
		});
		
		$('#subBtn').click(function() {
			if (isDupCheck == false) {
				alert("아이디 중복체크를 진행하세요.");
				return false;
			}
			if (use == "impossible") {
				alert("중복된 아이디로는 가입할 수 없습니다.");
				return false;
			}
			if (pwSame == false) {
				alert("비밀번호 확인란을 동일하게 입력해주세요.");
				return false;
			} 
		});
		
	});
</script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<%@ include file="../views/header.jsp" %>

<div id="center" style="text-align: center;">
	<br><br><br><br>
	<div>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 40pt; font-weight: bold;">WELCOME!</span>
		<br><br> 
		<span style="font-family: 'RIDIBatang'; font-size: 12pt; color: graytext; line-height: 180%;">
			<u>FIND YOUR Hidden Beauty</u><br>
			회원가입을 환영합니다.
		</span>
		<br><br><br><br>
	</div>
	<div>
		<form action="register.u" method="post">
		<table id="regTable">
			<tr style="border-top: 2px solid graytext;">
				<th width="20%">이름</th>
				<td width="80%">
					<input type="text" class="form-control" name="u_name" value="${ub.u_name}" style="width: 50%;" maxlength="10" placeholder="10글자 이내로 입력하세요." required>
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>아이디</th>
				<td>
					<input type="text" class="form-control" name="u_id" value="${ub.u_id}" placeholder="영문 소문자/숫자 사용, 4~16자" pattern="^[a-z0-9]{4,16}$" style="width: 50%; display: inline-block;" maxlength="16" required> 
					<input type="button" name="dupCheck" id="btn" value="중복체크">
					&nbsp;&nbsp;
					<span id="titleMessage" class="message" style="padding: 0px; margin: 0px;"></span>
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>비밀번호</th>
				<td>
					<input type="password" class="form-control" name="u_password" id="u_password" value="${ub.u_password }" placeholder="영문 대소문자/숫자 사용, 8자~16자" pattern="^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$" maxlength="16" required style="width: 550px;">
					<!-- <font style="color: green;"><ion-icon name="checkmark-circle-outline"></ion-icon></font> -->
					<!-- <font style="color: red;"><ion-icon name="close-circle-outline"></ion-icon></font> -->
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>비밀번호 확인</th>
				<td> 
					<input type="password" class="form-control" name="u_rePassword" id="u_rePassword" maxlength="16" onkeyup="isSame()" required style="width: 550px;">
					<div style="display: none; padding: 5px 0px 0px 5px; font-size: 10pt;" id="pwMessage">확인</div>
					<!-- <font style="color: green;"><ion-icon name="checkmark-circle-outline"></ion-icon></font>
					<font style="color: red;"><ion-icon name="close-circle-outline"></ion-icon></font> -->
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>전화번호</th>
				<td>
					<c:set var="firstList">010, 011, 016, 017, 018, 019</c:set>
					<select name="u_phone" class="form-select" style="width: 20%; display: inline;">
						<c:forEach var="first" items="${firstList }">
							<option value="${first }" <c:if test="${fn:split(ub.u_phone, '-')[0] eq first }">selected</c:if>>${first }</option>
						</c:forEach>
					</select>
					&nbsp;-&nbsp;
					<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[1]}" maxlength="4" required>
					&nbsp;-&nbsp;
					<input type="text" class="form-control" style="width: 20%; display: inline;" name="u_phone" value="${fn:split(ub.u_phone, '-')[2]}" maxlength="4" required>
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>이메일</th>
				<td>
					<input type="text" class="form-control" name="u_email" style="width: 33%; display: inline-block;" value="${fn:split(ub.u_email, '@')[0]}" maxlength="20" required>
					@
					<input type="text" class="form-control" id="domainArea" name="u_email" style="width: 33%; display: inline-block;" value="${fn:split(ub.u_email, '@')[1]}" maxlength="15" required>
					<c:set var="domains">직접 입력,naver.com,daum.net,google.com,hanmail.net</c:set>
					<select class="form-select" id="selectDomain" style="width: 25%; display: inline-block;" onchange="inputDomain()">
						<c:forEach var="domain" items="${domains}">
							<option value="${domain}">${domain}
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr style="border-top: 1px solid #BDBDBD;">
				<th>주소</th>
				<td>
					<input type="hidden" id="sample4_jibunAddress">
					<input type="hidden" id="sample4_extraAddress">
					<input type="text" class="form-control" style="width: 70%; display: inline; margin-bottom: 10px;" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[0]}" id="sample4_postcode" placeholder="먼저 우편번호 찾기 버튼을 눌러주세요." onClick="zipClick()" readonly>
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" id="searchBtn"><br>
					<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[1]}" id="sample4_roadAddress" placeholder="도로명주소" style="margin-bottom: 10px;" onClick="zipClick()" readonly>
					<span id="guide" style="color:#999; display:none"></span>
					<input type="text" class="form-control" name="u_address" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[2]}" id="sample4_detailAddress" placeholder="상세주소" required>
				</td>
			</tr>
			<tr style="border-bottom: 2px solid graytext; border-top: 1px solid #BDBDBD;">
				<th>퍼스널 컬러</th>
				<td>
					<c:set var="pcList">잘 모르겠음,봄 라이트,봄 브라이트,여름 라이트,여름 브라이트,여름 뮤트,가을 뮤트,가을 스트롱,가을 딥,겨울 브라이트,겨울 딥</c:set>
					<select name="u_color" class="form-select">
						<c:forEach var="pc" items="${pcList }">
							<option value="${pc }" <c:if test="${pc eq ub.u_color }">selected</c:if>>${pc }</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<br><br>
					<input type="submit" value="가입하기" id="subBtn">&nbsp;
					<input type="reset" value="초기화" id="resetBtn">
				</td>
			</tr>
		</table>
	</form>
	</div>
</div>

<%@ include file="../views/footer.jsp" %>