<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompanyUpdate.css?ver=220633">

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
			alert(title.value);
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
			<div>
				<form action="productUpdate.admin" method="post" enctype="multipart/form-data" onSubmit="return checkImg()">
				<input type="hidden" name="p_num" value="${pb.p_num }">
				<table class="board-table">
					<tr>
						<th>브랜드</th>
						<td>
							<input type="text" class="form-control" name="p_brand" value="${pb.p_brand }" required>
						</td>
						<th>이름</th>
						<td colspan="2">
							<input type="text" id="name-input" class="form-control" name="p_name" value="${pb.p_name }" required>
						</td>
						<th>퍼스널컬러</th>
						<td>
							<c:set var="pcList">봄 라이트,봄 브라이트,여름 라이트,여름 브라이트,여름 뮤트,가을 뮤트,가을 스트롱,가을 딥,겨울 브라이트,겨울 딥</c:set>
							<select name="p_color">
								<c:forEach var="pc" items="${pcList }">
									<option value="${pc }" <c:if test="${pc eq pb.p_color }">selected</c:if>>${pc }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>가격</th>
						<td>
							<input type="text" class="form-control" name="p_price" value="${pb.p_price }" required>
						</td>
						<th>지급포인트</th>
						<td colspan="4">
							<input type="text" class="form-control" name="p_point" value="${pb.p_point }" required>
						</td>
					</tr>
					<tr>
						<th>재고수량</th>
						<td>
							<input type="text" class="form-control" name="p_stock" value="${pb.p_stock }" required>
						</td>
						<th>누적판매량</th>
						<td colspan="4" style="border-bottom: 1px solid #e7e7e7;">
							<input type="text" class="form-control" name="p_salevolume" value="${pb.p_salevolume }" required>
						</td>
					</tr>
					<tr>
						<th>제품설명</th>
						<td>
							<textarea class="form-control" name="p_contents" required>${pb.p_contents }</textarea>
						</td>
						<th>제품사진</th>
						<td>
							<input type="hidden" name="exist_ttl" value="${pb.p_ttlimg }">
							<input id="title" type="file" name="upload_ttl" accept="image/*" style="display: none">
							* 타이틀이미지 업로드<br><br> <!-- 기존 타이틀 이미지가 올라가있다. -->
							<img id="ttl_img" alt="타이틀이미지" src="<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_ttlimg }"><br><br>
							<span id="ttl_name"><a href="javascript:deleteTtlImg();"><font color="red">x</font></a> ${pb.p_ttlimg }</span>
							<br><br>
						</td>
						<td>
							<input type="hidden" name="exist_dtl" value="${pb.p_dtlimg }">
							<input id="detail" type="file" name="upload_dtl" accept="image/*" style="display: none"> 
							* 디테일이미지 업로드<br><br> <!-- 기존 디테일 이미지가 올라가있다. -->
							<img id="dtl_img" alt="디테일이미지" src="<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_dtlimg }"><br><br>
							<span id="dtl_name"><a href="javascript:deleteDtlImg();"><font color="red">x</font></a> ${pb.p_dtlimg }</span>
							<br><br>
						</td>
					</tr>
					<tr>
						<td colspan="8" align="center">
							<br><br>
							<input type="submit" value="수정하기" id="subBtn" class="btn btn-white">
						</td>
					</tr>
				</table>
				</form>
			</div>
		</div>
	</div>
</article>