<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<style>
	@font-face {
	    font-family: 'MaruBuri-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10-21@1.0/MaruBuri-Regular.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	} 
	@font-face {
	    font-family: 'RIDIBatang'; 
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
</style>

<div style="font-family: 'MaruBuri-Regular'; font-size: 23pt; font-weight: bold; width: 100%; text-align: center; margin: 40px 0px 40px 0px;"> 
	정지해제 요청관리<br>
	<div style="font-family: 'RIDIBatang'; font-size: 10pt; font-weight: normal; margin-top: 10px; color: #A6A6A6;">새로 접수된 <u>${newRequest}개</u>의 요청이 있습니다.</div>
</div>

<table style="text-align: center; margin: auto; font-family: 'RIDIBatang'; font-size: 11pt; width: 90%; border-spacing: 0px;">
	<tr style="background: #D5D5D5; height: 30px;">
		<th>번호</th>
		<th>아이디</th>
		<th>이메일</th>
		<th>요청사항</th>
		<th>등록일자</th>
		<th>처리여부</th>
	</tr>
	<c:if test="${empty rbList}">
		<tr style="height: 30px;">
			<td colspan="5">접수된 정지 해제 요청이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not empty rbList}">
		<c:forEach var="rb" items="${rbList}">
			<tr style="height: 30px; font-size: 10pt; border-bottom: 1px dotted #D5D5D5;">
				<td>${rb.rs_num}</td>
				<td>${rb.u_id}</td>
				<td>${rb.u_email}</td>
				<td>${rb.rs_content}</td>
				<td>${rb.rs_date}</td>
				<td>
					<c:if test="${rb.rs_done == 'Y'}">
						처리완료
					</c:if>
					<c:if test="${rb.rs_done == 'N'}">
						<font color="red"><b>처리요망</b></font>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
</table>

<div style="width: 100%; text-align: center; margin-top: 200px;">
	${pageInfo.pagingHtml}
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>