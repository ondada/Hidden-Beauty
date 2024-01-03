<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	#none_under{
		text-decoration: none;
		color: black;
	}
</style>

<%@ include file="../views/header.jsp" %>
	
	<!-- 상단 메뉴바 --> 
	<div style="width: 100%; margin: auto; font-family: 'TheJamsil5Bold'; font-size: 12pt; padding: 10px 0px 12px 300px; border-bottom: 0.5px solid #EAEAEA; background: #F9F9F9; position: fixed; z-index: 98; left: 0px; right: 0px; top: 92px;">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="productMain.p"" id="none_under">메인</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="productBestList.p"" id="none_under">베스트</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="productNewList.p" id="none_under">신상품</a>&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="productAllList.p?whatColumn=cl_color&keyword=전체+조회" id="none_under">전체조회</a>
		&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp; 
		<a href="qBoardList.qb" id="none_under"> 문의 게시판</a>
		<div style="display: inline; left: 763px; position: relative;">  
			<input type="text" id="searchBar" placeholder="Search" style="border: none; border-bottom: 1px solid black; position: absolute; left: -185px; top: -2px; display: none; background: white; border-radius: 5px 5px 0px 0px; font-family: 'RIDIBatang';">&nbsp;&nbsp;
			<a href="javascript:display()" style="text-decoration: none;">
				<img src="resources/image/search.png" width="23">&nbsp;&nbsp; 
			</a>
			<a href="cartList.mall"><img src="resources/image/cart.png" width="23"></a>
		</div>
		<script> 
			var searchDisplay = true;
			
			function display(){
				var con = document.getElementById("searchBar");
				if(con.style.display == "none"){
					con.style.display = "block";
				} else {
					con.style.display = "none";
				}
			}
		</script>
	</div>
