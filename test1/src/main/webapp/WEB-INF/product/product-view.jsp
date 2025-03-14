<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/js/page-change.js"></script>
    <title>제품 상세보기</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>
<body>

    <jsp:include page="../common/header.jsp" />

    <!-- 제품 상세 정보 -->
    <div id="app" class="container">
        <div class="product-detail">
            <!-- 메인 이미지 -->
            <img :src="info.filePath" alt="제품 이미지" id="mainImage">
    
            <!-- 이미지 슬라이드 (썸네일) - 메인 이미지 아래로 배치 -->
            <div class="product-image-thumbnails">
                <img v-for="(img, index) in list" :src="img.filePath" alt="제품 썸네일" 
                    @click="changeImage(img.filePath)">
            </div>
    
            <!-- 제품 상세 정보 -->
            <div class="detail-info">
                <h2>{{ info.itemName }}</h2>
                <p class="price">{{ info.price }} 원</p>
                <p class="description">{{ info.itemInfo }}</p>
                <button class="buy-button" @click="fnPayment()">구매하기</button>
                <button class="back-button" @click="goBack">뒤로 가기</button>
            </div>
        </div>
    </div>

</body>
</html>

<script>
    const userCode = "imp21475352"; 
	IMP.init(userCode);

    const app = Vue.createApp({
        data() {
            return {
                itemNo : "${map.itemNo}",
                list: [],
                info: {},
                sessionId : "${sessionId}"
            };
        },
        methods: {
            fnGetProduct() {
                var self = this;
                var params = {
                    itemNo : self.itemNo
                };

                $.ajax({
                    url: "/product/view.dox",
                    dataType: "json",
                    type: "POST",
                    data: params,
                    success: function(data) {
                        self.list = data.list;
                        self.info = data.info;
                        console.log(data);
                    }
                });
            },
            changeImage(filePath) {
                    // 클릭된 이미지로 메인 이미지 변경
                    document.getElementById('mainImage').src = filePath;
            },
            fnPayment(){
                let self = this;
                // let orderId = "test1" + new Date().getDate();

				IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: "test1" + new Date().getTime(),
				    name: "테스트 결제",
				    amount: self.info.price,
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
						alert("성공");
						console.log(rsp);
                        self.fnSave(rsp.merchant_uid);
			   	      } else {
			   	        // 결제 실패 시
                           console.log(rsp);
						alert("실패");
			   	      }
		   	  	});
			},
            fnSave : function(merchant_uid) {
                let self = this;
                var nparmap = {
                    orderId : merchant_uid,
                    amount: self.info.price,
                    itemNo : self.info.itemNo,
                    sessionId : self.sessionId
                };
                $.ajax({
                    url:"/product/pay.dox",
                    dataType:"json",	
                    type : "POST", 
                    data : nparmap,
                    success : function(data) { 
                        console.log(data);
                        
                    }
                });
            },
            goBack() {
                window.history.back();
            }
        },
        mounted() {
            this.fnGetProduct();
        }
    });

    app.mount('#app');
</script>
