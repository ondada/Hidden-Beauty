<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="./../views/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/qBoardWrite.css">
<style type="text/css">
	#btn{
		font-size: 13pt; 
		width: 130px; 
		color: black; 
		background: white; 
		border: 1px solid #D5D5D5;
		border-radius: 5px;
	}
	#btn:hover {
		background: #D0D6CE;
		color: white;
	}
	body{
		padding-top: 90px;
	}
</style>  
<script type="text/javascript">
	function goReply(c_num, c_ref, c_re_step, c_re_level, pageNumber, whatColumn, keyword){
		location.href="cReply.cb?c_ref="+c_ref+"&c_re_step="+c_re_step+"&c_re_level="+c_re_level+"&pageNumber="+pageNumber+"&c_num="+c_num+"&whatColumn="+whatColumn+"&keyword="+keyword;
	}
</script>
<%
	application.setAttribute("flag",false); 
%>

<c:if test="${bb.c_report >= 3}">
	<script>
		alert("3회 이상 신고된 글은 열람하실 수 없습니다.");
		history.go(-1);
	</script>
</c:if>

<br>
<article id="center" style=" text-align:center; font-family: 'RIDIBatang';">

<div class="page-title">
    <div class="container">
        <br><br>
        <h3 style="font-size: 25pt; font-weight: bold;">후기 게시판</h3>
        <input type=button value="목록" onClick="location.href='cBoardList.cb?pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-white"><br>
    </div>
</div>
<br><br><br><br><br>

 <div id="board-list">
	
		<form:form commandName="bb" action="write.cb" method="post">
		      <table class="board-table" style="font-size: 13pt;">
				<tr >
					<th align="left" bgcolor="#EDE5D8" width="10%">제목</th>
					<td align="left" colspan="3" height="68">${ bb.c_subject }
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">작성자</th>
					<td align="left" height="68" width="38%">
						<c:if test="${joinType == '탈퇴함'}"> 
							<font color="red"><b>탈퇴한 회원 입니다.</b></font>
						</c:if>
						<c:if test="${joinType != '탈퇴함'}">
							<c:if test="${joinType == 'N'}">
								외부 회원 (네이버)
							</c:if>
							<c:if test="${joinType == 'K'}">
								외부 회원 (카카오)
							</c:if>
							<c:if test="${joinType == 'S'}">
								${ bb.c_writer }
							</c:if>
						</c:if>
					</td>
					<th align="left" bgcolor="#EDE5D8" width="14%" >이메일</th>
					<td align="left" height="68">
						${ bb.c_email }
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%" >내용</th>
					<td align="left" colspan="3" height="200" valign="top" style="padding-top: 25px;">
						<pre style="font-family: 'RIDIBatang'; line-height: 170%;">${bb.c_content}</pre>
					</td>
				</tr>
			 </table>
			 <br><br>
			 
			<!-- 세션이 작성자와 같거나 관리자가 아니면 수정, 삭제, 목록 버튼 보이게 -->
			<c:if test="${loginInfo.u_id ==null}">
				 <center>
				 	답글달기는 로그인 후 이용 가능합니다.
				</center>
			</c:if>
			
			<!-- 접속한 id가 관리자가 아니고, 글 작성자랑 접속한 id랑 다른데 로그인은 되어있으면 답글과 신고만. -->
			<c:if test="${loginInfo.u_id != null && loginInfo.u_id !='admin' && loginInfo.u_id !=bb.c_writer}"> 
				<center>
					<input type="button" id="btn" value="답글달기" id="btn" onClick="goReply(${ bb.c_num },${ bb.c_ref },${ bb.c_re_step },${ bb.c_re_level },${pageNumber})" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="신고하기" id="btn" onClick="javascript: if(confirm('정말 신고하시겠습니까?')){location.href='report.u?u_id=${bb.c_writer}&url=cBoardList.cb&c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'}" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
				</center>
			</c:if>
			 
			 <!-- 세션이 작성자와 같거나 관리자가 아니면 수정, 삭제, 목록 버튼 보이게 -->
			<c:if test="${loginInfo.u_id  == bb.c_writer && loginInfo.u_id !='admin'}">
				 <center>
					<input type="button" value="수정하기" id="btn" onClick="location.href='cUpdate.cb?c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="삭제하기" id="btn" onClick="location.href='cDelete.cb?c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="답글달기" id="btn" onClick="goReply(${ bb.c_num },${ bb.c_ref },${ bb.c_re_step },${ bb.c_re_level },${pageNumber},'${whatColumn}', '${keyword}')" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
				</center>
			</c:if>
			
			<!-- 접속한 id가 관리자일 땐 모든 게시물 수정 삭제 답글 신고 가능 -->
			<c:if test="${loginInfo.u_id == 'admin'}">
				<center>
					<input type="button" value="수정하기" id="btn" onClick="location.href='cUpdate.cb?c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="삭제하기" id="btn" onClick="location.href='cDelete.cb?c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="답글달기" id="btn" onClick="goReply(${ bb.c_num },${ bb.c_ref },${ bb.c_re_step },${ bb.c_re_level },${pageNumber}, '${whatColumn}', '${keyword}')" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
					<input type="button" value="신고하기" id="btn" onClick="javascript: if(confirm('정말 신고하시겠습니까?')){location.href='report.u?u_id=${bb.c_writer}&url=cBoardList.cb&c_num=${bb.c_num}&pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'}" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
				</center>
			</c:if>
		</form:form>
</div>
</article>



<%@ include file="./../views/footer.jsp" %>