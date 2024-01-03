<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#content_update th {
	text-align: left;
	background: #F6F6F6;
	padding-left: 20px;
}

#content_update {
	width: 90%;
	height: 730px;
	text-align: left;
}

#profileImg {
	border-radius: 50%; 
	width: 130px;
	height: 130px; 
	background-image: url('resources/image/no-image.jpg');
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	left: -10px;
	position: relative;
}
</style>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	var profile, profileImg, profileImgName;
	window.onload = function(){
		profile = document.getElementById('profile');
		profileImg = document.getElementById('profileImg');
		profileImgName = document.getElementById('profileImgName');
		
		profileImg.addEventListener('click', () => profile.click());
		
		/* input에 파일이 업로드되면 change event 가 발생 */
		profile.addEventListener('change', getProfileImage); // getProfileImage 함수 등록
		
		function getProfileImage(e) {
			var profilePathSplit = profile.value.split('\\'); // 프로필 이미지의 경로를 구분자 '\\'로 나누기
			var profileName = profilePathSplit[profilePathSplit.length-1];
			//alert("들어온 프로필 이미지의 이름: "+profileName);
			
	     	const file = e.currentTarget.files[0];
	      	const reader = new FileReader(); // file을 담을 변수
	      	reader.readAsDataURL(file);
	      	reader.onload = (e) => {
	      		// 파일이 로드되면 이미지를 해당 파일로 고치기
	      		profileImg.setAttribute('src', e.target.result);
	      		profileImgName.innerHTML='<a href="javascript:deleteProfileImg();" style="text-decoration: none; font-size: 10pt;"><font color="red">x</font></a> '+profileName;
	        };
	    }
	};
	function deleteProfileImg(){
		profileImg.setAttribute('src', '<%=request.getContextPath()%>/resources/image/no-image.jpg');
		profileImgName.innerHTML='<a href="javascript:deleteProfileImg();" style="text-decoration: none; font-size: 10pt;"><font color="red">x</font></a><span style="font-size: 10pt;">&nbsp;사진을 등록하세요</span>';
	}
	function zipClick(){
		document.getElementById("searchBtn").click();
	}

	function msg(){
		if(confirm('입력하신 정보로 수정 하시겠습니까?'))
			return true;
		else
			return false;
	}
	function inputDomain(){
		var select = document.getElementById("selectDomain");
		var domainArea = document.getElementById("domainArea");
		
		domainArea.value = "";
		if(select.value != "직접 입력"){
			domainArea.value = select.value;
		}
	}

</script>

<%@ include file="usersMypageMenuTop.jsp" %>
<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u?u_id=${ub.u_id }" id="none_under">마이페이지</a> > 회원정보 > <a href="update.u?u_id=${ub.u_id }" id="none_under">회원정보 수정</a>
</div>
<hr style="margin-bottom: 50px;">

<ul>
	<li><big><b>회원정보 수정</b></big></li>
	<br><br>
	<c:if test="${ub.u_jointype != 'S' && ub.u_phone == null}">
		<span style="font-size: 11pt; line-height: 180%;">
		<u>네이버, 카카오 연동</u>으로 가입하신 회원님은 <font style="color: red;">필수 정보를 반드시 업데이트</font> 해 주셔야 정상적으로 이용하실 수 있습니다.<br>
		번거로우시더라도 잠깐 시간 내시어 정보 업데이트 부탁 드립니다. :)
		</span>
		<br><br><br> 
	</c:if>
	
	<div>
		<form action="update.u" method="post" onSubmit="return msg()" enctype="multipart/form-data">
			<input type="hidden" name="u_id" value="${ub.u_id }">
			
			<table id="content_update">
				<tr style="border-top: 1px solid #D5D5D5; height: 10%; margin: 0px; padding-left: 10px;">
					<td rowspan="2" width="20%" style="border-right: 1px dotted #EAEAEA;">
						<c:if test="${ub.u_profileimg != null}">
							<input type="hidden" name="img_before" value="${ub.u_profileimg}">
							<input id="profile" type="file" name="upload_img" accept="image/*" style="display: none">
							<br>
							<img id="profileImg" alt="프로필이미지" src=
							<c:if test="${ub.u_jointype == 'N' or ub.u_jointype == 'K' }">"${ub.u_profileimg }"</c:if>
							<c:if test="${ub.u_jointype == 'S'}">"<%=request.getContextPath()%>/resources/uploadFolder/users/${ub.u_profileimg}"</c:if>
							 style="cursor:pointer; top: -5px; position: relative; object-fit: cover;" class="rounded-circle">
							<br>
							<span id="profileImgName">
								<a href="javascript:deleteProfileImg();" style="text-decoration: none; font-size: 10pt;">
									<font color="red">x</font>
								</a> 
								<c:if test="${ub.u_jointype eq 'N' || ub.u_jointype eq 'K' }">
									<c:set var="profile" value="${fn:split(ub.u_profileimg,'/')}" />
									${profile[fn:length(profile)-1] }
								</c:if>
								<c:if test="${ub.u_jointype eq 'S'}">${ub.u_profileimg}</c:if>
							</span>
						</c:if>
						<c:if test="${ub.u_profileimg == null}">
							<input type="hidden" name="img_before" value="${ub.u_profileimg}">
							<input id="profile" type="file" name="upload_img" accept="image/*" style="display: none">
							<br>
							<img id="profileImg" alt="프로필이미지" src="resources/image/no-image.jpg" style="cursor:pointer; top: -5px; position: relative; object-fit: cover;"><br>
							<span id="profileImgName">
								<a href="javascript:deleteProfileImg();" style="text-decoration: none; font-size: 10pt;"><font color="red">x</font></a>
								<span style="font-size: 10pt;">&nbsp;사진을 등록하세요</span>
							</span>
						</c:if>
					</td>
					<th>&nbsp;&nbsp;자기소개</th> 
				</tr>
				<tr style="height: 130px;">
					<td> 
						<textarea name="u_intro" class="form-control" style="width: 97%; height: 100px; resize: none; font-size: 11pt;" placeholder="30자 이내의 간단한 자기소개를 등록해주세요." maxlength="30">${ub.u_intro}</textarea>
					</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA; height: 12%;">
					<th>&nbsp;&nbsp;이름</th>
					<td>${ub.u_name}</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA; height: 12%;">
					<th>&nbsp;&nbsp;아이디</th>
					<td>
						<c:if test="${ub.u_jointype eq 'S'}">${ub.u_id }</c:if>
						<c:if test="${ub.u_jointype eq 'N'}">네이버 연동</c:if> 
						<c:if test="${ub.u_jointype eq 'K'}">카카오 연동</c:if>
					</td> 
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA; height: 12%;">
					<th>&nbsp;&nbsp;비밀번호</th>
					<td>
						<c:if test="${ub.u_jointype eq 'S'}">
							<input type="button" value="비밀번호 변경" class="btn btn-outline-secondary" onClick="location.href='changepw.u'" style="font-size: 10pt;">
						</c:if>
						<c:if test="${ub.u_jointype eq 'N' || ub.u_jointype eq 'K'}">
							-
						</c:if>
					</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA; height: 12%;">
					<th>&nbsp;&nbsp;이메일</th>
					<td>
						<input type="text" class="form-control" name="u_email" value="${fn:split(ub.u_email, '@')[0]}" style="width: 20%; display: inline-block;" maxlength="20" required>
						@
						<input type="text" class="form-control" id="domainArea" value="${fn:split(ub.u_email, '@')[1]}" name="u_email" style="width: 20%; display: inline-block;" maxlength="15" required>
						<c:set var="domains">직접 입력,naver.com,daum.net,google.com,hanmail.net</c:set>
						<select class="form-select" id="selectDomain" style="width: 20%; display: inline-block;" onchange="inputDomain()">
							<c:forEach var="domain" items="${domains}">
								<option value="${domain}">${domain}
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA; height: 12%;">
					<th><font color="red">*</font> 전화번호</th>
					<td>
						<c:set var="firstList">010, 011, 016, 017, 018, 019</c:set>
						<select name="u_phone" class="form-select" style="width: 12%; display: inline;">
							<c:forEach var="first" items="${firstList }">
								<option value="${first }"
									<c:if test="${fn:split(ub.u_phone, '-')[0] eq first }">selected</c:if>>${first }</option>
							</c:forEach>
						</select>
						-
						<input type="text" class="form-control" name="u_phone" style="width: 12%; display: inline; text-align: center;" value="${fn:split(ub.u_phone, '-')[1]}" maxlength="4" required> - 
						<input type="text" class="form-control" name="u_phone" style="width: 12%; display: inline; text-align: center;" value="${fn:split(ub.u_phone, '-')[2]}" maxlength="4" required>
						</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA;">
					<th style="height: 145px;"><font color="red">*</font> 주소</th>
					<td>
						<input type="hidden" id="sample4_jibunAddress">
						<input type="hidden" id="sample4_extraAddress">
						<input type="text" class="form-control" name="u_address" style="display: inline; width: 50%; margin-bottom: 5px;" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[0]}" id="sample4_postcode" onClick="zipClick()" placeholder="우편번호" readonly>
						<input type="button" class="btn btn-outline-secondary" id="searchBtn" style="margin-bottom: 5px; height: 37px;" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" class="form-control" name="u_address" style="width: 90%; margin-bottom: 5px;" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[1]}" id="sample4_roadAddress" onClick="zipClick()" placeholder="도로명주소" readonly> 
						<span id="guide" style="color: #999; display: none"></span> 
						<input type="text" class="form-control" name="u_address" style="width: 90%; margin-bottom: 5px;" value="${ub.u_address eq '-' ? '': fn:split(ub.u_address, ',')[2]}" id="sample4_detailAddress" placeholder="상세주소" required></td>
				</tr>
				<tr style="border-bottom: 1px solid #D5D5D5; height: 12%;"> 
					<th><font color="red">*</font> 퍼스널 컬러</th>
					<td>
						<c:set var="pcList">잘 모르겠음,봄 라이트,봄 브라이트,여름 라이트,여름 브라이트,여름 뮤트,가을 뮤트,가을 스트롱,가을 딥,겨울 브라이트,겨울 딥</c:set>
						<select name="u_color" class="form-select" style="width: 90%;">
							<c:forEach var="pc" items="${pcList}">
								<option value="${pc}"
									<c:if test="${pc eq ub.u_color }">selected</c:if>>${pc}</option>
							</c:forEach>
					</select></td>
				</tr>
			</table>
			<br><br>
			<input type="submit" class="btn btn-outline-secondary" style="margin-left: 37%;" value="수정하기">
			<input type="reset" class="btn btn-outline-secondary" value="되돌리기">
		</form>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>
