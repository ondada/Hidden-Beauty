<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>

<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminCompany.css">

<script type="text/javascript">

	window.onload = function(){
		const radios = document.querySelectorAll("input[name='filter_btn']");
		radios.forEach((radio) => {
			radio.addEventListener("change", (e) => {
				var current = e.currentTarget;
				var whatColumn = document.getElementById('whatColumn');
				var keyword = document.getElementById('keyword');
				location.href='companyList.admin?filter='+current.value+'&whatColumn='+whatColumn.value+'&keyword='+keyword.value;
				
			});
		});
	};

	function init(){
		var elem = document.getElementById('keyword');
		elem.value = '';
	}
	
	function del(cmp_num,pageNumber){
		if(confirm('정말로 삭제하시겠습니까?')){
			location.href='companyDelete.admin?cmp_num='+cmp_num+'&pageNumber='+pageNumber;
		}
	}
</script>
<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
<div class="section">
	<div class="tag">
		<h4>진단 회사 관리</h4>
	</div>
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<div class="search-wrap">
					<form action="companyList.admin" method="post">
						<select name="whatColumn" id="whatColumn" onchange="init()">
							<option value="all">전체검색</option>
							<option value="cmp_name">회사명</option>
							<option value="cmp_addr">주소</option>
							<option value="cmp_station">지하철 역</option>
						</select>
					 	<input type="search" id="keyword" name="keyword" value="${param.keyword }" placeholder="검색어를 입력해주세요.">
					<button type="submit" class="btn btn-dark">검색</button>
				   </form>
				</div>
				<div class="filter_radio" style="margin: auto; width: 90%; height: 40px;">
					<span style="position:relative;right:270px; bottom: 20px;"><input type="radio" name="filter_btn" value="standard" <c:if test="${param.filter eq 'standard' || param.filter eq null}">checked</c:if> style="width:20px;height:18px;"> 기본&nbsp;</span>
					<span style="position:relative;right:270px; bottom: 20px;"><input type="radio" name="filter_btn" value="cmp_priceDesc" <c:if test="${param.filter eq 'cmp_priceDesc'}">checked</c:if> style="width:20px;height:18px;"> 고가순&nbsp;</span>
					<span style="position:relative;right:270px; bottom: 20px;"><input type="radio" name="filter_btn" value="cmp_priceAsc" <c:if test="${param.filter eq 'cmp_priceAsc'}">checked</c:if> style="width:20px;height:18px;"> 저가순&nbsp;</span>
					<span style="position:relative;bottom: 45%;left: 340px; "><input type="button" class="btn btn-white" value="＋추가하기" onClick="location.href='companyInsert.admin'"></span>
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
								<th width="5%" style="padding-left:3%;">번호</th>
								<th width="20%" align="left" style="padding-left:12%;">회사명</th>
								<th width="20%" align="left" style="padding-left:19%;">주소</th>
								<th width="20%" align="left" style="padding-left:16%;">진단 비용</th>
								<th width="20%" align="left" style="padding-left:2%;">지하철 역</th>
								<th width="5%"></th>
							</tr>
							
						</table>
						<div class="middlebox">
							<div class="box2 scrollnone">
								<table class="colr_table2" style="font-size: 13pt; text-align: center;">
									<c:if test="${empty list }">
										<tr>
											<td colspan="12">존재하지 않습니다.</td>
										</tr>
									</c:if>
									
									<c:forEach var="cb" items="${list }">
										<tr style="border-bottom:1px solid #eee;">
											<td style="padding-left:4%;">${cb.cmp_num}</td>
											<td style="padding-left:5%;">${cb.cmp_name}</td>
											<td>${cb.cmp_addr}</td>
											<td>${cb.cmp_price}원</td>
											<td>${cb.cmp_station}</td>
											<td>
												<input type="button" class="btn btn-white"  value="삭제하기" onClick="del(${cb.cmp_num},${pageInfo.pageNumber})">
												<a href="companyUpdate.admin?cmp_num=${cb.cmp_num }&pageNumber=${pageInfo.pageNumber}">
													<input type="button" class="btn btn-white"  value="수정하기" >
												</a>
							 				</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</article>
