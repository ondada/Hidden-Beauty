<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminMenu.jsp"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminProduct.css?ver=2206105">
<script type="text/javascript">
	window.onload = function(){
		const radios = document.querySelectorAll("input[name='filter_btn']");
		radios.forEach((radio) => {
			radio.addEventListener("change", (e) => {
				var current = e.currentTarget;
				var whatColumn = document.getElementById('whatColumn');
				var keyword = document.getElementById('keyword');

				location.href='usersList.admin?filter='+current.value+'&whatColumn='+whatColumn.value+'&keyword='+keyword.value;
				
			});
		});
	};
	 
	function init(){
		var elem = document.getElementById('search');
		elem.value = '';
	}
	function seeReport(){
		var popupW = 800;
		var popupH = 500;
		var popupX = Math.round(window.screenX + (window.outerWidth/2) - (popupW/2));
		var popupY = Math.round(window.screenY + (window.outerHeight/2) - (popupH/2));
		
		var popupWindow = window.open('seeReport.admin', 'login', 'status=no, height='+popupH+', width='+popupW+', left='+popupX+', top='+popupY);
		popupWindow.onresize = (_=>{popupWindow.resizeTo(popupW+20,popupH+70);}) // 팝업창으로 열리는 화면은 사이즈 조절하지 못하도록 설정해두기.
	}
</script>
<style>
	#btn{
		width: 80px;
		font-family: 'RIDIBatang'; 
		font-size: 10pt;
	}
	#btn:hover{
		color: white; 
	}
	#btn2{
		font-family: 'RIDIBatang';
		font-size: 10pt;
		padding: 5px 15px 5px 15px;
		border: 1px solid #A6A6A6;
		border-radius: 8px;
		background: white;
	}
	#btn2:hover {
		background: #E4E4E4;
		cursor: pointer;
	}
</style>
<article id="center" style="top: -15px; position: relative; text-align:center; font-family: 'MaruBuri-Regular';" >
<div class="section">
	<div class="tag">
		<h4>회원 관리</h4>
	</div>
	<div id="board-search">
		<div class="container">
			<div class="search-window">
				<div class="search-wrap">
					<form action="usersList.admin" method="post">
						<select name="whatColumn" id="whatColumn" onchange="init()" >
							<option value="all" <c:if test="${param.whatColumn eq 'all' || param.whatColumn eq null}">selected</c:if>>전체검색</option>
							<option value="u_name" <c:if test="${param.whatColumn eq 'u_name'}">selected</c:if>>이름</option>
							<option value="u_id" <c:if test="${param.whatColumn eq 'u_id'}">selected</c:if>>아이디</option>
							<option value="u_phone" <c:if test="${param.whatColumn eq 'u_phone'}">selected</c:if>>휴대폰번호</option>
						</select>
						<input type="search" id="keyword" name="keyword" <c:if test="${param.keyword ne null }">value="${param.keyword }"</c:if> placeholder="검색어를 입력해주세요.">
						<button type="submit" class="btn btn-dark">검색</button>
					</form>
				</div>
				<div class="filter_radio" style="font-family: 'RIDIBatang'; font-size: 11pt; width: 400px;">
					<span style="top: -20px; position: relative;">
						<input type="radio" name="filter_btn" value="A" style="padding-top: 6px;" <c:if test="${param.filter eq 'A' || param.filter eq null || param.filter eq ''}">checked</c:if> style="width:20px;height:18px;"> 전체 회원&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="filter_btn" value="S" style="padding-top: 6px;" <c:if test="${param.filter eq 'S'}">checked</c:if> style="width:20px;height:18px;"> 기본&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="filter_btn" value="N" style="padding-top: 6px;" <c:if test="${param.filter eq 'N'}">checked</c:if> style="width:20px;height:18px;"> 네이버&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="filter_btn" value="K" style="padding-top: 6px;" <c:if test="${param.filter eq 'K'}">checked</c:if> style="width:20px;height:18px;"> 카카오&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="filter_btn" value="R" style="padding-top: 6px;" <c:if test="${param.filter eq 'R'}">checked</c:if> style="width:20px;height:18px;"> 정지
					</span>
				</div>
				<div style="position: absolute; left: 1573px; top: 195px; height: 20px;">
					<input type="button" id="btn2" value="정지해제 요청 관리" onClick="seeReport()">
				</div>
			</div> 
		</div> 
	</div>
	<div id="board-list" >
		<div class="container" >
			<div class="row">
				<div class="whole1">
					<div class="topbox1"> 
						<table class="board-table" style="font-size: 12pt; text-align: center; table-layout:fixed;">
							<tr style="background: #f4f4f4; height: 50px;">
								<th scope="col" style="width: 68px;">
									<div style="left: -9px; position: relative; display: inline;">번호</div>  
								</th>
								<th scope="col" style="width: 133px;"> 
									<div style="left: -6px; position: relative; display: inline;">아이디</div>
								</th>
								<th scope="col" style="width: 124px;"> 
									<div style="left: -8px; position: relative; display: inline;">이름</div>
								</th>
								<th scope="col" style="width: 160px;">
									<div style="left: -7px; position: relative; display: inline;">휴대폰번호</div> 
								</th> 
								<th scope="col" style="width: 337px;"> 
									<div style="left: -6px; position: relative; display: inline;">주소</div>
								</th>
								<th scope="col" style="width: 121px;">
									<div style="left: -8px; position: relative; display: inline;">보유 포인트</div> 
								</th>
								<th scope="col" style="width: 127px;">
									<div style="left: -6px; position: relative; display: inline;">퍼스널 컬러</div> 
								</th>
								<th scope="col" style="width: 94px;"> 
									<div style="left: -12px; position: relative; display: inline;">가입유형</div> 
								</th>
								<th scope="col" style="width: 143px;">
									<div style="left: -8px; position: relative; display: inline;">가입일</div> 
								</th>
								<th scope="col" style="width: 107px;">
									<div style="left: -8px; position: relative; display: inline;">회원상태</div>
								</th>
								<th scope="col"></th>
							</tr>
						</table>
						<div class="middlebox">
							<div class="box2 scrollnone">
								<table class="colr_table2" style="font-size: 11pt; text-align: center; font-family: 'RIDIBatang';">
									<c:if test="${empty usersLists }">
										<tr style="height: 30px;">
											<td colspan="12">일치하는 회원이 존재하지 않습니다.</td>
										</tr>
									</c:if> 
									
									<c:set var="u_num" value="${fn:length(usersLists)}"/> 
									<c:forEach var="ub" items="${usersLists}">
										<tr style="height: 30px; border: 1px dotted #D5D5D5;"> 
											<td width="4.4%">
												${u_num }
												<c:set var="u_num" value="${u_num-1 }"/> 
											</td>
											<td width="8.2%"> 
												<c:if test="${ub.u_jointype eq 'N' }">
													네이버 연동
												</c:if>
												<c:if test="${ub.u_jointype eq 'K' }">
													카카오 연동
												</c:if>
												<c:if test="${ub.u_jointype eq 'S' }">
													${ub.u_id}
												</c:if>
											</td>
											<td width="8%">${ub.u_name}</td>
											<td width="10%">${ub.u_phone}</td> 
											<td width="21%">${ub.u_address}</td> 
											<td width="8%">
												<fmt:formatNumber value="${ub.u_point}" pattern="#,###" />
											</td>
											<td width="8%">${ub.u_color}</td> 
											<c:if test="${ub.u_jointype eq 'S'}">
												<td width="6%">기본</td> 
											</c:if>
											<c:if test="${ub.u_jointype eq 'N'}">
												<td width="6%">네이버</td>
											</c:if>
											<c:if test="${ub.u_jointype eq 'K'}">
												<td width="6%">카카오</td>
											</c:if>
											<td width="9%">${ub.u_joindate }</td>
											<td width="7%">
												<c:if test="${ub.u_report > 5}"><font color="red"><b>정지</b></font></c:if>
												<c:if test="${ub.u_report <= 5}">-</c:if>
											</td>
											<td width="18%">
												<a href="usersDelete.admin?u_id=${ub.u_id }&u_jointype=${ub.u_jointype}">
													<input type="button" id="btn" class="btn btn-white" 
														<c:if test="${ub.u_jointype eq 'N' || ub.u_jointype eq 'K'}">
															value="연동해제"
														</c:if>
														<c:if test="${ub.u_jointype eq 'S'}">
															value="회원삭제"
														</c:if>
													>
												</a>
												<a href="usersUpdate.admin?u_id=${ub.u_id }">
													<input type="button" id="btn" class="btn btn-white"  value="정보수정">
												</a>
												<a href="javascript:if(${ub.u_report <= 5}){alert('정지 회원이 아닙니다.');}else{location.href='report.admin?u_id=${ub.u_id }&filter=${param.filter}&whatColumn=${param.whatColumn}&keyword=${param.keyword}'}">
													<input type="button" id="btn" class="btn btn-white" style="color: red;" value="정지해제">
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


