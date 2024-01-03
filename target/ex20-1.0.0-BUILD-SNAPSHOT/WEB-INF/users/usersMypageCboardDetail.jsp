<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#c_boardDetail{
		width: 95%;
	}
	#c_boardDetail th{
		text-align: center;
	}
	#c_boardDetail td{
		padding-left: 20px;
		height: 68px;
	}
</style>
    
<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 게시물 관리 > <a href="c_board.u?pageNumber=${pageNumber}" id="none_under">후기 게시판</a> > <a href="c_boardDetail.u?c_num=${cb.c_num}&pageNumber=${pageNumber}" id="none_under">게시글 조회</a>
</div>
<hr style="margin-bottom: 50px;">
				
<ul>
	<li><big><b>게시글 조회</b></big></li>
	<div style="font-size: 11pt; line-height: 180%; margin: 20px 0px 5px 0px;">
		마이페이지에서는 답글을 작성하실 수 없습니다.<br>
		상단 메뉴에서 '후기 게시판'으로 이동하시어 이용하시길 바랍니다.<br>
	</div>
	<div>
		<div style="width: 95%; text-align: right; margin-bottom: 10px;">
			<input type="button" class="btn btn-outline-secondary" style="font-size: 10pt;" value="목록으로" onClick="location.href='c_board.u?pageNumber=${pageNumber}'">
		</div>
		<table id="c_boardDetail">
			<tr style="border-top: 1px solid #D5D5D5;">
				<th bgcolor="#F7F3ED" width="10%">제목</th>
				<td colspan="3">${cb.c_subject}</td>
			</tr>
			<tr style="border-top: 1px dotted #EAEAEA;">
				<th bgcolor="#F7F3ED" width="10%">작성자</th>
				<td width="38%">${ cb.c_writer}</td>
				<th bgcolor="#F7F3ED" width="14%">이메일</th>
				<td>${cb.c_email}</td>
			</tr>
			<tr style="border-bottom: 1px solid #D5D5D5; border-top: 1px dotted #EAEAEA;">
				<th bgcolor="#F7F3ED" width="10%">내용</th>
				<td colspan="3" valign="top" style="height: 200px; padding-top: 20px;">${cb.c_content}
				</td>
			</tr>
		</table>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>