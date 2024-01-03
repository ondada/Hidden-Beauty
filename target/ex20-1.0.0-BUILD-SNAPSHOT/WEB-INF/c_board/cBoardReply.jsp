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

<%
	application.setAttribute("flag",false);
%>

<br>
<article id="center" style=" text-align: center; font-family: 'RIDIBatang';" > 
<div class="page-title">
    <div class="container">
        <br><br>
        <h3 style="font-size: 25pt; font-weight: bold;">답글 달기</h3>
        <input type=button value="목록" onClick="location.href='cBoardList.cb?pageNumber=${pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}'" class="btn btn-white"><br>
    </div>
</div>
<br><br><br><br><br>

<div id="board-list">		
	<form:form commandName="bb" action="cReply.cb" method="post">
		<input type="hidden" name="c_num" value="${ bb.c_num }">
		<input type="hidden" name="pageNumber" value="${pageNumber}">
		<input type = "hidden" name = "c_ref" value=${bb.c_ref }>
		<input type = "hidden" name = "c_re_step" value=${ bb.c_re_step }>
		<input type = "hidden" name = "c_re_level" value=${ bb.c_re_level }>
		<input type = "hidden" name = "whatColumn" value=${ whatColumn }>
		<input type = "hidden" name =  "keyword" value=${ keyword }>
			      <table class="board-table" style="font-size: 13pt;">
					<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">제목</th>
					<td align="left" colspan="3">
						<input type="text" name="c_subject" class="form-control" style="width: 94%;" maxlength="20" placeholder="자동으로 [답글] 표시가 생성되니 따로 입력하지 마시고, 20자 이내로 입력해주세요." required>
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">작성자</th>
					<td align="left" width="35%">
						<c:if test="${joinType == 'N'}">
							외부 회원 (네이버)
						</c:if>
						<c:if test="${joinType == 'K'}">
							외부 회원 (카카오)
						</c:if>
						<c:if test="${joinType == 'S'}">
							${loginInfo.u_id}
						</c:if>
						<input type="hidden" name="c_writer" value="${loginInfo.u_id}" class="form-control" style="width: 85%;" maxlength="5" placeholder="5자 이내로 입력해주세요." required>
					</td>
					<th align="left" bgcolor="#EDE5D8" width="14%">이메일</th>
					<td align="left">
						<input type="email" name="c_email" value="${loginInfo.u_email}"  class="form-control" style="width: 86%;" maxlength="30"  placeholder="ex) color@gmail.com" required>
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">내용</th>
					<td align="left" colspan="3">
						<textarea rows="10" cols="100" name="c_content" id="content" class="form-control" style="width: 94%; resize: none;" onkeyup="textCount()" required></textarea>
						<span id="count" style="float: right; margin: 5px 65px 0px 0px; color: graytext; font-size: 11pt;">(-/500)</span>
						<script>
							function textCount(){
								var content = document.getElementById("content").value;
								if (content.length > 500) {
					                content = content.substring(0,500);
					                document.getElementById('content').value = content;
					            }
								document.getElementById("count").innerHTML = "("+content.length+"/500)";
							}
						</script>
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8">비밀번호</th>
					<td align="left" colspan="3">
						<input type="password" name="c_password" class="form-control" style="width: 35%; resize: none;" placeholder="4자 이내로 입력해주세요." maxlength="4" required>
					</td>
				</tr>
					</table>
				 <br><br>
				 <center>
						<input type="submit" id="btn" value="답글 작성" class="btn btn-dark" style="font-size: 13pt; width: 130px;">&nbsp;
		 </center>
	</form:form>
</div>
</article>


<%@ include file="./../views/footer.jsp" %>