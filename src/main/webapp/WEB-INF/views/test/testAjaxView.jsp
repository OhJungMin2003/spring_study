<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testAjaxView</title>
<%-- jsp 에서 el 사용시 절대경로를 표시하는 /first 를 
	${ pageContext.servletContext.contextPath } 로 표기함
	톰켓이 구동하고 있는 에플리케이션의 context-root 를 조회해 오라는 의미임
 --%>
<script type="text/javascript" src="${pageContext.servletContext.contextPath }/resources/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<h1>jQuery 로 ajax 스프링 적용 테스트</h1>
<hr>

<h2>1. 서버로 전송하는 값은 없고, 결과로 문자열을 받아서 출력 : get 방식</h2>
<p id="p1" style="width:300px;height:50px;border:1px solid red;"></p>
<button id="test1">테스트1</button>

<script type="text/javascript">
//window.onload = function(){ 태그객체.이벤트명 = function(){ 이벤트 발생시 처리내용 작성 }};
//jQuery.document.ready(function(){ 태그객체.이벤트명 = function(){ 이벤트 발생시 처리내용 작성 }});
//window.onload 와 jQuery.document.ready 는 의미가 같음 : 브라우저에 문서 읽어들이기가 완료되면을 의미함
//jQuery 는 줄임말로 $ 로 표기함
//jQuery.document.ready(function(){}); 는 줄여서 $(function(){}); 표기해도 됨
$(function(){
	//jQuery('선택자').메소드명([전달인자, .......]);
	//$('selector').method(....).method(...).method(....);  //chainning 기법
	
	//아이디가 test1인 태그가 클릭되면 콜백함수가 실행되는 구문임
	$('#test1').click(function(){
		$.ajax({
			url: 'test1.do',
			type: 'get',
			success: function(data){  //요청이 성공했을 때 실행되는 함수임
				//서버측에서 보낸 문자열 값 출력 처리
				$('#p1').html($('#p1').text() + '<br>' + data);
			},
			error: function(request, status, errorData){  //요청이 실패했을 때 실행되는 함수임
				console.log("error code : " + request.status 
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});
	});
});
</script>
<hr>

<h2>2. 서버로 전송하는 값 있고, 결과로 문자열을 받아서 출력 : post 방식</h2>
이름 : <input type="text" id="name"> <br>
나이 : <input type="number" id="age"> <br>
<p id="p2" style="width:300px;height:50px;border:1px solid red;"></p>
<button id="test2">테스트2</button>

<script type="text/javascript">
$(function(){
	$('#test2').click(function(){
		$.ajax({
			url: 'test2.do',
			type: 'post',
			data: { name: $('#name').val(), 
				  age: $('#age').val() },
			//dataType: 'text',  //'text' 는 기본값이므로 생략 가능함
			success: function(data){
				//data : 서버측 컨트롤러에서 보내는 결과값 받는 변수임
				//p 태그 영역 안에 문자열 추가
				//$('#p2').html($('#p2').text() + '<br>' + data);
				//반환값에 따라 선택 적용한다면
				if(data == 'ok'){
					$('#p2').html('<h5>' + data + '</h5>');
				}else{
					alert('서버측 답변 : ' + data);
				}
			},
			error: function(request, status, errorData){  //요청이 실패했을 때 실행되는 함수임
				console.log("error code : " + request.status 
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});
	});
});
</script>
<hr>

<h2>3. 서버로 전송하는 값은 없고, 결과로 json 객체 하나를 받아서 출력 : post 방식</h2>
<p id="p3" style="width:300px;height:150px;border:1px solid red;"></p>
<button id="test3">테스트3</button>

<script type="text/javascript">
$(function(){
	$('#test3').click(function(){
		$.ajax({
			url: 'test3.do',
			type: 'post',
			dataType: 'json',  //json 을 받을 때는 post 방식이어야 함
			success: function(data){
				//json 객체 한 개를 받을 때는 바로 출력할 수 있음
				console.log('json data : ' + data);  //json data : [object Object]
				
				//응답온 값에 인코딩된 문자가 있으면, 자바스크립트가 제공하는 내장함수
				//decodeURIComponent(응답값) 사용해서 반드시 디코딩 처리해야 함
				//디코딩 결과에 공백문자가 '+' 로 표기되면
				//replace('현재문자', '바꿀문자') 사용해서 '+' 를 공백문자로 변경 처리함
				$('#p3').html('<b>최신 신규 공지글</b><br>'
						+ '번호 : ' + data.noticeno
						+ '<br>제목 : ' + decodeURIComponent(data.noticetitle).replace(/\+/gi, ' ')
						+ '<br>작성자 : ' + data.noticewriter
						+ '<br>날짜 : ' + data.noticedate
						+ '<br>내용 : ' + decodeURIComponent(data.noticecontent).replace(/\+/gi, ' '));				
				
			},
			error: function(request, status, errorData){  //요청이 실패했을 때 실행되는 함수임
				console.log("error code : " + request.status 
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});
	});
});
</script>
<hr>

<h2>4. 서버로 전송값 있고, 결과로 json 배열 받아서 출력</h2>
<label>검색 제목 키워드 입력 : <input type="search" id="keyword"></label> <br>
<div id="d4" style="width:400px;height:400px;border:1px solid red;">
	<table id="tblist" border="1" cellspacing="0">
		<tr bgcolor="gray">
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>날짜</th>
		</tr>
	</table>
</div>
<button id="test4">테스트4</button>

<script type="text/javascript">
$(function(){
	//jQuery('selector').method(...);  줄여서 $('태그선택자').이벤트메소드(function(){ 이벤트발생시 실행할 내용 });
	$('#test4').on('click', function(){
		//jQuery.ajax({ settings });
		$.ajax({
			url: 'test4.do',
			type: 'post',
			data: { keyword: $('#keyword').val() },  //$('#keyword').val() == document.getElementById('keyword').value 
			dataType: 'json',   //받는 값의 종류 지정 (기본 : 'text')
			success: function(data){
				//json 배열을 담은 객체를 리턴받은 경우임
				console.log('data : ' + data);  //data : [object, Object]
				
				//object => string
				var objStr = JSON.stringify(data);
				//string => json : parsing
				var jsonObj = JSON.parse(objStr);  //jsonObj 안에 저장된 list (json 배열임) 가 있음
				
				var output = $('#tblist').html();
				//var output = document.getElementById('tblist').innerHTML;
				//jsonObj 안의 list 가 가진 json 객체 정보를 하나씩 꺼내서 새로운 행을 추가해 나감
				for(var i in jsonObj.list){
					output += '<tr><td>' + jsonObj.list[i].noticeno
						+ '</td><td>' + decodeURIComponent(jsonObj.list[i].noticetitle).replace(/\+/gi, ' ')
						+ '</td><td>' + jsonObj.list[i].noticewriter
						+ '</td><td>' + jsonObj.list[i].noticedate
						+ '</td></tr>';
				}
				
				//테이블에 기록 처리
				$('#tblist').html(output);
				//document.getElementById('tblist').innerHTML = output;
			},
			error: function(request, status, errorData){  //요청이 실패했을 때 실행되는 함수임
				console.log("error code : " + request.status 
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});
	});
});
</script>
<hr>

<h2>5. 서버로 json 객체를 보내기</h2>
<div>
	<fieldset>
	<legend>새 공지글 등록하세요.</legend>
	제목 : <input type="text" id="title"> <br>
	작성자 : <input type="text" id="writer" value="${ sessionScope.loginUser.userId }" readonly> <br>
	내용 : <textarea rows="5" cols="50" id="content"></textarea>
	</fieldset>
</div>
<button id="test5">테스트5</button>

<script type="text/javascript">
$(function(){
	$('#test5').on('click', function(){
		//자바스크립트에서 json 객체 만들기
		//var job = { name: '홍길동', age: 30 }; 형식으로 만들 수 있음
		var job = new Object();
		job.title = $('#title').val();
		job.writer = $('#writer').val();  //document.getElementById('writer').value
		job.content = $('#content').val();
		
		$.ajax({
			url: 'test5.do',
			type: 'post',
			data: JSON.stringify(job),
			contentType: 'application/json; charset=utf-8',
			success: function(data){
				alert('요청 성공 : ' + data);
				
				//input 에 기록된 값 삭제함
				$('#title').val('');
				$('#content').val('');
			},
			error: function(request, status, errorData){  //요청이 실패했을 때 실행되는 함수임
				console.log("error code : " + request.status 
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		});  //ajax
	});  //on
});  //document.ready
</script>
<hr>

<h2>6. 서버로 json 배열 보내기</h2>
<div>
	<fieldset>
	<legend>공지글 여러 개 한번에 등록하기</legend>
	제목 : <input type="text" id="ntitle"> <br>
	작성자 : <input type="text" id="nwriter" value="${ sessionScope.loginUser.userId }" readonly> <br>
	내용 : <textarea rows="5" cols="50" id="ncontent"></textarea>
	</fieldset>
	<input type="button" id="addBtn" value="추가하기">
</div>
<p id="p6" style="width:400px;height:150px;border:1px solid red;"></p>
<button id="test6">테스트6</button>

<script type="text/javascript">
$(function(){
	//자바스크립트에서 배열 만들기
	//var jarr = new Array(5);  //index 이용할 수 있음
	//jarr[0] = { name : '홍길동', age : 30}; 저장 기록함
	
	//var jarr2 = new Array(); //index 없음, 스택(stack) 구조가 됨(LIFO : Last Input First Output)
	//저장 : push(), 꺼내기 : pop() 사용함
	//jarr2.push({ name: '이순신', age: 42 });
	
	//배열 초기화
	/*
		var jarr3 = [
			{ name: '홍길동', age: 30}, 
			{ name: '홍길순', age: 27}, 
			{ name: '이순신', age: 42}];	
	*/
	var jarr = new Array();
	var pStr = $('#p6').html();
	
	//추가하기 버튼 클릭시 입력값들을 읽어서 json 객체를 만들고
	//p6 태그 영역에 json string 으로 추가 기록 처리함
	$('#addBtn').on('click', function(){
		//json 객체 만들기
		var job = new Object();
		job.title = $('#ntitle').val();
		job.writer = $('#nwriter').val();  
		job.content = $('#ncontent').val();
		
		jarr.push(job);
		
		pStr += JSON.stringify(job);
		$('#p6').html(pStr + '<br>');
		
		//기존의 기록된 input 의 값은 지우기
		$('#ntitle').val('');
		$('#ncontent').val('');
	});  //addBtn click
	
	$('#test6').on('click', function(){
		$.ajax({
			url: 'test6.do',
			type: 'post',
			data: JSON.stringify(jarr),
			contentType: "application/json; charset=utf-8",
			success: function(data){
				alert('요청 성공 : ' + data);
			},
			error: function(request, status, errorData){
				console.log("error code : " + request.status
						+ "\nMessage : " + request.responseText
						+ "\nError : " + errorData);
			}
		}); //ajax
		
	});  //test6 click	
	
});  //document.ready
</script>
<hr>

<h2>7. ajax 로 파일 업로드 처리 (form 을 전송)</h2>
<h3>jQuery 기반 ajax 파일업로드 form 전송</h3>
<form id="fileform">
	메세지 : <input type="text" name="message"> <br>
	첨부파일 : <input type="file" name="upfile"> <br>
	<input type="button" value="업로드" onclick="uploadFile();">
</form>

<h3>javascript 기반 ajax 파일업로드 form 전송</h3>
<form id="fileform2">
	메세지 : <input type="text" name="message"> <br>
	첨부파일 : <input type="file" name="upfile"> <br>
	<input type="button" value="업로드" onclick="uploadFile2();">
</form>

<script type="text/javascript">
function uploadFile(){
	//jQuery ajax() 로 파일업로드용 form 전송 처리
	
	//body 의 form 태그를 객체로 생성함
	var form = $('#fileform')[0];  //인덱스 사용에 주의할 것
	//form 태그 안의 입력양식들의 값들을 담을 FormData 내장객체 생성함
	var formData = new FormData(form);
	
	$.ajax({
		url: 'testFileUp.do',
		processData: false,  //multipart 전송은 false 로 지정해야 함
		contentType: false,  //multipart 전송은 false 로 지정해야 함
		type: 'post',
		data: formData,
		success: function(data){
			alert('파일업로드 성공 : ' + data);
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	});  //ajax
}  //uploadFile()

function uploadFile2(){
	//javascript 로 ajax 기술 사용해서 파일업로드용 form 전송 처리
	
	var form = document.getElementById('fileform2');
	var formData = new FormData(form);
	
	//브라우저에서 제공하는 ajax 를 위한 객체 생성
	var xhRequest;
	if(window.XMLHttpRequest){
		xhRequest = new XMLHttpRequest();
	}else{
		xhRequest = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	//ajax 요청
	//1. 요청 처리에 대한 상태코드가 변경되면, 작동할 내용을 미리 설정함
	xhRequest.onreadystatechange = function(){
		if(xhRequest.readyState == 4 && xhRequest.status == 200){
			//요청이 성공하면 alert 창에 응답온 문자를 출력함
			alert(xhRequest.responseText);
		}
	};
	
	//2. url 요청하고 전송데이터 보내기함
	xhRequest.open("POST", "testFileUp.do", true);
	xhRequest.send(formData);
	
}  //uploadFile2()
</script>
<hr>

<h2>8. ajax 로 파일 다운로드</h2>
<h3>jQuery 기반 ajax 이용 파일 다운로드</h3>
<a id="fdown" onclick="fileDown();">sample.txt</a> <br><br>

<h3>javascript 기반 ajax 이용 파일 다운로드</h3>
<a id="fdown2" onclick="fileDown2();">sample.txt</a> <br><br>

<script type="text/javascript">
function fileDown(){
	//jQuery ajax 사용 파일 다운로드 처리
	//a 태그로 링크된 파일이름 클릭하면, 서버로 다운로드 요청함
	
	//a 태그에서 다운받을 파일명을 얻어옴
	var filename = $('#fdown').text();
	console.log('filename : ' + filename);
	
	$.ajax({
		url: 'filedown.do',
		type: 'get',  //get 이 기본값이므로 생략해도 됨
		data: { 'filename': filename },
		xhrFields: { responseType: 'blob' },  //response 데이터를 바이너리로 지정해야 함
		success: function(data){
			console.log('파일 다운로드 요청 성공!');
			
			//응답온 파일 데이터를 Blob 객체로 만듦
			var blob = new Blob([data]);
			//클라이언트 쪽에 파일을 저장 처리 : 다운로드
			if(navigator.msSaveBlob){
				return navigator.msSaveBlob(blob, filename);
			}else{
				var link = document.createElement('a');
				link.href = window.URL.createObjectURL(blob);
				link.download = filename;
				link.click();
			}
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	});
}

function fileDown2(){
	//javascript ajax 로 파일 다운로드 처리
	//a 태그(다운받을 파일명) 클릭하면 서버로 다운로드 요청함
	
	var filename = document.getElementById('fdown2').innerHTML;
	var filedownURL = "filedown.do";
	
	//브라우저에 ajax 처리용 객체가 제공된다면
	if(window.XMLHttpRequest || 'ActiveXObject' in window){
		var link = document.createElement('a');
		link.href = filedownURL + "?filename=" + filename;
		link.download = filename || filedownURL;
		link.click();
	}else{
		//브라우저에 ajax 처리용 객체가 제공되지 않는다면
		var _window = window.open(filedownURL, filename);
		_window.document.close();
		_window.document.execCommand('SaveAs', true, filename || filedownURL);
		_window.close();
	}
}
</script>



<br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>














