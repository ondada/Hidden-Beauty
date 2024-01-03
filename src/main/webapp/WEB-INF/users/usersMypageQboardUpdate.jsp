<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#q_boardUpdate{
		width: 95%;
	}
	#q_boardUpdate th{
		text-align: center;
	}
	#q_boardUpdate td{
		padding-left: 20px;
		height: 68px;
	}
</style>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 게시물 관리 > <a href="q_board.u?pageNumber=${pageNumber}" id="none_under">문의 게시판</a> > <a href="q_boardUpdate.u?q_num=${qb.q_num}&pageNumber=${pageNumber}" id="none_under">게시글 수정</a>
</div>
<hr style="margin-bottom: 50px;">

<ul>
	<li><big><b>게시글 수정</b></big></li>
	<div>
		<form action="q_boardUpdate.u" method="post">
		<div style="width: 95%; text-align: right; top: -5px; position: relative;">
			<input type="submit" value="수정하기" class="btn btn-outline-secondary" style="font-size: 10pt;">
			<input type="button" class="btn btn-outline-secondary" style="font-size: 10pt;" value="목록으로" onClick="location.href='q_board.u?pageNumber=${pageNumber}'">
		</div>
			<input type="hidden" name="q_num" value="${qb.q_num}">
			<input type="hidden" name="pageNumber" value="${pageNumber}">
			<table id="q_boardUpdate" style="font-size: 13pt;">
				<tr style="border-top: 1px solid #D5D5D5;">
					<th bgcolor="#F7F3ED" width="10%">제목</th>
					<td colspan="3">
						<input type="text" name="q_subject" value="${qb.q_subject}" class="form-control" style="width: 94%;" maxlength="20" placeholder="20자 이내로 입력해주세요." required>
					</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA;">
					<th bgcolor="#F7F3ED" width="10%">작성자</th>
					<td width="38%;">
						<input type="hidden" name="q_writer" value="${qb.q_writer}">
						${qb.q_writer}
					</td>
					<th bgcolor="#F7F3ED" width="10%">이메일</th>
					<td>
						<input type="email" name="q_email" value="${qb.q_email}" class="form-control" style="width: 86%;"  placeholder="ex) color@gmail.com" required>
					</td>
				</tr>
				<tr style="border-bottom: 1px solid #D5D5D5; border-top: 1px dotted #EAEAEA;">
					<th bgcolor="#F7F3ED" width="10%">내용</th>
					<td colspan="3" style="padding: 18px 0px 18px 23px;">
						<textarea rows="10" cols="100" name="q_content" class="form-control" style="width: 94%; resize: none;" required>${qb.q_content}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>