<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    
<style>
	#updatePw th{
		text-align: left; 
		background: #F6F6F6;
		padding-left: 20px;
	}
	#updatePw{
		width: 50%; 
		height: 140px;
		text-align: left;
	}
</style>
<script>
	function msg(){
		if(confirm('변경 하시겠습니까?'))
			return true;
		else
			return false;
	}
</script>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 회원정보 > <a href="update.u" id="none_under">회원정보 수정</a> > <a href="changepw.u" id="none_under">비밀번호 변경</a>
</div>
<hr style="margin-bottom: 50px;">

<ul>
	<li><big><b>비밀번호 변경</b></big></li>
	<br><br>
	<div>
	<form action="changepw.u" method="post" onSubmit="return msg()">
		<input type="hidden" name="u_id" value="${loginInfo.u_id }">
		<table id="updatePw">
			<tr style="border-top: 1px solid #D5D5D5;">
				<th>기존 비밀번호</th>
				<td><input type="password" class="form-control" style="width: 90%; height: 35px;" name="old_password" value="${param.old_password }" required></td>
			</tr>
			<tr style="border-top: 1px dotted #EAEAEA; border-bottom: 1px dotted #EAEAEA;">
				<th>변경할 비밀번호</th>
				<td><input type="password" class="form-control" style="width: 90%; height: 35px;" name="new_password" value="${param.new_password }" required></td>
			</tr>
			<tr style="border-bottom: 1px solid #D5D5D5;">
				<th>비밀번호 확인</th>
				<td><input type="password" class="form-control" style="width: 90%; height: 35px;" name="new_password_chk" value="${param.new_password_chk }" required></td>
			</tr> 
		</table>
		<br>
		<input type="submit" class="btn btn-outline-secondary" value="비밀번호 변경하기" style="width: 173px;">
	</form>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>