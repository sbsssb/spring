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
            <img :src="info.filePath" :alt="info.itemName">
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
                info: {}
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
                        self.info = data.info;
                        console.log(data);
                    }
                });
            },
            fnPayment(){
                let self = this;
                let orderId = "test1" + new Date().getDate();

				IMP.request_pay({
				    pg: "html5_inicis",
				    pay_method: "card",
				    merchant_uid: orderId,
				    name: "테스트 결제",
				    amount: self.info.price,
				    buyer_tel: "010-0000-0000",
				  }	, function (rsp) { // callback
			   	      if (rsp.success) {
                        var nparmap = {
                            orderId : orderId,
                            amount: self.info.price,
                            itemNo : self.itemNo
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
						alert("성공");
						console.log(rsp);
			   	      } else {
			   	        // 결제 실패 시
						alert("실패");
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
