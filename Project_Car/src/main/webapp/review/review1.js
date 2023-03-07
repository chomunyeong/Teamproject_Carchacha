document.addEventListener('DOMContentLoaded', function(){
    //별점선택 이벤트 리스너
    document.querySelector('.rating').addEventListener('click',function(e){
        let elem = e.target;
        if(elem.classList.contains('rate_radio')){
            rating.setRate(parseInt(elem.value));
        }
    })

    //상품평 작성 글자수 초과 체크 이벤트 리스너
    document.querySelector('.review_textarea').addEventListener('keydown',function(){
        //리뷰 1500자 초과 안되게 자동 자름
        let review = document.querySelector('.review_textarea');
        let lengthCheckEx = /^.{1500,}$/;
        if(lengthCheckEx.test(review.value)){
            //1500자 초과 컷
            review.value = review.value.substr(0,1500);
        }
    });

    //저장 전송전 필드 체크 이벤트 리스너
    document.querySelector('#save').addEventListener('click', function(e){
        //별점 선택 안했으면 메시지 표시
        if(rating.rate == 0){
            rating.showMessage('rate');
            return false;
        }
        //리뷰 5자 미만이면 메시지 표시
        if(document.querySelector('.review_textarea').value.length < 5){
            rating.showMessage('review');
            return false;
        }
        //폼 서밋
		//실제로는 서버에 폼을 전송하고 완료 메시지가 표시되지만 저장된 것으로 간주하고 폼을 초기화 함.
		alert("작성완료!");
		//rating.setRate(0);
		//document.querySelector('.review_textarea').value = '';
		var btnSubmit = document.getElementById('btnSubmit');	
		btnSubmit.click();
		
    });
    
    // 추가!!
	// setRaing : document load 시점 (jsp 값은 html에 바인딩 되어있는 상태에서 해당 함수 실행) 에 별점 정보를 바탕으로 별점 체크 처리
	const setRating = () => {
		debugger;
    	// id "review_star" hidden input 에 저장 되어있는 DB 별점값 가져오기
    	 const currentRating = document.querySelector("#review_star").value;
    	 
    	 
    	// class명 rating div 자식중 input 태그 전부 가져오기 (nodeList<Element> 타입)
    	const ratingWrapper = document.querySelectorAll(".rating > input");
    	// 해당 nodeList를 순회하며 인덱스값이 현재 별점보다 낮은 값은 전부 체크처리
    	ratingWrapper.forEach((item, idx) => {
    	if (idx < currentRating) {
       		item.click();
     	}
       });
    };
    // 함수 실행
    setRating();
    
});


//별점 마킹 모듈 프로토타입으로 생성
function Rating(){};
Rating.prototype.rate = 0;
Rating.prototype.setRate = function(newrate){
    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
    this.rate = newrate;
    document.querySelector('.ratefill').style.width = parseInt(newrate * 60) + 'px';
    let items = document.querySelectorAll('.rate_radio');
    items.forEach(function(item, idx){
        if(idx < newrate){
            item.checked = true;
        }else{
            item.checked = false;
        }
    });
}

Rating.prototype.showMessage = function(type){//경고메시지 표시
    switch(type){
        case 'rate':
            //안내메시지 표시
            document.querySelector('.review_rating .warning_msg').style.display = 'block';
            //지정된 시간 후 안내 메시지 감춤
            setTimeout(function(){
                document.querySelector('.review_rating .warning_msg').style.display = 'none';
            },1000);            
            break;
        case 'review':
            //안내메시지 표시
            document.querySelector('.review_contents .warning_msg').style.display = 'block';
            //지정된 시간 후 안내 메시지 감춤
            setTimeout(function(){
                document.querySelector('.review_contents .warning_msg').style.display = 'none';
            },1000);    
            break;
    }
}

let rating = new Rating();//별점 인스턴스 생성

