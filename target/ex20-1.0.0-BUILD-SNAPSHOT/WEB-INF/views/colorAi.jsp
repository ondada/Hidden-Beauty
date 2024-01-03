<%@page import="users.model.UsersBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
.modal {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: none;
	background-color: rgba(0, 0, 0, 0.4);
}
.modal.show {
	display: block;
}
.modal_body {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 700px;
	height: 450px;
	padding: 45px 40px 40px 40px;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateX(-50%) translateY(-50%);
	font-family: 'RIDIBatang';
	font-size: 11pt;
	line-height: 180%;
}

#info{
	border: none;
	border-radius: 10px;
	background: #7C81BB;
	color: white;
	width: 90px;
	font-family: 'RIDIBatang';
	font-size: 12pt;
}

#info:hover{
	background: #B3B3CE;
}

.file-upload {
  background-color: #ffffff;
  width: 600px;
  margin: 0 auto;
  padding: 20px;
}

.file-upload-btn {
  width: 100%;
  margin: 0;
  color: #fff;
  background: #808080;
  border: none;
  padding: 10px;
  border-radius: 5px;
  border-bottom: 5px solid #b3b3b3;
  transition: all .2s ease;
  outline: none;
  text-transform: uppercase;
  font-weight: 700;
}

.file-upload-btn:hover {
  background: #4d4d4d;
  color: #ffffff;
  transition: all .2s ease;
  cursor: pointer;
}

.file-upload-btn:active {
  border: 0;
  transition: all .2s ease;
}

.file-upload-content {
  display: none;
  text-align: center;
}

.file-upload-input {
  position: absolute;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  outline: none;
  opacity: 0;
  cursor: pointer;
}

.image-upload-wrap {
  margin-top: 20px;
  border: 1px dashed #cccccc;
  position: relative;
  height: 500px;
  width: 1000px;
  display: table-cell;
  vertical-align: middle;
}

.image-dropping,
.image-upload-wrap:hover { 
  background-color: #EAEAEA;
  border: 1px dashed #ffffff;
}

.image-title-wrap {
  color: #222;
}

.drag-text {
  font-size: 16px;
  font-family: 'RIDIBatang';
  text-transform: uppercase;
  text-align: center;
  color: #808080;
  padding: 60px 0;
}

.file-upload-image {
  max-width: 300px;
  margin: auto;
  padding: 20px;
}

.remove-image {
  font-size:15px;
  width: 300px;
  margin: 0;
  color: #fff;
  background: #cd4535;
  border: none;
  padding: 10px;
  border-radius: 4px;
  transition: all .2s ease;
  outline: none;
  text-transform: uppercase;
  font-family: 'RIDIBatang'; 
}

.remove-image:hover {
  background: #c13b2a;
  color: #ffffff;
  transition: all .2s ease;
  cursor: pointer;
}

.remove-image:active {
  border: 0;
  transition: all .2s ease;
}

  #label-container {
    width: 600px;
    background-color: #EAEAEA;
    font-size: 15px;
    font-family: 'RIDIBatang';
    border-radius: 10px;  
    border: 1px solid white;
    margin: auto;
    }

#finish {
  width: 560px;
  margin: 0;
  color: #fff;
  background: #808080;
  border: none;
  padding: 10px;
  border-radius: 5px;
  transition: all .2s ease;
  outline: none;
  text-transform: uppercase;
  font-family: 'RIDIBatang';
  font-size: 13pt;
}

#finish:hover {
  background: #4d4d4d;
  color: #ffffff;
  transition: all .2s ease;
  cursor: pointer;
}
.img {
	animation: rotate_image 15s linear infinite; 
	transform-origin: 50% 50%; 
	position: absolute;
	left: 413px;
	display: none;
}

@keyframes rotate_image{
    100% {
        transform: rotate(360deg);
    }
}

body{
	padding-top: 90px;
}


#loading-overlay {
    
    
    display: none;
    
    font-family: 'RIDIBatang';
    font-size: 16pt;
  }
</style>

<%
UsersBean ub = (UsersBean)session.getAttribute("loginInfo");
if(ub==null){
	session.setAttribute("destination", "redirect:/colorAi.ai");
%>
	<script type="text/javascript">
		alert("로그인 후 이용 가능합니다.")
		window.location.href = "login.u";
	</script>
<%
};
%>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest/dist/tf.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@latest/dist/teachablemachine-image.min.js"></script>
<script type="text/javascript">
function showLoading() {
	 
    $("#loading-overlay").show();
  }
function hideLoading() {
    $("#loading-overlay").hide();
  }
      const URL = "https://teachablemachine.withgoogle.com/models/L1G8-g-Oz/";
      var prediction;
      var maxProbability;
      var maxProbabilityIndex;

      let model, webcam, labelContainer, maxPredictions;
  
      async function init() {
        const modelURL = URL + "model.json";
        const metadataURL = URL + "metadata.json";

        model = await tmImage.load(modelURL, metadataURL);
        maxPredictions = model.getTotalClasses();

        labelContainer = document.getElementById("label-container");
        for (let i = 0; i < maxPredictions; i++) { // and class labels
          labelContainer.appendChild(document.createElement("div"));
        }
      }

      async function predict() {
    	  showLoading();
        var image = document.getElementById("face-image")
        prediction = await model.predict(image, false);
        
       	maxProbabilityIndex = 0;
        maxProbability = prediction[0].probability;
        
        for (let i = 0; i < maxPredictions-1; i++) {
        	if (prediction[i].probability > maxProbability) {
                maxProbability = prediction[i].probability;
                maxProbabilityIndex = i;
            }
        }
        hideLoading();
        let resultText = "<br><br><table style='margin-left:35%; width:40%; height:300px;'>";
        for (let i = 0; i < maxPredictions; i++) {
            var classPrediction = "<tr><td width='40%'>" + prediction[i].className + "</td><td width='10%'> : </td><td width='40%' align='left'>" + (prediction[i].probability ).toFixed(2)*1000/10+"%</td><tr>";
            resultText += classPrediction;
        }
        
        labelContainer.childNodes[1].innerHTML = resultText +"</tr></table><br><br>";
        
        if (maxProbability >= 0.3) {
            switch (prediction[maxProbabilityIndex].className) {
            case "봄 라이트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 봄 라이트 '</b> 입니다.</big><br>";
                break;
            case "봄 브라이트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 봄 브라이트 '</b> 입니다.</big><br>";
                break;
            case "여름 라이트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 여름 라이트 '</b> 입니다.</big><br>";
                break;
            case "여름 브라이트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 여름 브라이트 '</b> 입니다.</big><br>";
                break;
            case "여름 뮤트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 여름 뮤트 '</b> 입니다.</big><br>";
                break;
            case "가을 뮤트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 가을 뮤트 '</b> 입니다.</big><br>";
                break;
            case "가을 스트롱":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 가을 스트롱 '</b> 입니다.</big><br>";
                break;
            case "가을 딥":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 가을 딥 '</b> 입니다.</big><br>";
                break;
            case "겨울 브라이트":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 겨울 브라이트 '</b> 입니다.</big><br>";
                break;
            case "겨울 딥":
                labelContainer.childNodes[0].innerHTML = "<br><br><big><b>' 겨울 딥 '</b> 입니다</big><br>";
                break;
            case "그 외":
                labelContainer.childNodes[0].innerHTML = "<br><br><big>이 사진으로는 측정할 수 없어요!<br> 다른 사진을 넣어 주시겠어요?</big><br";
                break;
                }
        }
        else {
            labelContainer.childNodes[0].innerHTML = "<br><br><big>이 사진으로는 측정할 수 없어요!<br> 다른 사진을 넣어 주시겠어요?</big><br>";
        }
    }
      
      function go_update(){
    	  // alert(prediction[maxProbabilityIndex].className); 퍼스널컬러 결과값.
    	  location.href="updateColor.u?personalColor="+prediction[maxProbabilityIndex].className;
      }
      
      $(function(){
    	  $("#finish").click(function(){
    		  $("#elseArea").show();
    		  $("#label-container").show();
    	  });
    	  
    	  $("#result").mouseover(function(){
    		  $("#1st_circle").show();
    		  $("#go1").css({"color":"#7C81BB"});
    	  });
    	  
    	  $("#result").mouseout(function(){
    		  $("#1st_circle").hide();
    		  $("#go1").css({"color":"#D5D5D5"});
    	  });
    	  
    	  $("#company").mouseover(function(){
    		  $("#2nd_circle").show();
    		  $("#go2").css({"color":"#7C81BB"});
    	  });
    	  
    	  $("#company").mouseout(function(){
    		  $("#2nd_circle").hide();
    		  $("#go2").css({"color":"#D5D5D5"});
    	  });
    	  
      });
      
    </script>

 <script> 

      function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
            $('.image-upload-wrap').hide();
            $('.file-upload-image').attr('src', e.target.result);
            $('.file-upload-content').show();
            $('.image-title').html(input.files[0].name);
          };

          reader.readAsDataURL(input.files[0]);

        } else {
          removeUpload();
        }
      }

		function removeUpload() {
			//location.href="colorAi.ai";
			$('.file-upload-input').replaceWith($('.file-upload-input').clone());
			$('.file-upload-content').hide();
			$("#label-container").hide();			
			$("#elseArea").hide();
			$('.image-upload-wrap').show();
		}

		$('.image-upload-wrap').bind('dragover', function() {
			$('.image-upload-wrap').addClass('image-dropping');
		});

		$('.image-upload-wrap').bind('dragleave', function() {
			$('.image-upload-wrap').removeClass('image-dropping');
		});
	    
	</script>

<body onload="init()">

<%@ include file="header.jsp" %>
	
	<div class="modal">
		<div class="modal_body">
			<div style="font-family: 'MaruBuri-Regular'; font-size: 20pt; font-weight: bold; margin-bottom: 45px;">
				<img src="resources/image/info.png" width="40"> 
				AI 퍼스널 컬러 진단 관련 안내
			</div> 
			<span>
				1. 진단에 사용된 사진은 따로 저장되지 않으니 안심하시고 사용하셔도 됩니다.<br><br>
				2. 동일 인물이라도 사진의 색감과 조명에 따라 측정 결과가 달라질 수 있습니다.<br>
				&nbsp;&nbsp;&nbsp;최대한 <u>색감이 들어가지 않은 조명 아래에서 찍은 사진</u>으로 진행 부탁 드립니다.<br><br> 
				3. 평소 스타일링에 따라 정확한 진단이 나오지 않는 경우가 있습니다.<br>
				&nbsp;&nbsp;&nbsp;<span style="color: #BDBDBD;">(퍼스널 컬러는 봄 브라이트이나 스모키&스트릿 스타일링을 즐겨 하신다거나 등)</span><br>
				&nbsp;&nbsp;&nbsp;결과가 의아하시거나, 좀 더 전문적인 진단을 받고 싶으시다면<br>
				&nbsp;&nbsp;&nbsp;결과 노출 화면에서 사용자 인근 퍼스널 컬러 업체를 소개해드리고 있으니 참고 부탁 드립니다.<br><br> 
			</span>
			<br> 
			<span style="font-size: 8pt; left: 372px; top:-10px; position: relative;">창을 닫고싶으시면 안내창 바깥 아무곳이나 클릭해주세요.</span>
		</div>
	</div>
	
	<div style="text-align: center;"> 
		<br><br><br>
		<span style="font-family: 'MaruBuri-Regular'; font-weight: bold; font-size: 30pt;">AI 컬러 진단</span>
		<br><br>
		<span style="font-family: 'RIDIBatang'; font-size: 11pt; line-height: 180%;">
			Hidden Beauty의 AI 인공지능으로 퍼스널 컬러를 진단 받아 보세요!<br>
			저희 진단 서비스는 빠르고, 쉽고, 무료입니다 :)
		</span>
		<br><br>
		<input type="button" class="btn-open-popup" id="info" value="안내사항">
		<br><br>
	</div>
	<script>
	    const body = document.querySelector('body');
	    const modal = document.querySelector('.modal');
	    const btnOpenPopup = document.querySelector('.btn-open-popup');
	
	    btnOpenPopup.addEventListener('click', () => {
	      modal.classList.toggle('show');
	
	      if (modal.classList.contains('show')) {
	        body.style.overflow = 'hidden';
	      }
	    });
	
	    modal.addEventListener('click', (event) => {
	      if (event.target === modal) {
	        modal.classList.toggle('show');
	
	        if (!modal.classList.contains('show')) {
	          body.style.overflow = 'auto';
	        }
	      }
	    });
    </script>
	
	<script class="jsbin" src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
      <div class="file-upload">
        <div class="image-upload-wrap">
          <input class="file-upload-input" type='file' onchange="readURL(this);" accept="image/*" />
          <div class="drag-text">
          	<img src="resources/image/upload.png" width="15%"><br><br>
            사진을 드래그하거나,<br>
            <u>이곳</u>을 클릭하여 업로드 해주세요.
          </div>
        </div>
        <div class="file-upload-content">
          <img class="file-upload-image" id="face-image" src="#" alt="your image" />
          <div class="image-title-wrap">
            <button type="button" onclick="removeUpload()" class="remove-image">다시 선택하기</button>
            
	            <div id="loading-overlay">
				  
				</div>
		            
          </div>
        </div>

      </div>
      
	<div style="width: 100%; text-align: center;">
	
		<button type="button" onclick="predict()" id="finish"">진단받기</button>
		<div id="label-container"></div>
		<br><br><br><br><br>
		
		<div id="elseArea" style="display: none; margin: auto; font-family: 'RIDIBatang'; position: relative; background: #EFF0F7;">
			<div class="row" style="width: 60%; margin: auto;">
				<div class="col-lg-6" id="result" style="height: 500px;" onClick="go_update()">
				<img src="resources/image/background.png" class="img" id="1st_circle" width="500">
					<div style="position: relative;">
						<div style="font-size: 11pt; margin: 210px 0px 5px 0px; position: relative;">
							내 계정에 방금 진단받은 퍼스널 컬러를 저장하고 싶다면?
						</div>
						<div style="font-size: 25pt; font-weight: bold; position: relative;">
							결과 저장하기
						</div>
						<div id="go1" style="font-size: 18pt; font-weight: bold; color: #D5D5D5; position: relative;">
							GO →
						</div>
					</div>
				</div>
				<div class="col-lg-6" id="company" style="height: 500px; position: relative;" onClick="location.href='company.cmp'">
				<img src="resources/image/background.png" class="img" id="2nd_circle" width="500" style="left: 32px;">
					<div style="position: relative;">
						<div style="font-size: 11pt; margin: 210px 0px 5px 0px; position: relative;">
							결과가 의아하시거나, 좀 더 전문적인 진단을 받고 싶으시다면?
						</div>
						<div style="font-size: 25pt; font-weight: bold; position: relative;">
							근처 진단 업체 소개받기
						</div>
						<div id="go2" style="font-size: 18pt; font-weight: bold; color: #D5D5D5; position: relative;">
							GO →
						</div>
					</div>
				</div>
			</div>
			
		</div>
		<br><br><br><br><br>
			
	</div>
	
	<%@ include file="footer.jsp" %>
</body>
</html>