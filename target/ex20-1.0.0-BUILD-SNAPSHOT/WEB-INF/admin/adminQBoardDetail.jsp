<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css">

<style>
input[type="text"] {
  font-size: 15px;
  width: 300px;
  height:35px;
  border: none;
  border-bottom: solid #aaaaaa 1px;
  padding-bottom: 3px;
  padding-left: 10px;
  position: relative;
  background: #f8f9f7;
  z-index: 5;
  border-radius:5px;
}

#searchBtn{
margin-top:13px;
}

table th{
	text-align:left;
}
.board-table{
margin-top:20px;
}
table{
		margin: auto; 
		width: 800px;
		height: 650px;
		font-family: 'RIDIBatang';
	}
</style>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	function zipClick(){
		document.getElementById("searchBtn").click();
	}


		function init(){
			var elem = document.getElementById('keyword');
			elem.value = '';
		}
	
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>게시글 상세</h4>
		</div>
		
	<div id="center" style="text-align: center;">
			<form action="qBoardDelete.admin" method="post">
			
			<table class="board-table" style="font-size: 13pt;">
					<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">제목</th>
					<td align="left" colspan="3" height="30">
						${bb.q_subject}		
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">작성자</th>
					<td align="left" width="35%">
						${bb.q_writer}							
					</td>
					<th align="left" bgcolor="#EDE5D8" width="14%">이메일</th>
					<td align="left" height="50">
						${bb.q_email}						
					</td>
				</tr>
				<tr>
					<c:set var="types">배송문의,결제문의,교환문의,환불문의,기타</c:set>
					<th align="left" bgcolor="#EDE5D8" width="10%">문의유형</th>
					<td align="left" height="50" width="38%">
						${bb.q_type}		
					</td>
					<th align="left" bgcolor="#EDE5D8" width="14%" >공개 여부</th>
					<td align="left" height="50">
						<c:if test="${bb.q_secret == 'N'}">
							비밀글
						</c:if>
						<c:if test="${bb.q_secret == 'Y'}">
							공개글
						</c:if>
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%" >내용</th>
					<td align="left" colspan="3" height="150" valign="top" style="padding-top: 25px;">
						${ bb.q_content}
					</td>
				</tr>
						
					</table>
			</form>
		</div>
	</div>
</article>