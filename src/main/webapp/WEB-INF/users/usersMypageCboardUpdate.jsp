<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#c_boardUpdate{
		width: 95%;
	}
	#c_boardUpdate th{
		text-align: center;
	}
	#c_boardUpdate td{
		padding-left: 20px;
		height: 68px;
	}
</style>

<%@ include file="usersMypageMenuTop.jsp" %>

<div style="margin: 0px 0px 28px 5px; font-size: 10pt;">
	<a href="mypage.u" id="none_under">마이페이지</a> > 게시물 관리 > <a href="c_board.u?pageNumber=${pageNumber}" id="none_under">후기 게시판</a> > <a href="c_boardUpdate.u?c_num=${cb.c_num}&pageNumber=${pageNumber}" id="none_under">게시글 수정</a>
</div>
<hr style="margin-bottom: 50px;">

<ul>
	<li><big><b>게시글 수정</b></big></li>
	<div>
		<form action="c_boardUpdate.u" method="post">
		<div style="width: 95%; text-align: right; top: -5px; position: relative;">
			<input type="submit" value="수정하기" class="btn btn-outline-secondary" style="font-size: 10pt;">
			<input type="button" class="btn btn-outline-secondary" style="font-size: 10pt;" value="목록으로" onClick="location.href='c_board.u?pageNumber=${pageNumber}'">
		</div>
			<input type="hidden" name="c_num" value="${cb.c_num}">
			<input type="hidden" name="pageNumber" value="${pageNumber}">
			<table id="c_boardUpdate" style="font-size: 13pt;">
				<tr style="border-top: 1px solid #D5D5D5;">
					<th bgcolor="#F7F3ED" width="10%">제목</th>
					<td colspan="3">
						<input type="text" name="c_subject" value="${cb.c_subject}" class="form-control" style="width: 94%;" maxlength="20" placeholder="20자 이내로 입력해주세요." required>
					</td>
				</tr>
				<tr style="border-top: 1px dotted #EAEAEA;">
					<th bgcolor="#F7F3ED" width="10%">작성자</th>
					<td width="38%;">
						<input type="hidden" name="c_writer" value="${cb.c_writer}">
						${cb.c_writer}
					</td>
					<th bgcolor="#F7F3ED" width="10%">이메일</th>
					<td>
						<input type="email" name="c_email" value="${cb.c_email}" class="form-control" style="width: 86%;"  placeholder="ex) color@gmail.com" required>
					</td>
				</tr>
				<tr style="border-bottom: 1px solid #D5D5D5; border-top: 1px dotted #EAEAEA;">
					<th bgcolor="#F7F3ED" width="10%">내용</th>
					<td colspan="3" style="padding: 18px 0px 18px 23px;">
						<textarea rows="10" cols="100" name="c_content" class="form-control" style="width: 94%; resize: none;" required>${cb.c_content}</textarea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</ul>
<br>

<%@ include file="usersMypageMenuBottom.jsp" %>