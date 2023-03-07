<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>다 함께 CarChaCha</title>
<link href="./css/header.css" rel="stylesheet">
<link href="./css/footer.css" rel="stylesheet">
<link href="./css/map.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="../css/header.jsp"></jsp:include>
	<div id="wrapper">
		<div class="myPage_menu">
		</div>
		<div class="myPageCont">
			<div class="my_page">
				<form>
					<p>
						<b>[47246]부산광역시 부산진구 동천로 109 삼한골든게이트 7층</b>
					</p>
					<div id="map" style="width: 500px; height: 400px;margin: 0 auto;"></div>

					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey='appkey'"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도의 중심좌표
						mapOption = {
							center : new kakao.maps.LatLng(35.1584043,
									129.0620349), // 지도의 중심좌표
							level : 3
						// 지도의 확대 레벨
						};

						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

						// 지도에 마커를 표시합니다 
						var marker = new kakao.maps.Marker({
							map : map,
							position : new kakao.maps.LatLng(35.1584043,
									129.0620349)
						});

						// 커스텀 오버레이에 표시할 컨텐츠 입니다
						// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
						// 별도의 이벤트 메소드를 제공하지 않습니다 
						var content = '<div class="wrap">'
								+ '    <div class="info">'
								+ '        <div class="title">'
								+ '            카차차'
								+ '            <div class="close" onclick="closeOverlay()" title="닫기"></div>'
								+ '        </div>'
								+ '        <div class="body">'
								+ '            <div class="img">'
								+ '                <img src="https://img1.kakaocdn.net/cthumb/local/R0x420/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fcfile%2F12419041501725F318" width="73" height="70">'
								+ '           </div>'
								+ '            <div class="desc">'
								+ '                <div class="ellipsis">부산 부산진구 동천로 109 삼한골든게이트 7층 (우)47246</div>'
								+ '                <div class="jibun ellipsis">부전동 112-3</div>'
								+ '                <div><a href="/Project_Car/UserHome.us" target="_blank" class="link">홈페이지</a></div>'
								+ '            </div>' + '        </div>'
								+ '    </div>' + '</div>';

						// 마커 위에 커스텀오버레이를 표시합니다
						// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
						var overlay = new kakao.maps.CustomOverlay({
							content : content,
							map : map,
							position : marker.getPosition()
						});

						// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
						kakao.maps.event.addListener(marker, 'click',
								function() {
									overlay.setMap(map);
								});

						// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
						function closeOverlay() {
							overlay.setMap(null);
						}
					</script>
					<p>
						자가용<br> 지하철 1, 2호선 서면역 8번 출구 직진 180m > 미니스탑에서 좌회전 70m (쉐보레자동차
						7층)
					</p>
					<p>
						지하철<br> 1호선, 2호선 서면역 8번 출구에서 265m
					</p>
					
				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../css/footer.jsp"></jsp:include>
</body>
</html>