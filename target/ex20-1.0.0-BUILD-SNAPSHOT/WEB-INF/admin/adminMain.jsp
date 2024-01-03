<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/adminMain.css">
<%@ include file="adminMenu.jsp"%>

<div>
  <canvas id="myChart"></canvas>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/emn178/chartjs-plugin-labels/src/chartjs-plugin-labels.js"></script>


<style>

#userInfo{
	float:left; 
	margin-left:4%; 
	margin-top:2%;
    align:center;
    background-color: #aaa;
    width: 38%;
    height: 32%;
    line-height: 100px;
    text-align: center;
    background: #fff;
    box-shadow: 3px 5px 7px 5px #eee, 2px 2px 2px rgba(94, 104, 121, .288);
    border-radius: 15px;
}

#feedback{
	float:right;
	margin-right:4%;
	margin-top:2%;
	 align:center;
    background-color: #aaa;
    width: 50%;
    height: 92%;
    line-height: 100px;
    text-align: center;
    padding: 20px;
    margin-left:30px;
    background: #fff;
    box-shadow: 3px 5px 7px 5px #eee, 2px 2px 2px rgba(94, 104, 121, .288);
    border-radius: 15px;
}

.userCount{
	float:left; 
	width:290px; 
	height:270px;
	margin-left:3%; 
}

.visitCount{
	float:left;
	width:250px;
	height:270px;
	margin-left:8px;
}

.orderInfo{
	background-color: #aaa;
    width: 100%;
    margin-top:46%;
    margin-right:70%;
    padding-right:10px;
    background: #fff;
    box-shadow: 3px 5px 7px 5px #eee, 2px 2px 2px rgba(94, 104, 121, .288);
    border-radius: 15px;
}


</style>



<body>

<article id="center" style=" text-align:center; font-family: 'MaruBuri-Regular';" >
	<div class="section">
		<div id="userInfo">
		<div id="user">
			 <div class="userCount" >
			 	<p style="font-weight:bold; font-size:30px;">회원 수 - 22명</p>
			 	<img src="<%= request.getContextPath() %>/resources/image/people-circle-outline.svg" width="42%">
			 </div>
			 <div class="visitCount">
			 	<p style="font-weight:bold; font-size:30px;">방문자 수 - 318명</p>
			 	<img src="<%= request.getContextPath() %>/resources/image/eye-outline.svg" width="47%">
			 </div>
			</div>
			 <div id="order">
				  <div class="orderInfo">
				 	<canvas id="orderChart" width="590px" height="430px"></canvas>
				  </div>  
			 </div>
		</div>
		<div id="feedback">
			<canvas id="feedbackChart" width="700" height="700" padding-right="2%"></canvas>
		</div>
		<br>
	</div>
</article>

<div>
  <canvas id="myChart"></canvas>
</div>
 
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	const ctx = document.getElementById('myChart');

	new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				y: {
				  beginAtZero: true
				}
			}
		}
	});
</script>
 


<script>
	var config = new Chart(document.getElementById("orderChart").getContext('2d'),{
		type: 'line',   // 차트의 종류를 선언한다.
		data: {
			labels: ['봄 라이트', '봄 브라이트', '여름 라이트', '여름 브라이트', '여름 뮤트', '가을 뮤트', '가을 스트롱', '가을 딥','겨울 브라이트','겨울 딥'],
			datasets: [{                             // datasets 값의 배열을 추가하면 그림2와 같이 하나의 canvas에 두가지 데이터를 출력할 수 있다.
				label: '수량'   
				, backgroundColor: 'rgba(178, 204, 255, 0.2)'
				, borderColor: 'rgb(67, 116, 217)'
				, data: [51, 33, 60, 25, 80, 40, 77, 100, 50, 34]
				, fill: true
			}]
		},
		options: {
			responsive: false,    // 차트의 반응형 여부를 정하는 옵션. false일 때, canvas태그에 사이즈 속성을 주면 해당 값으로 고정형 차트가 출력된다. default = true = 반응형.
			title: {
				display: true,              
				text: '퍼스널 컬러 별 주문 수량' 
			},
			scales: {
				xAxes: [{                     
					display: true,                // x축 표시 여부.
					scaleLabel: {                 // 축 라벨에 대한 옵션.
						display: true,        // 라벨 표시 여부.
						labelString: ''  // 라벨 이름.
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: ''
					},
					ticks: {
						beginAtZero: false,   // true일 경우 y축 값이 0부터 시작한다.
	                                                      stepSize: 10          // y축 값의 간격을 지정한다.
					}
				}]
			}
		}
	});
	
	
	
	var config = new Chart(document.getElementById("feedbackChart").getContext('2d'),{
		type: 'bar',   // 차트의 종류를 선언한다.
		data: {
			labels: ['콘텐츠 부족', '이용 불편', '관리 부족', '상품 부족', '비매너 사용자', '새 계정 생성'],
			datasets: [{                                       // datasets 값의 배열을 추가하면 그림2와 같이 하나의 canvas에 두가지 데이터를 출력할 수 있다.
				label: ''   
				, backgroundColor: 'rgba(255, 99, 132, 0.2)'
				, borderColor: 'rgb(255, 99, 132)'
				, data: [51, 33, 20, 25, 15, 40]
				, fill: true
			}]
		},
		options: {
			responsive: false,    // 차트의 반응형 여부를 정하는 옵션. false일 때, canvas태그에 사이즈 속성을 주면 해당 값으로 고정형 차트가 출력된다. default = true = 반응형.
			title: {
				display: true,              
				text: '전부 DB연결은 X...' 
			},
			scales: {
				xAxes: [{                     
					display: true,                // x축 표시 여부.
					scaleLabel: {                 // 축 라벨에 대한 옵션.
						display: true,        // 라벨 표시 여부.
						labelString: ''  // 라벨 이름.
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
						labelString: ''
					},
					ticks: {
						beginAtZero: false,   // true일 경우 y축 값이 0부터 시작한다.
	                                                      stepSize: 10          // y축 값의 간격을 지정한다.
					}
				}]
			}
		}
	});
	
	
 
	new Chart(ctx, {
		type: 'bar',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				y: {
				  beginAtZero: true
				}
			}
		}
	});
</script>

</body>
 