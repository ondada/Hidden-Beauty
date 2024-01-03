<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../views/header.jsp" %>

<style>
	table{
		font-family: 'RIDIBatang'; 
		font-size: 11pt;
		width: 400px;
		height: 100px;
		margin: auto;
		text-align: left;
	}
	td{
		padding: 0px 0px 10px 10px; 
	}
	body{
		padding-top: 90px;
	}
	#btn{
		width: 150px;
		height: 40px;
		margin-left: 5px;
		background: #EAEAEA;
		border: none;
		border-radius: 3px;
		font-size: 12pt;
	}
	#btn:hover {
		background: #BDBDBD;
		color: white;
	}
</style>
<div id="center" style="text-align: center;">

	<br><br><br><br>
	<div>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold;">비밀번호 찾기</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%;">
			<!-- 가입 시 입력하신 성함, 아이디, 전화번호를 입력해주세요.<br>
			해당 정보를 바탕으로 비밀번호를 찾아드릴게요! -->
			아이디와 성함을 입력해주세요.<br>
			회원정보에 등록된 이메일 주소로 임시 비밀번호를 알려드립니다.<br>
			<b>임시 비밀번호로 로그인 하신 후 반드시 비밀번호를 수정해 주세요.</b>
		</span>
	</div>
	<br><br><br> 
	
	<hr style="width: 50%; margin: auto;">
	<br><br>
	<form action="findpw.u" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" class="form-control" style="width: 98%;" name="u_id" value="${param.u_id }" required></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" class="form-control" style="width: 98%;" name="u_name" value="${param.u_name }" required></td>
			</tr>
			<tr align="center">
				<td colspan="2"><br><input type="submit" id="btn" value="임시 비밀번호 발송"></td>
			</tr>
		</table>
		<br>
		<hr style="width: 50%; margin: auto;">
	</form>
</div>
<%@ include file="../views/footer.jsp" %>