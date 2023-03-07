// ---------------- calendar table --------------------------

// 달력 설정
var today = new Date();

var date = new Date();
//사용자가 클릭한 셀 객체 저장
var selectedCell;
//오늘 기준으로 불현하는 월. 일 객체
var realMonth = date.getMonth()+1;
var realToDay = date.getDate();
//사용자가 클릭한 일자의 월, 일 객체
var selectedMonth = null;
var selectedDate = null;

function buildCalendar(){
	var row = null;
	var cnt = 0;
	
	firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
		
	nowMonth = today.getMonth()+1;
	monthEquals = thisMonth(nowMonth, realMonth);
	
	var calendarTable = document.getElementById("calendar");
	var calendarTableTitle = document.getElementById("calendarTitle");
	calendarTableTitle.innerHTML = today.getFullYear()+"년"+(today.getMonth()+1)+"월";
	
	// 현재 달의 첫날과 마지막날
	var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);
	
	// 달력 초기화
	while(calendarTable.rows.length > 2){
		calendarTable.deleteRow(calendarTable.rows.length -1);
	}
	
	row = calendarTable.insertRow();
	// 달력의 첫쨰줄 빈칸 채우기
	for(i = 0; i < firstDate.getDay(); i++){
		cell = row.insertCell();
		cell.innerHTML = null;
		cnt += 1;
	}
	
	// 달력에 요일 채우기
	for(i = 1; i <= lastDate.getDate(); i++){
		noCount = 0;
		
		
		cell = row.insertCell();
		
   		cell.setAttribute('id', i);
		cell.innerHTML = i;
		cell.align = "center";
		cnt += 1;
		
    	if (cnt % 7 == 1) {
			cell.innerHTML = "<font color=#F79DC2>" + i + "</font>";
		}  
		
		if (cnt % 7 == 0){
			cell.innerHTML = "<font color=skyblue>" + i + "</font>";
			row = calendar.insertRow();
		}
		
		etp = exchangeToPosibleDay(cnt)*1;
		
		if (nowMonth == realMonth && i <= realToDay) {
				noCount +=1;
	    } else if (nowMonth > realMonth && i > realToDay) {
				noCount +=1;
	    }
	    
		if (noCount > 0){
			cell.style.backgroundColor = "#E0E0E0";
			cell.innerHTML = "<font color='#C6C6C6' >" + i + "</font>";
		} else {
			console.log("cell 클릭생성");
			cell.onclick = function(){
				selectedTimeAndTotalPriceInit();
				console.log("cell 클릭함");
				clickedYear = today.getFullYear();
				clickedMonth = ( 1 + today.getMonth() );
				clickedDate = this.getAttribute('id');
	
				clickedDate = clickedDate >= 10 ? clickedDate : '0' + clickedDate;    
				clickedMonth = clickedMonth >= 10 ? clickedMonth : '0' + clickedMonth;
				clickedYMD = clickedYear + "-" + clickedMonth + "-" + clickedDate;
				
				
				//하단에 예약일시 표시
				inputField = document.getElementById("selectedDate");
				inputField.value = clickedYMD;
				//선택된 월, 일 변수 저장
				selectedMonth = today.getMonth() + 1;
				selectedDate = this.getAttribute('id');
				
				//선택된 셀 색 변화
				if(selectedCell != null){
					selectedCell.bgColor = "transparent";
				}
				
				selectedCell = this;
				this.bgColor = "#fbedaa";
				
				//time table 생성
				timeTableMaker(today.getMonth() + 1,this.getAttribute('id'));
			}
		}
	} 

	// 선택한 날짜 출력
	
	// 달력의 마지막행 빈칸 채우기
	if(cnt % 7 != 0){
		for(i = 0; i < 7 - (cnt % 7); i++){
			cell = row.insertCell();
		}
	}
}

// 이전달 이동
function prevCalendar(){
	if (today.getMonth() < realMonth){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");	
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	buildCalendar();
}

// 다음달 이동
function nextCalendar(){
	if(today.getMonth()+1 == (realMonth + 1)){
		alert("예약은 금일기준 다음날부터 30일 이후까지만 가능합니다.");
		return false;
	}
	today = new Date(today.getFullYear(), today.getMonth()+1, today.getDate());
	buildCalendar();
}

function exchangeToPosibleDay(num){
	result = num % 7;
	result -= 1;
	if (result == -1) {
		result = 6;
	}
	return result;
}

function thisMonth(todayMonth, dateMonth){
	if (todayMonth*1 == dateMonth*1){
		return 0;
	} 
	return 1;
}

// ---------------- time table --------------------------
	var price = document.getElementById("price");
	var startTime = "0";
	var endTime = "24";
	//선택된 시간중 가장 빠른/늦은 시간;
	var selectedFirstTime = 24*1;
	var selectedFinalTime = 0*1;
	//예약시간표를 만들 table객체 획득
	
	function timeTableMaker(selectedMonth, selectedDate){
		row = null
		month = selectedMonth;
		date = selectedDate;
		var timeTable = document.getElementById("timeTable");
		
		//테이블 초기화
		while(timeTable.rows.length > 0){
			timeTable.deleteRow(timeTable.rows.length-1);
		}
		
		for (i = 0; i < endTime - startTime; i++){
			//곱해서 숫자타입으로 변환
			cellTime = startTime*1 + i;
			
			cellStartTimeText = cellTime + ":00";
			cellEndTimeText = (cellTime + 1) + ":00";
			inputCellText = cellStartTimeText + " ~ " +  cellEndTimeText;
			
			//셀 입력을 위해 테이블 개행
			row = timeTable.insertRow();
			//해당 row의 셀 생성
			cell = row.insertCell();
			//cell에 id 부여
			cell.setAttribute('id', cellTime);
			//셀에 입력
			cell.innerHTML = inputCellText;
			//클릭이벤
			cell.onclick = function(){
				cellTime = this.getAttribute('id');
				cellTime = cellTime*1;
				console.log("first : " + selectedFirstTime + ", selectedFinalTime : " + selectedFinalTime + ", selected : " + cellTime);
				//예약일시 입력처리
				if (selectedFirstTime != 24 && selectedFinalTime != 0){
					if(cellTime < selectedFirstTime - 1){
						alert("연속한 시간만 예약가능합니다.");
						return false;
					}
					if (cellTime > selectedFinalTime + 1){
						alert("연속한 시간만 예약가능합니다.");
						console.log(cellTime + ">" + selectedFinalTime + 1)
						return false;
					}
				}
				this.bgColor = "#fbedaa";
				if (cellTime < selectedFirstTime) {
					selectedFirstTime = cellTime
				}
				if (cellTime > selectedFinalTime) {
					selectedFinalTime = cellTime
				}
				
				//하단의 예약일시에 시간 표시
				resTime  = selectedFirstTime + ":00 ~ " + (selectedFinalTime + 1) + ":00";
			
				resTimeForm = document.getElementById("selectedTime");
				resTimeForm.value = resTime;
				
				//하단의 결제정보에 가격정보 표시
				useTime = (selectedFinalTime + 1) - selectedFirstTime;
				
				useTimeForm = document.getElementById("totalPrice");
				useTimeForm.value = useTime * price.value;
				
			}
		}

	}
	//시간표 초기화
	function tableinit(){
		timeTableMaker(selectedMonth, selectedDate);
		selectedTimeAndTotalPriceInit();
		buildCalendar();
	}
	
	//날자 클릭시 예약시간 및 결제정보 초기화
	function selectedTimeAndTotalPriceInit(){
		resDateForm = document.getElementById("selectedDate");
		resTimeForm = document.getElementById("selectedTime");
		resTimeForm.value = "";
		resDateForm.value = "";
		
		useTimeForm = document.getElementById("totalPrice");
		useTimeForm.value = "";
		
		selectedFirstTime = 24*1;
		selectedFinalTime = 0*1;
	}
	
		function checkNull(){
		userId = document.getElementById("sessionId");
		resDateForm = document.getElementById("selectedDate");
		resTimeForm = document.getElementById("selectedTime");
		
		if(userId.value == 'null'){
			alert("로그인해주세요.");
			return false;
		} else if(resDateForm.value == ""){
			alert("날짜를 선택해주세요.");
			return false;
		} else if(resTimeForm.value == ""){
			alert("시간을 선택해주세요.");
			return false;
		}
		return true;
	}
