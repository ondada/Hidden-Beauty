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
		
		function del(c_num,pageNumber){
				location.href='cBoardList.admin';
			
			
		}
	
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>게시글 상세</h4>
		</div>
		
	<div id="center" style="text-align: center;">
			<form action="cBoardDelete.admin" method="post">
			
			<table class="board-table" style="font-size: 13pt;">
					<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">제목</th>
					<td align="left" colspan="3" height="30">
						${bb.c_subject}		
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%">작성자</th>
					<td align="left" width="35%">
						${bb.c_writer}							
					</td>
					<th align="left" bgcolor="#EDE5D8" width="14%">이메일</th>
					<td align="left" height="50">
						${bb.c_email}						
					</td>
				</tr>
				<tr>
					<th align="left" bgcolor="#EDE5D8" width="10%" >내용</th>
					<td align="left" colspan="3" height="100" valign="top" style="padding-top: 25px;">
						${ bb.c_content}
					</td>
				</tr>
						
					</table>
			</form>
		</div>
	</div>
</article>