<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css">
<%@ include file="adminMenu.jsp"%>
<style>
input[type="text"], select, email, textarea {
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
	
	function sub(){
	}
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
<div class="page-title">
    <div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>답글 달기</h4>
		</div>
</div>
<br>
<div id="board-list">		
	<form:form commandName="bb" action="qReply.admin" method="post" >
		<input type="hidden" name="q_num" value="${ bb.q_num }">
		<input type="hidden" name="pageNumber" value="${pageNumber}">
		<input type = "hidden" name = "q_ref" value=${bb.q_ref }>
		<input type = "hidden" name = "q_re_step" value=${ bb.q_re_step }>
		<input type = "hidden" name = "q_re_level" value=${ bb.q_re_level }>
		<input type = "hidden" name = "whatColumn" value=${ whatColumn }>
		<input type = "hidden" name =  "keyword" "value=${ keyword }>
			      <table class="board-table" style="font-size: 13pt;">
					<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">제목</th>
					<td align="left" colspan="3">
						<input type="text" name="q_subject" class="form-control" style="width: 94%;" maxlength="20" placeholder="20자 이내로 입력해주세요." required>
					</td>
				</tr>
						<input type="hidden" name="q_writer" value="admin" class="form-control" style="width: 86%;" maxlength="5" readonly>
						<input type="hidden" name="q_email" value="color@gmail.com" style="width: 85%;"  placeholder="ex) color@gmail.com" readonly>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" >내용</th>
					<td align="left" colspan="3">
						<textarea rows="10" cols="100" name="q_content" class="form-control" style="width: 94%; height:50%; resize: none;" required></textarea>
					</td>
				</tr>
						<input type="hidden" name="q_password" value="1234" class="form-control" style="width: 35%; resize: none;" placeholder="4자 이내로 입력해주세요." maxlength="4" required>
						<input type="hidden" name="q_type" value="${bb.q_type}" class="form-control" style="width: 35%; resize: none;" placeholder="4자 이내로 입력해주세요." maxlength="4" required>
						<input type="hidden" name="q_secret" value="${bb.q_secret}" class="form-control" style="width: 35%; resize: none;" placeholder="4자 이내로 입력해주세요." maxlength="4" required>
					
						
					</table>
				 <br><br>
				 <center>
						<input type="submit" id="btn" value="답글 작성" onClick="sub()" class="btn btn-white" style="font-size: 13pt; height:60px; width: 130px;">&nbsp;
		 </center>
	</form:form>
</div>
</article>