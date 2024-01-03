<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css">

<style>
input[type="text"], select {
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
		
		function up(cl_num,pageNumber){
			if(confirm('수정하시겠습니까?')){
				location.href='celebUpdate.admin?cl_num='+cl_num+'&pageNumber='+pageNumber;
			}
		}
	
		var celeb, celebImg, celebSpan;
		window.onload = function(){
			/* var ttlName = null;
			var dtlName = null; */
			celeb = document.getElementById('celeb');
			celebImg = document.getElementById('celeb_img');
			celebSpan = document.getElementById('celeb_name');
			
			celebImg.addEventListener('click', () => celeb.click());
			
			/* input에 파일이 업로드되면 change event 가 발생 */
			celeb.addEventListener('change', getCelebImage); // getTitleImage 함수 등록
			
			function getCelebImage(e) {
				var celebPathSplit = celeb.value.split('\\'); // 타이틀 이미지의 경로를 구분자 '\\'로 나누기
				var celebName = celebPathSplit[celebPathSplit.length-1];
				alert("들어온 타이틀이미지의 이름: "+celebName);
				
		     	const file = e.currentTarget.files[0];
		      	const reader = new FileReader(); // file을 담을 변수
		      	reader.readAsDataURL(file);
		      	reader.onload = (e) => {
		      		// 파일이 로드되면 이미지를 해당 파일로 고치기
		      		celebImg.setAttribute('src', e.target.result);
		      		celebSpan.innerHTML='<a href="javascript:deleteCelebImg();"><font color="red">x</font></a> '+celebName;
		        };
		    }
			
		};
		function deleteCelebImg(){
			celebImg.setAttribute('src', '<%=request.getContextPath()%>/resources/image/no-image.jpg');
			celebSpan.innerHTML='';
		}
		function checkImg(){
			if(celebSpan.innerHTML == ''){
				alert('연예인 이미지를 넣어주세요.');
				return false;
			} else{
				return true;
			}
		}
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>연예인 수정</h4>
		</div>
		
	<div id="center" style="text-align: center;">
			<form action="celebUpdate.admin" method="post"  enctype="multipart/form-data" onSubmit="return checkImg()">
			
			<table class="board-table">
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font> 이름</th>
					<td width="80%">
						<input type="text" class="form-control" name="cl_name" style="width:20%;" value="${bb.cl_name }" required>
						<input type="hidden" class="form-control" name="cl_num" style="width:20%;" value="${bb.cl_num }" required>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font> 이미지</th>
					<td width="80%">
						<input type="hidden" name="exist_climg" value="${bb.cl_image}">
					<input id="celeb" type="file" name="upload_cl" accept="image/*" style="display: none">
					<br>
					* 연예인 이미지 업로드<br> <!-- 기존 타이틀 이미지가 올라가있다. -->
					<img id="celeb_img" alt="타이틀이미지" src="<%=request.getContextPath()%>/resources/uploadFolder/celeb/${bb.cl_image}" style="border:1px solid black; width:15%; height: 35%; cursor:pointer;"><br>
					<span id="celeb_name"><a href="javascript:deleteCelebImg();"><font color="red">x</font></a> ${bb.cl_image}</span>
					<br><br>
					</td>
				</tr>
				<tr style="border-top: 1px solid #BDBDBD; padding:10px;">
					<th width="20%"><font color="red">*</font> 퍼스널 컬러</th>
					<td width="80%">
						<c:set var="pcList">봄 라이트,봄 브라이트,여름 라이트,여름 브라이트,여름 뮤트,가을 뮤트,가을 스트롱,가을 딥,겨울 브라이트,겨울 딥</c:set>
						<select name="cl_color" class="form-select">
							<c:forEach var="pc" items="${pcList }">
								<option value="${pc }" <c:if test="${pc eq bb.cl_color }">selected</c:if>>${pc }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
					<td colspan="2" align="center">
						<br>
						<input type="submit" value="수정하기" class="btn btn-white" onClick="up(${bb.cl_num},${pageInfo.pageNumber})" style="margin-bottom:11px; height: 39px; width:150px;" id="subBtn">
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</article>