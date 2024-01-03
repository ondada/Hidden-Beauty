<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	table th{
		text-align: left; 
		background: #F6F6F6;
		padding-left: 20px;
	}
	@font-face {
	    font-family: 'GangwonEduSaeeum_OTFMediumA';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/GangwonEduSaeeum_OTFMediumA.woff') format('woff');
	    font-weight: normal;
    	font-style: normal;
	}
	#pfArea{
		border-radius: 50%;
		width: 150px; 
		height: 150px; 
		background-image: url('resources/uploadFolder/users/${loginInfo.u_profileimg}');
		background-repeat: no-repeat;
		background-size: cover;
		background-position: center;
		left: -10px;
		position: relative;
	}
</style>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 회원정보 > <a href="mypage.u" id="none_under">회원정보 조회</a>
</div>
<hr style="margin-bottom: 50px;">
				
<div style="font-family: 'GangwonEduSaeeum_OTFMediumA'; font-size: 45pt; margin: 0px 0px 50px 20px;">
	반갑습니다, ${ub.u_name}님!
</div>

<ul>
	<li><big>회원정보 조회</big></li>
	<br><br>
	<div>
		<table style="width: 95%; height: 225px; text-align: left;" id="content">
			<tr style="border-top: 1px solid #D5D5D5;">
				<td rowspan="5" width="18%" valign="middle">
					<c:if test="${ub.u_profileimg != null}">
						<img src=
						<c:if test="${ub.u_jointype == 'N' or ub.u_jointype == 'K' }">"${ub.u_profileimg }"</c:if>
						<c:if test="${ub.u_jointype == 'S'}">"<%=request.getContextPath()%>/resources/uploadFolder/users/${ub.u_profileimg }"</c:if>
						 width="85%" class="rounded-circle">
					</c:if>
					<c:if test="${ub.u_profileimg == null}">
						<img src="resources/image/person.svg" width="85%" class="rounded-circle">
					</c:if>
				</td>
				<th>아이디</th>
				<td>
					<c:if test="${ub.u_jointype eq 'S' }">${ub.u_id}</c:if>
					<c:if test="${ub.u_jointype eq 'N' }">네이버 연동</c:if> <c:if
						test="${ub.u_jointype eq 'K' }">카카오 연동</c:if>
				</td>
				<th>이메일</th>
				<td>${loginInfo.u_email}</td>
			</tr>
			<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA;">
				<th width="15%">이름</th>
				<td width="23%">${ub.u_name}</td>
				<th width="15%">전화번호</th>
				<td width="23%">
					${ub.u_phone}
					<c:if test="${ub.u_phone eq '' }"><font color="red">필수 입력 사항입니다.</font></c:if>
				</td>
			</tr>
			<tr
				style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA;">
				<th>퍼스널 컬러</th>
				<td>${ub.u_color}</td>
				<th>보유 포인트</th>
				<td>${ub.u_point} points</td>
			</tr>
			<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA;">
				<th>주소</th>
				<td colspan="3">${fn:split(ub.u_address, ',')[1] }
					${fn:split(ub.u_address, ',')[2] }
					(${fn:split(ub.u_address, ',')[0] })</td>
			</tr>
			<tr style="border-bottom: 1px solid #D5D5D5;">
				<th>자기소개</th>
				<td colspan="3">${ub.u_intro}</td>
			</tr>
		</table>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>
