<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#btn{
		width: 180px;
		height: 40px;
		margin-left: 5px;
		background: #D0D6CE;
		border: none;
		border-radius: 3px;
		font-size: 12pt;
		font-family: 'MaruBuri-Regular';
		font-weight: bold;
	}
	#btn:hover {
		background: #97A892;
		color: white;
	}
</style>
    
<%@ include file="../views/header.jsp" %>

<div id="center" style="text-align: center">
<br><br><br><br>
	<div>
		<span style="font-family: 'MaruBuri-Regular'; font-size: 35pt; font-weight: bold;">아이디 찾기</span>
		<br><br>
		
		<c:if test="${fn:length(u_lists) eq 0}">
			<br><br>
			<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%; color: graytext;">
				입력하신 내용과 일치하는 정보를 찾을 수 없습니다.<br>
				항상 고객님의 편리함을 위해 최선을 다하는 Hidden Beauty가 되겠습니다.
			</span>
			<br><br><br>
		</c:if>
		
		<c:if test="${fn:length(u_lists) ne 0}">
		<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%; color: graytext;">
			고객님의 정보 조회가 성공적으로 이루어졌습니다.<br>
			항상 고객님의 편리함을 위해 최선을 다하는 Hidden Beauty가 되겠습니다.
		</span>
		<br><br><br>
		<table style="border: 1px solid #D5D5D5; margin: auto; width: 500px; font-family: 'RIDIBatang';">
			<tr style="background: #EAEAEA; height: 70px;">
				<td width="12%">
					&nbsp;&nbsp;
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-dots-fill" viewBox="0 0 16 16">
					  <path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
					</svg>
				</td>
				<td>
					저희 사이트를 이용해주셔서 감사합니다.<br>
					고객님의 정보로 가입된 아이디는 총 <b>${fn:length(u_lists)}</b>개 입니다.
				</td>
			</tr>
			<tr height="40"><td></td><td>- 이름 : ${ub.u_name}<br></td></tr>
			<tr height="40"><td></td><td>- 전화번호 : ${ub.u_phone}<br></td></tr>
			<c:set var="idNum" value="1" />
			<c:forEach var="ub" items="${u_lists}">
				<tr height="40"><td></td><td>- 아이디 <c:if test="${fn:length(u_lists)>0}">${idNum}</c:if> : <font color="red"><b>${ub.u_id}</b></font><br></td></tr>
				<c:set var="idNum" value="${idNum+1}" />
			</c:forEach>
		</table>
		</c:if>
	
	</div>
<br><br>

<input type="button" value="로그인 하러가기" id="btn" onClick="location.href='login.u'"> 
<input type="button" value="비밀번호 찾기" id="btn" onClick="location.href='findpw.u'"> 
</div>

<%@ include file="../views/footer.jsp" %>