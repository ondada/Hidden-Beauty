<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminProduct.css?ver=22023464">
<script type="text/javascript">
	window.onload = function(){
		const radios = document.querySelectorAll("input[name='filter_btn']");
		
		radios.forEach((radio) => {
			radio.addEventListener("change", (e) => {
				var current = e.currentTarget;
				var whatColumn = document.getElementById('whatColumn');
				var keyword = document.getElementById('keyword');
				location.href='productList.admin?filter='+current.value+'&whatColumn='+whatColumn.value+'&keyword='+keyword.value;
			});
		});
	};
	
	// 기존 검색어 지우기
	function init(){
		var elem = document.getElementById('keyword');
		elem.value = '';
	}

	function delBtn(p_num){
		if(confirm('정말로 삭제하시겠습니까?')){
			location.href='productDelete.admin?p_num='+p_num;
		}
	}
	
	function imgPopup(url){
		var img = new Image();
		img.src = url;
		img.onload = function(){
			var imgWidth = img.width;
			var imgHeight = img.height;
			var winWidth = imgWidth+25;
			var popupImg = window.open('', '_blank', 
					'width='+imgWidth+
					', height='+imgHeight+
					', menubars=no, scrollbars=auto'
					);
			popupImg.document.write('<img src="'+url+'" width="'+winWidth+'">');
		}
	}
</script>
<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
<div class="section">
	<div class="tag">
		<h4>상품 관리</h4>
	</div>
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<div class="search-wrap">
					<form action="productList.admin" method="post">
						<select name="whatColumn" id="whatColumn" onchange="init()" >
							<option value="all" <c:if test="${param.whatColumn eq 'all' || param.whatColumn eq null}">selected</c:if>>전체검색</option>
							<option value="p_brand" <c:if test="${param.whatColumn eq 'p_brand'}">selected</c:if>>브랜드</option>
							<option value="p_name" <c:if test="${param.whatColumn eq 'p_name'}">selected</c:if>>상품명</option>
							<option value="p_color" <c:if test="${param.whatColumn eq 'p_color'}">selected</c:if>>퍼스널컬러</option>
						</select>
						<input type="search" id="keyword" name="keyword" <c:if test="${param.keyword eq null }">value=""</c:if> <c:if test="${param.keyword ne null }">value="${param.keyword }"</c:if> placeholder="검색어를 입력해주세요.">
						<button type="submit" class="btn btn-dark">검색</button>
					</form>
				</div>
				<div class="filter_radio">
					<span style="position:relative;right:18%;bottom:40%;"><input type="radio" name="filter_btn" value="standard" <c:if test="${param.filter eq 'standard' || param.filter eq null || param.filter eq ''}">checked</c:if> style="width:20px;height:18px;"> 기본&nbsp;</span>
					<span style="position:relative;right:14.5%;bottom:40%;"><input type="radio" name="filter_btn" value="p_stock" <c:if test="${param.filter eq 'p_stock'}">checked</c:if> style="width:20px;height:18px;"> 재고임박순&nbsp;</span>
					<span style="position:relative;right:12%;bottom:40%;"><input type="radio" name="filter_btn" value="p_salevolume" <c:if test="${param.filter eq 'p_salevolume'}">checked</c:if> style="width:20px;height:18px;"> 누적판매량순&nbsp;</span>
					<span style="position:relative;right:10.5%;bottom:40%;"><input type="radio" name="filter_btn" value="p_priceDesc" <c:if test="${param.filter eq 'p_priceDesc'}">checked</c:if> style="width:20px;height:18px;"> 고가순&nbsp;</span>
					<span style="position:relative;right:8%;bottom:40%;"><input type="radio" name="filter_btn" value="p_priceAsc" <c:if test="${param.filter eq 'p_priceAsc'}">checked</c:if> style="width:20px;height:18px;"> 저가순&nbsp;</span>
					<!-- 출고일(혹은 입고일) 칼럼을 넣어야 할까.. -->
					<span style="position:relative;bottom: 40%;left: 18%; "><input type="button" class="btn btn-white" value="+ 추가하기" onClick="location.href='productInsert.admin'"></span>
				</div>
			</div>
		</div>
	</div>
	<div id="board-list" >
		<div class="container" >
			<div class="row">
				<div class="whole1">
					<div class="topbox1">
						<table class="board-table" style="font-size: 13pt; text-align: center; table-layout:fixed;">
							<tr style="background: #f4f4f4;">
								<th scope="col" class="th-num" style="padding-left: 2.7%;">번호</th>
								<th scope="col" class="th-brand" style="padding-left: 3%;">브랜드</th>
								<th scope="col" class="th-name" style="padding-left: 12%;">이름</th>
								<th scope="col" class="th-price" style="padding-left: 16.3%;">가격</th>
								<th scope="col" class="th-stock" style="padding-left: 11.5%;">재고수량</th>
								<th scope="col" class="th-salevolume" style="padding-left: 7%;">누적판매량</th>
								<th scope="col" class="th-personalc" style="padding-right: 0.1%;">퍼스널컬러</th>
								<th scope="col" class="th-delete"></th>
								<th scope="col" class="th-update"></th>
							</tr>
							
						</table>
						<div class="middlebox">
							<div class="box2 scrollnone">
								<table class="colr_table2" style="font-size: 13pt; text-align: center;">
									<c:if test="${empty prodLists }">
										<tr>
											<td colspan="12">존재하지 않는 상품 입니다.</td>
										</tr>
									</c:if>
									
									<c:forEach var="pb" items="${prodLists }">
										<tr>
											<td width="30px">${pb.p_num }</td>
											<td width="70px">${pb.p_brand }</td>
											<td width="90px">${pb.p_name }&nbsp;&nbsp;
												<span class="ttl-img" onClick="imgPopup('<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_ttlimg }')">
													<font color="#C98BA4" title="${pb.p_ttlimg }">
														<ion-icon name="image-outline"></ion-icon>
													</font>
												</span>
												<span class="dtl-img" onClick="imgPopup('<%=request.getContextPath()%>/resources/uploadFolder/product/${pb.p_dtlimg }')">
													<font color="#E7B3CE" title="${pb.p_dtlimg }">
														<ion-icon name="image-outline"></ion-icon>
													</font>
												</span>
											</td>
											<td width="50px">${pb.p_price }</td>
											<td width="50px">${pb.p_stock }</td>
											<td width="50px">${pb.p_salevolume }</td>
											<td width="13%">${pb.p_color }</td>
							 				<td width="15%">
												<input type="button" class="btn btn-white" value="삭제하기" onClick="delBtn('${pb.p_num }')">
							 					<a href="productUpdate.admin?p_num=${pb.p_num }">
													<input type="button" class="btn btn-white" value="수정하기">
												</a>
							 				</td>
										</tr>
									</c:forEach>
								</table>
								${pageInfo.pagingHtml }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</article>


