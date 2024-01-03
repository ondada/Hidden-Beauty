<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css?ver=220613">
<style>
	input[type="text"], select, textarea, ttl_img {
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
	
	table th{
		text-align:left;
	}
	
	.board-table{
	margin-top:20px;
	}
	
}
</style>
<script type="text/javascript">
	var title, detail, ttlImg, dtlImg, ttlSpan, dtlSpan;
	window.onload = function(){
		title = document.getElementById('title');
		ttlImg = document.getElementById('ttl_img');
		ttlSpan = document.getElementById('ttl_name');
		
		detail = document.getElementById('detail');
		dtlImg = document.getElementById('dtl_img');
		dtlSpan = document.getElementById('dtl_name');
		
		ttlImg.addEventListener('click', () => title.click());
		dtlImg.addEventListener('click', () => detail.click());
		
		/* input에 파일이 업로드되면 change event 가 발생 */
		title.addEventListener('change', getTitleImage); // getTitleImage 함수 등록
		detail.addEventListener('change', getDetailImage); // getDetailImage 함수 등록
		
		function getTitleImage(e) {
			var ttlPathSplit = title.value.split('\\'); // 타이틀 이미지의 경로를 구분자 '\\'로 나누기
			var ttlName = ttlPathSplit[ttlPathSplit.length-1];
			alert("들어온 타이틀이미지의 이름: "+ttlName);
			
	     	const file = e.currentTarget.files[0];
	      	const reader = new FileReader(); // file을 담을 변수
	      	reader.readAsDataURL(file);
	      	reader.onload = (e) => {
	      		// 파일이 로드되면 이미지를 해당 파일로 고치기
	      		ttlImg.setAttribute('src', e.target.result);
	      		ttlSpan.innerHTML='<a href="javascript:deleteTtlImg();"><font color="red">x</font></a> '+ttlName;
	        };
	    }
		
		function getDetailImage(e) {
			var dtlPathSplit = detail.value.split('\\'); // 디테일 이미지의 경로를 구분자 '\\'로 나누기
			var dtlName = dtlPathSplit[dtlPathSplit.length-1];
			alert("들어온 디테일이미지의 이름: "+dtlName);
			
	     	const file = e.currentTarget.files[0];
	      	const reader = new FileReader(); // file을 담을 변수
	      	reader.readAsDataURL(file);
	      	reader.onload = (e) => {
	      		// 파일이 로드되면 이미지를 해당 파일로 고치기
	      		dtlImg.setAttribute('src', e.target.result);
	      		dtlSpan.innerHTML='<a href="javascript:deleteDtlImg();"><font color="red">x</font></a> '+dtlName;
	        };
	    }
	};
	function deleteTtlImg(){
		ttlImg.setAttribute('src', '<%=request.getContextPath()%>/resources/image/no-image.jpg');
		ttlSpan.innerHTML='';
	}
	function deleteDtlImg(){
		dtlImg.setAttribute('src', '<%=request.getContextPath()%>/resources/image/no-image.jpg');
		dtlSpan.innerHTML='';
	}
	function checkImg(){
		if(ttlSpan.innerHTML == ''){
			alert('타이틀 이미지를 넣어주세요.');
			return false;
		} else if(dtlSpan.innerHTML == ''){
			alert('디테일 이미지를 넣어주세요.');
			return false;
		} else{
			return true;
		}
	}
</script>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="tag" style="margin-right:83%; font-size: 2em;">
			<h4>상품 정보 수정</h4>
		</div>
		<div id="center" style="text-align: center;">
			<br><br><br><br>
			<div>
				<form action="productUpdate.admin" method="post" enctype="multipart/form-data" onSubmit="return checkImg()">
				<input type="hidden" name="p_num" value="${pb.p_num }">
				<table class="board-table">
					<tr>
						<th width="20%">브랜드</th>
						<td width="80%">
							<input type="text" class="form-control" name="p_brand" value="${pb.p_brand }" required>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input type="text" class="form-control" name="p_name" value="${pb.p_name }" required>
						</td>
					</tr>
					<tr>
						<th>가격</th>
						<td>
							<input type="text" class="form-control" name="p_price" value="${pb.p_price }" required>
						</td>
					</tr>
					<tr>
						<th>지급포인트</th>
						<td>
							<input type="text" class="form-control" name="p_point" value="${pb.p_point }" required>
						</td>
					</tr>
					<tr>
						<th>재고수량</th>
						<td>
							<input type="text" class="form-control" name="p_stock" value="${pb.p_stock }" required>
						</td>
					</tr>
					<tr>
						<th>누적판매량</th>
						<td>
							<input type="text" class="form-control" name="p_salevolume" value="${pb.p_salevolume }" required>
						</td>
					</tr>
					<tr>
						<th>퍼스널컬러</th>
						<td>
							<input type="text" class="form-control" name="p_color" value="${pb.p_color }" required>
						</td>
					</tr>
					<tr>
						<th>제품설명</th>
						<td>
							<textarea class="form-control" name="p_contents" placeholder="제품설명 입력" required>${pb.p_contents }</textarea>
						</td>
					</tr>
					<tr>
						<th>제품사진</th>
						<td>
							<input type="hidden" name="exist_ttl" value="${pb.p_ttlimg }">
							<input type="hidden" name="exist_dtl" value="${pb.p_dtlimg }">
							<input id="title" type="file" name="upload_ttl" accept="image/*" style="display: none">
							<input id="detail" type="file" name="upload_dtl" accept="image/*" style="display: none"> 
							<br>
							* 타이틀이미지 업로드<br> <!-- 기존 타이틀 이미지가 올라가있다. -->
							<img id="ttl_img" alt="타이틀이미지" src="<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_ttlimg  }" style="width:15%; height: 35%; cursor:pointer;"><br>
							<span id="ttl_name"><a href="javascript:deleteTtlImg();"><font color="red">x</font></a> ${pb.p_ttlimg }</span>
							<br><br>
							* 디테일이미지 업로드<br> <!-- 기존 디테일 이미지가 올라가있다. -->
							<img id="dtl_img" alt="디테일이미지" src="<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_dtlimg  }" style="width:15%; height: 35%; cursor:pointer;"><br>
							<span id="dtl_name"><a href="javascript:deleteDtlImg();"><font color="red">x</font></a> ${pb.p_dtlimg }</span>
							<br><br>
							
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<br><br>
							<input type="submit" value="수정하기" id="subBtn">
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>
</article>