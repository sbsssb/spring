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

    <!-- 헤더 -->
    <header class="header">
        <a href="#" class="logo">MyShop</a>
        
        <!-- 검색창 -->
        <div class="search-bar">
            <input type="text" v-model="searchQuery" placeholder="검색어를 입력하세요">
            <button @click="searchProducts">검색</button>
        </div>
        
        <!-- 메뉴 -->
        <nav class="menu">
            <a href="#">홈</a>
            <a href="#">상품</a>
            <a href="#">이벤트</a>
            <a href="#">고객센터</a>
        </nav>

        <!-- 로그인 버튼 -->
        <div class="login-button">
        <button @click="login">로그인</button>
    
    </header>
</body>
</html>
<script>
    const header = Vue.createApp({
        data() {
            return {
               
            };
        },
        methods: {
            
        },
        mounted() {
            
        }
    });

    header.mount('#header');
</script>
