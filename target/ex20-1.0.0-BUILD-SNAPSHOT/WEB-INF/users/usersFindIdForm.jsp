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
	#btn{
		width: 120px;
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
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold;">아이디 찾기</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%;">
			가입 시 입력하신 성함과 전화번호를 입력해주세요.<br>
			해당 정보를 바탕으로 아이디를 찾아드릴게요!
		</span>
	</div>
	<br><br><br> 

	<hr style="width: 50%; margin: auto;">
	<br><br>
	<form action="findid.u" method="post">
		<table>
			<tr>
				<td>이름</td>
				<td><input type="text" name="u_name" class="form-control" style="width: 98%;" required></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td>
					<c:set var="firstList">010, 011, 016, 017, 018, 019</c:set>
					<select name="u_phone" class="form-select" style="display: inline; width: 29%">
						<c:forEach var="first" items="${firstList }">
							<option value="${first }">${first }</option>
						</c:forEach>
					</select> - 
					<input type="text" name="u_phone" class="form-control" style="width: 29%; display: inline;" maxlength="4" size="6" required> - 
					<input type="text" name="u_phone" class="form-control" style="width: 29%; display: inline;" maxlength="4" size="6" required>
				</td>
			</tr>
			<tr align="center">
				<td colspan="2"><br><input type="submit" id="btn" value="찾아보기"></td>
			</tr>
		
		</table>
	</form>
	<br>
	<hr style="width: 50%; margin: auto;">
</div>

<%@ include file="../views/footer.jsp" %>