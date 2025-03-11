<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/js/page-change.js"></script>
    <title>쇼핑몰</title>
    <link rel="stylesheet" href="../css/product-style.css">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <!-- 제품 목록 -->
    <div id="app" class="container">
        <h2>제품 목록</h2>

        <div class="product-container">
            <div class="product-card" v-for="item in list">
                <a href="javascript:;" @click="fnGetProduct(item.itemNo)">
                    <img :src="item.filePath" :alt="item.itemName">
                </a>
                <h3>{{ item.itemName }}</h3>
                <p>{{ item.itemInfo }}</p>
                <p>{{ item.price }} 원</p>
            </div>
        </div>
    </div>

</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                searchQuery: "", // 검색어 저장
                list : []
            };
        },
        computed: {
            filteredProducts() {
                // 검색어를 포함하는 제품만 필터링하여 반환
                return this.products.filter(product =>
                    product.name.includes(this.searchQuery)
                );
            }
        },
        methods: {
            searchProducts() {
                console.log("검색어:", this.searchQuery);
            },
            fnProductList() {
                var self = this;
                var nparmap = {};
                $.ajax({
                    url: "/product/list.dox",
                    dataType: "json",    
                    type: "POST", 
                    data: nparmap,
                    success: function(data) { 
                        self.list = data.list;
                        console.log(data);
                    }
                });
            },
            fnGetProduct : function(itemNo) {
                pageChange("/product/view.do", {itemNo : itemNo});
            }
        },
        mounted() {
            var self = this;
            self.fnProductList();
        }
    });

    app.mount('#app');
</script>
