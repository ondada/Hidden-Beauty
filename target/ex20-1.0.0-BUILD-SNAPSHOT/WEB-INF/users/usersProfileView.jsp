<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/usersProfileView.css?ver=2209982">
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
				$.ajax({
					url: 'cBoardAjax.cb?c_writer=${c_writer}',
					success: function(data) { // 성공적으로 받아왔을 경우
						alert(data);
						/* $(data).each(function() { 
							// *** 답글만 달고 글을 쓴 적 없는 사람도 고려해야함.
							var date = new Date(this.c_regdate);
							var now24Date = moment(date).format("YYYY-MM-DD");
							var html = '';
							html += '<tr>';
							html += '	<td width="3%" align="center">'+this.c_num+'</td>';
							html += '	<td width="10%"><a href="#">'+this.c_subject+'</a></td>';
							html += '	<td width="5%" align="center">'+now24Date+'</td>';
							html += '	<td width="5%" align="center">'+this.c_readcount+'</td>';
							html += '</tr>';
							$('#post-table').append(html);
						});
						$('#post-list').append('${pagingHtml}'); */
					}
				});
				// 댓글단 글을 불러오는 ajax 설정 
				$.ajax({
					/* url: '',
					success: function(data) { // 성공적으로 받아왔을 경우
						$(data).each(function() {
							var date = new Date(this.c_regdate);
							var now24Date = moment(date).format("YYYY-MM-DD");
							var html = '';
							html += '<tr>';
							html += '	<td>'+this.c_num+'</td>';
							html += '	<td>'+this.c_subject+'</td>';
							html += '	<td>'+now24Date+'</td>';
							html += '	<td>'+this.c_readcount+'</td>';
							html += '</tr>';
							$('#comment-table').append(html);
						});
					} */
				});
			});
		};
		function convert(e, u_id, type){
			if(e.className === 'off'){
				// 기존 'on'클래스를 'off'클래스로 클래스명 변경.
				document.querySelector('.on').className = 'off';
				//  클릭이벤트가 발생한 e, 즉 'off'클래스를 'on'클래스로 클래스명 변경.
				e.className = 'on';
				if(type === 'post'){
					document.getElementById('post-list').style.display = 'block';
					document.getElementById('comment-list').style.display = 'none';
					
				} else{
					document.getElementById('comment-list').style.display = 'block';
					document.getElementById('post-list').style.display = 'none';
					
				}
				// 기존 'on'클래스는 보이지 않게 하면서,
				// 'off'클래스로 클래스명을 변경해준다.
				//document.querySelector('.on').style.display = 'none';
				
				// 클릭이벤트가 발생한 e, 즉 'off'클래스는 보이게 하면서,
				// 'on'클래스로 클래스명을 변경해준다.
				//e.style.display = 'block';
			}
		}
	</script>
</head>
<body>
	<!-- border-dark-subtle: 테두리 색상 -->
	<!-- Today, 방문수, 작성글, 댓글단 글, 퍼스널컬러, 조인데이트, 자기소개, -->
	<div class="profile-container" style="border: 1px solid blue; width: 80%; height: 80%; margin: auto; position: relative; top: 10%;">
		<h1 style="font-family: 'RIDIBatang';">${ub.u_id }의 프로필</h1>
		<div class="main-container" style="border: 1px solid green;">
			<div class="img-box" style="border: 1px solid red;">
				<c:if test="${ub.u_profileimg eq null }">
					<img  src="resources/image/person.svg" class="border border-5 border-dark-subtle rounded-circle">
				</c:if>
				<c:if test="${ub.u_profileimg ne null }">
					<img  src="${ub.u_profileimg }" class="border border-5 border-dark-subtle rounded-circle">
				</c:if>
			</div>
			<div class="explain-box" style="border: 1px solid black; font-family: 'MaruBuri-Regular';">
				방문: <br> <!-- user 칼럼에 방문 수 칼럼 추가해야.. -->
				작성글:<br> <!-- 작성글 수 -->
				댓글단 글:<br> <!-- 댓글단 글 수 -->
				퍼스널컬러: ${ub.u_color }<br>
				가입일: ${ub.u_joindate }<br>
				자기소개: ${ub.u_intro }<br>
			</div>
		</div>
		<!--  color="#7C81BB" -->
		<!-- <font face="RIDIBatang"></font> -->
		<%-- onclick="show(this,'${ub.u_id }')" --%>
		<div class="board-container" style="border: 1px solid fuchsia;">
			<p onclick="convert(this,'${ub.u_id }','post')" class="on" style="font-family:'RIDIBatang'; margin-left: 5%;">작성글</p>
			<p onclick="convert(this,'${ub.u_id }','comment')" class="off" style="font-family:'RIDIBatang'; margin-left: 3%;">댓글단 글</p>
			<div class="list-box" style="border: 1px solid black; margin-top: 2%;">
				<div id="post-list" style="display: block;">
					<table id="post-table" border="1">
						<tr>
							<th></th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
					</table>
					${pageInfo.pagingHtml }
				</div>
				<div id="comment-list" style="display: none; width: 100%; height: 70%;">
					<table id="comment-table" border="1">
						<tr>
							<th></th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회</th>
						</tr>
						<!-- 임시로 넣어놓음 -->
						<tr>
							<td colspan="5">
								작성한 댓글이 없습니다.
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>

