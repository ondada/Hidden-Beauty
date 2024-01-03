<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
	#content{
		margin: 0 auto;
		width: 100%;  
		top: -50px;
		position: relative;
		font-family: 'RIDIBatang';
	}  
	#s{
		width: 350px;
		left: 850px;
		top: -40px;
		position: relative;
		
	}
	body{
		padding-top: 90px;
	}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8fb6e61c9516794c3e829ce49ef713c"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
</head>

<%@ include file="../views/header.jsp" %>

<body>


<div id="center">
	<div>
		<br><br><br> 
		<span style="font-family: 'MaruBuri-Regular'; font-size: 28pt; font-weight: bold;">
			퍼스널 컬러 진단 업체 조회
		</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%;">
			&nbsp;&nbsp;AI 진단 외에 더 전문적인 분석 서비스를 받고 싶으신가요?<br>
			&nbsp;&nbsp;수도권 인근의 퍼스널 컬러 진단 업체를 소개해드립니다.<br>
			&nbsp;&nbsp;업체 이름, 인근 지하철역, 주소를 검색해보세요!
		</span>
	</div>
	<br><br>
	
	<form action="company.cmp" method="get">
		<div class="input-group mb-3" id="s">
			<select name ="whatColumn" class="btn btn-outline-secondary dropdown-toggle" style="text-align: left; font-size: 10pt;">
				<option value="all">전체
				<option value="cmp_name">업체 이름
				<option value="cmp_station">지하철역
				<option value="cmp_addr">업체 주소
			</select>
			<input type="text"  name="keyword" class="form-control">
			<input class="btn btn-outline-secondary" type="submit" id="button-addon2"  value="검색" style="font-size: 10pt;"> 
		</div>
	</form>
	<br>
	
	<div id="content">
		<table class="table" width="100%" style="text-align: center;"> 
		  <thead>
		    <tr style="font-size: 13pt;"> 
		      <th scope="col">#</th>
		      <th scope="col">업체 이름</th>
		      <th scope="col">업체 주소</th>
		      <th scope="col">진단비용 (2인 기준)</th>
		      <th scope="col">인근 지하철역</th>
		      <th scope="col">지도에서 조회</th>
		    </tr>
		  </thead>
		  
		  <tbody class="table-group-divider">
			<c:if test="${fn:length(list) == 0}">
				<tr>
					<td colspan="6" style="text-align: center;">검색된 업체가 없습니다.</td>
				</tr>
			</c:if>
	
			<c:if test="${fn:length(list) != 0}">
				<c:forEach var="cb" items="${ list }">
					    <tr>
					      <th scope="row">${cb.cmp_num}</th>
					      <td>${cb.cmp_name}</td>
					      <td>${cb.cmp_addr}</td>
					      <td>
						      <fmt:formatNumber value="${cb.cmp_price }" pattern="#,###" />원
						  </td>
					      <td>${cb.cmp_station}</td>
					      <td>
					      	<a href="marker.cmp?cmp_num=${cb.cmp_num}&pageNumber=${pageInfo.pageNumber}&whatColumn=${whatColumn}&keyword=${keyword}" class="nav-link px-2 link-secondary">
								<img src="resources/image/marker.png" width="25">
							</a>
					      </td>
					    </tr>  
			  	 </c:forEach>
			</c:if>
		</tbody>
	</table>
	</div>
	
	<div style="text-align: center; width: 100%; font-family: 'RIDIBatang';">
		<span id="nonUnder">
			${pageInfo.pagingHtml}
		</span>
		<br><br><br>
		<span style="color: #A6A6A6;">
			* '지도에서 조회' 아이콘을 클릭하시면 이쪽에 지도 이미지가 노출됩니다. *
		</span>
	</div>
	
	<div id="staticMap" style="width:100%; height:350px; top: -30px; position: relative;"></div>
</div>

<script>	 
	var marker = { // 이미지 지도에 표시할 마커입니다
	    position: new kakao.maps.LatLng(${oneY}, ${oneX}), 
	    text: '${oneName}' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
	};
	  
	var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
	    staticMapOption = { 
	        center: new kakao.maps.LatLng(${oneY}, ${oneX}), // 이미지 지도의 중심좌표
	        level: 3, // 이미지 지도의 확대 레벨
	        marker: marker // 이미지 지도에 표시할 마커
	    };
	
	var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption); // 이미지 지도를 생성합니다
</script>
</body>

<%@ include file="../views/footer.jsp" %>

</html>