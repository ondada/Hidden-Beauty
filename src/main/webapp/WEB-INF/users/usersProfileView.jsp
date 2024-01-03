<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/usersProfileView.css?ver=2209967">
<head>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
		rel="stylesheet"
		integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- moment 라이브러리 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script>
		window.onload = function() {
			$(function() {
				// 작성글을 불러오는 ajax 설정
				$.ajax({
					url: 'postAjax.cb?c_writer=${c_writer}',
					async: false,
					success: function(post) { // 성공적으로 받아왔을 경우
						post.forEach(function(e){
							if(e.c_num != null){
								var date = new Date(e.c_regdate);
								var now24Date = moment(date).format("YYYY-MM-DD");
								var html = '';
								
								html += '<tr>';
								html += '	<td>'+e.c_num+'</td>';
								html += '	<td><a class="subject" href="javascript:gotoPage('+e.c_num+')">';
								if(e.c_subject.length > 15)
									html += e.c_subject.substr(0, 15)+'...';
								else
									html += e.c_subject;
								html += '</a></td>';
								html += '	<td>'+now24Date+'</td>';
								html += '	<td>'+e.c_readcount+'</td>';
								html += '</tr>';
								$('#post-table').append(html);
							} else{
								if(e.pagingHtml === ''){
									$('#post-table').append('<tr><td colspan="4">작성한 글이 없습니다.</td></tr>');
								} else{
									$('#post-page').append(e.pagingHtml);
								}
							}
						});
					}
				});
				// 답글을 불러오는 ajax 설정 
				$.ajax({
					url: 'commentAjax.cb?c_writer=${c_writer}',
					async: false,
					success: function(comment) { // 성공적으로 받아왔을 경우
						comment.forEach(function(e){
							if(e.c_num != null){
								var date = new Date(e.c_regdate);
								var now24Date = moment(date).format("YYYY-MM-DD");
								var html = '';
								
								html += '<tr>';
								html += '	<td>'+e.c_num+'</td>';
								html += '	<td><a class="subject" href="javascript:gotoPage('+e.c_num+')">';
								if(e.c_subject.length > 15)
									html += e.c_subject.substr(0, 15)+'...';
								else
									html += e.c_subject;
								html += '</a></td>';
								html += '	<td>'+now24Date+'</td>';
								html += '	<td>'+e.c_readcount+'</td>';
								html += '</tr>';
								$('#comment-table').append(html);
							} else{
								if(e.pagingHtml === ''){
									$('#comment-table').append('<tr><td colspan="4">작성한 댓글이 없습니다.</td></tr>');
								} else{
									$('#comment-page').append(e.pagingHtml);
								}
							}
						});
					}
				});
				checkEvent();
			});
		};
		function ajax(url, pageNumber){
			console.log("ajax 함수 호출..");
			var postOrComment = '';
			if(url === 'postAjax.cb'){
				postOrComment = 'post';
			} else{
				postOrComment = 'comment';
			}
			$.ajax({
				url: url+'?c_writer=${c_writer}&pageNumber='+pageNumber,
				async: false,
				success: function(element) {
					$('#'+postOrComment+'-table').html('');
					element.forEach(function(e){
						if(e.c_num != null){
							var date = new Date(e.c_regdate);
							var now24Date = moment(date).format("YYYY-MM-DD");
							var html = '';
							
							html += '<tr>';
							html += '	<td>'+e.c_num+'</td>';
							html += '	<td><a class="subject" href="javascript:gotoPage('+e.c_num+')">';
							if(e.c_subject.length > 15)
								html += e.c_subject.substr(0, 15)+'...';
							else
								html += e.c_subject;
							html += '	</a></td>';
							html += '	<td>'+now24Date+'</td>';
							html += '	<td>'+e.c_readcount+'</td>';
							html += '</tr>';
							
							$('#'+postOrComment+'-table').append(html);
						} else{
							$('#'+postOrComment+'-page').html('');
							$('#'+postOrComment+'-page').append(e.pagingHtml);
						}
					});
				}
			});
			checkEvent();
		}
		function checkEvent(){
			const subjects = document.querySelectorAll('.subject');
			subjects.forEach((subject) => {
				subject.addEventListener('click', (e) => {
					
				});
			});
		}
		function gotoPage(c_num){
			window.open('detail.cb?c_num='+c_num);
		}
		function convert(e, u_id, type){
			if(e.className === 'off'){
				document.querySelector('.on').className = 'off'; // 기존 'on'클래스를 'off'클래스로 클래스명 변경.
				e.className = 'on'; //  클릭이벤트가 발생한 e, 즉 'off'클래스를 'on'클래스로 클래스명 변경.
				
				if(type === 'post'){
					document.getElementById('post-list').style.display = 'block';
					document.getElementById('post-page').style.display = 'block';
					document.getElementById('comment-list').style.display = 'none';
					document.getElementById('comment-page').style.display = 'none';
					
				} else{
					document.getElementById('comment-list').style.display = 'block';
					document.getElementById('comment-page').style.display = 'block';
					document.getElementById('post-list').style.display = 'none';
					document.getElementById('post-page').style.display = 'none';
					
				}
			}
		}
	</script>
</head>
<body style="margin: auto;">
	<div class="profile-container">
		<div class="main-container">
			<div class="img-box">
				<c:if test="${ub.u_profileimg eq null }"> 
					<img  src="resources/image/person.svg" class="rounded-circle">
				</c:if>
				<c:if test="${ub.u_profileimg ne null }">
					<img  src="resources/uploadFolder/users/${ub.u_profileimg }" class="rounded-circle">
				</c:if>
			</div>
			<div class="explain-box" style="font-family: 'RIDIBatang';">
				<h1 style="background-color: #7C81BB">
					<c:if test="${ub.u_jointype eq 'N' }">&nbsp;네이버 연동 회원&nbsp;</c:if>
					<c:if test="${ub.u_jointype eq 'K' }">&nbsp;카카오 연동 회원&nbsp;</c:if>
					<c:if test="${ub.u_jointype eq 'S' }">&nbsp;${ub.u_id }&nbsp;</c:if>
				</h1><br>
				<font>${ub.u_color } </font>
				<c:if test="${fn:contains(ub.u_color, '봄')}">
					<img src="resources/image/spring-mainImg.png">
				</c:if>
				<c:if test="${fn:contains(ub.u_color, '여름')}">
					<img src="resources/image/summer-mainImg.png">
				</c:if>
				<c:if test="${fn:contains(ub.u_color, '가을')}">
					<img src="resources/image/fall-mainImg.png">
				</c:if>
				<c:if test="${fn:contains(ub.u_color, '겨울')}">
					<img src="resources/image/winter-mainImg.png">
				</c:if>
				<%-- <c:if test="${fn:contains(ub.u_color, '잘')}">
					여기는 물음표 이미지 구해와야함.
				</c:if> --%> <br>
				<!-- <font>방문 </font><b>5</b>&nbsp;&nbsp; --><!-- user 칼럼에 방문 수 칼럼 추가해야.. -->
				<font>작성글 </font><b>${postCount }</b>&nbsp;&nbsp;
				<font>답글 </font><b>${commentCount }</b><br>
				<font>${ub.u_intro }</font><br>
			</div>
		</div>
		<div class="board-container" style="font-family:'RIDIBatang';">
			<p onclick="convert(this,'${ub.u_id }','post')" class="on" style="margin-left: 5%;">작성글</p>
			<p onclick="convert(this,'${ub.u_id }','comment')" class="off" style="margin-left: 3%;">답글</p>
			<div class="list-box">
				<div id="post-list" style="display: block;">
					<table>
						<tr>
							<th width="3%"></th>
							<th width="10%">제목</th>
							<th width="5%">작성일</th>
							<th width="5%">조회</th>
						</tr>
						<tbody id="post-table">
						</tbody>
					</table>
				</div>
				<div id="comment-list" style="display: none;">
					<table>
						<tr>
							<th width="3%"></th>
							<th width="10%">제목</th>
							<th width="5%">작성일</th>
							<th width="5%">조회</th>
						</tr>
						<tbody id="comment-table">
						</tbody>
					</table>
				</div>
			</div>
			<div id="post-page" style="display: block;"></div>
			<div id="comment-page" style="display: none;"></div>
		</div>
	</div>

</body>