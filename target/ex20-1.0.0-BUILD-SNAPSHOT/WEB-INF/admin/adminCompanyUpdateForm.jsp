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
		
		function up(cmp_num,pageNumber){
			if(confirm('수정하시겠습니까?')){
				location.href='companyUpdate.admin?cmp_num='+cmp_num+'&pageNumber='+pageNumber;
			}
		}
	
</script>

<article style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>진단 회사 정보 수정</h4>
		</div>
		
	<div id="table-form" style="text-align: center;" align="center">
			<form action="companyUpdate.admin" method="post">
			<table class="board-table">
				<tr style="border-top: 2px solid graytext; padding:10px;">
					<th width="20%"><font color="red">*</font> 회사명</th>
					<td width="80%">
						<input type="hidden" class="form-control"  style="width:70%;" name="cmp_num" value="${bb.cmp_num }" >
						<input type="text" class="form-control"  style="width:70%;" name="cmp_name" value="${bb.cmp_name }" required>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th><font color="red">*</font> 주소</th>
					<td> 
						<input type="text" class="form-control" style="width: 70%; display: inline; margin-bottom: 10px;" name="cmp_addr" value="${bb.cmp_addr eq '-' ? '': fn:split(bb.cmp_addr, ',')[0]}" id="sample4_postcode" placeholder="먼저 우편번호 찾기 버튼을 눌러주세요." onClick="zipClick()" readonly>
						<input type="button" class="btn btn-white" onclick="sample4_execDaumPostcode()" style="margin-bottom:11px; height: 39px; width:140px;"  value="우편번호 찾기" id="searchBtn"><br>
						<input type="text" class="form-control" name="cmp_addr" value="${bb.cmp_addr eq '-' ? '': fn:split(bb.cmp_addr, ',')[1]}" id="sample4_roadAddress" placeholder="도로명주소" style="margin-bottom: 10px;" onClick="zipClick()">
						<span id="guide" style="color:#999; display:none"></span>
						<input type="text" class="form-control" name="cmp_addr" value="${bb.cmp_addr eq '-' ? '': fn:split(bb.cmp_addr, ',')[2]}" id="sample4_detailAddress" placeholder="상세주소" >
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font> 진단 비용</th>
					<td width="80%">
						<input type="text" class="form-control" name="cmp_price" style="width:20%;" value="${bb.cmp_price }" required> 원
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font> 지하철 역</th>
					<td width="80%">
						<input type="text" class="form-control" name="cmp_station"  class="form-control"  value="${bb.cmp_station }" required>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font>경도</th>
					<td width="80%">
						<input type="text" class="form-control" name="cmp_x"  class="form-control"  value="${bb.cmp_x}" required>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font>위도</th>
					<td width="80%">
						<input type="text" class="form-control" name="cmp_y"  class="form-control"  value="${bb.cmp_y}" required>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<br>
						<input type="submit" value="수정하기" class="btn btn-white" onClick="up(${bb.cmp_num},${pageInfo.pageNumber})" style="margin-bottom:11px; height: 39px; width:150px;" id="subBtn">
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</article>