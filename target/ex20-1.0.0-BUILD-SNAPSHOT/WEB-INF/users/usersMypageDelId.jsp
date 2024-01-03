<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#choose{
		margin-bottom: 27px;
	}
	#tellMeWhy{
		margin-bottom: 45px;
	}
</style>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		$("#why").focusout(function(){
			$("#tellMeWhy").val($("#why").val());
		});
	});

	function msg(){
	if(confirm('탈퇴 시 복구가 불가능합니다. 정말 탈퇴하시겠습니까?'))
		document.forms[0].submit();
	}
</script>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 회원정보 > <a href="deleteForm.u" id="none_under">회원탈퇴</a>
</div>
<hr style="margin-bottom: 50px;">

<ul>
	<li><big><b>회원탈퇴</b></big></li>
	<div style="font-size: 11pt; line-height: 180%; margin: 20px 0px 45px 0px;">
		지금까지 FIND YOUR Hidden Beauty를 이용해주셔서 감사합니다.<br>
		${loginInfo.u_name}님과 이별해야한다니... 너무 아쉬워요.<br>
		마지막으로 서비스 개선을 위해 의견을 받고자 합니다. 탈퇴하시는 가장 큰 이유를 선택해주세요.<br>
	</div>
</ul>

<div style="border: 1px solid #EAEAEA; border-radius: 20px; width: 75%; margin-left: 32px; padding: 40px; font-size: 12pt;"> 
	<form action="delete.u" method="post">
		<input type="hidden" name="u_id" value="${loginInfo.u_id}">
		<input type="hidden" name="u_jointype" value="${loginInfo.u_jointype}">
		<input type="radio" name="reason" id="choose" value="흥미로운 컨텐츠가 부족해요.">&nbsp;&nbsp;흥미로운 컨텐츠가 부족해요.<br>
		<input type="radio" name="reason" id="choose" value="웹 사이트를 이용하기가 불편해요.">&nbsp;&nbsp;웹 사이트를 이용하기가 불편해요.<br>
		<input type="radio" name="reason" id="choose" value="관리가 잘 되지 않는 것 같아요.">&nbsp;&nbsp;관리가 잘 되지 않는 것 같아요.<br>
		<input type="radio" name="reason" id="choose" value="사고 싶은 물품이 없어요.">&nbsp;&nbsp;사고 싶은 물품이 없어요.<br>
		<input type="radio" name="reason" id="choose" value="비매너 사용자를 만났어요.">&nbsp;&nbsp;비매너 사용자를 만났어요.<br>
		<input type="radio" name="reason" id="choose" value="새 계정을 만들고 싶어요.">&nbsp;&nbsp;새 계정을 만들고 싶어요.<br>
		<input type="radio" name="reason" id="tellMeWhy" value="">&nbsp;&nbsp;기타 : <input type="text" id="why" class="form-control" style="display: inline; width: 50%;"><br>
		<input type="button" value="탈퇴하기" class="btn btn-outline-secondary" onClick="msg()">
	</form>
</div>

<%@ include file="usersMypageMenuBottom.jsp" %>
