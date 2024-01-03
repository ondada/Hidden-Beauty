<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    #apibtn {
      /* 필요에 따라 다른 스타일을 추가할 수 있습니다. */
      border: none;
      padding: 0; /* 내부 여백 제거 */
      cursor: pointer;
    }
    body{
    	padding-top: 140px; 
    	font-family: 'RIDIBatang';
    	font-size: 15pt;
    } 

</style>

<%@ include file="../product/productHeader.jsp" %>
</head>


<body onload="">
	<div id="center" style="font-family: 'RIDIBatang'; font-size: 12pt;">
	<br><br>
	결제 준비를 완료하신 후, 아래 버튼을 클릭해주세요.<br><br>
	<button id="apibtn">
		<img alt="" src="<%=request.getContextPath() %>/resources/image/kakaobtn.png">
	</button>

					<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery.js"></script>
					<script type="text/javascript">
					$(function(){
						 $('#apibtn').click(function() {
							 
							$.ajax({
								url:'kakaopay33.mall',
								dataType:'json',
								success:function(data){
									//alert(data.tid)
									//alert(data.next_redirect_pc_url)
									
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
					</div>
</body>

<%@ include file="../views/footer.jsp" %>
</html>