<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="">
		<button id="apibtn">버튼</button>

					<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery.js"></script>
					<script type="text/javascript">
					$(function(){
						 $('#apibtn').click(function() {
							 
							$.ajax({
								url:'kakaopay33.mall',
								dataType:'json',
								success:function(data){
									alert(data.tid)
									alert(data.next_redirect_pc_url)
									
									document.cookie = "tid=" + data.tid;
									 var popup = window.open(data.next_redirect_pc_url, 'KakaoPayPopup', 'width=800,height=600');
						                if (!popup) {
						                    alert('팝업 창이 차단되었습니다. 브라우저 설정에서 팝업 차단을 해제해주세요.');
						                }else {
						                    // 팝업이 닫힐 때 이벤트 리스너 추가
						                 
												
												var popupCheck = setInterval(function() {
												    if (popup.closed) {
												        // 팝업이 닫혔을 때 동작
												        window.location.href = 'kakaoOrderSelect.mall';
												        clearInterval(popupCheck);
												    }
												}, 1000); // 주기적으로 확인하는 시간 간격 (1초)
						                }
						                
						               /*  
						                var box = data.next_redirect_pc_url;
										window.open(box);
										*/
						                
								},
								error:function(error){
									alert(error);
								}
							});
						});
					});
						 
					
				 
					</script>
</body>
</html>