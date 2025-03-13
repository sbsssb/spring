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
        <style>
            /* 드롭다운 스타일 */
            .dropdown {
                position: relative;
                display: inline-block;
                margin-right: 15px;
            }
            .dropbtn {
                background-color: #fff;
                color: #333;
                font-size: 16px;
                font-weight: bold;
                border: none;
                cursor: pointer;
                padding: 10px;
            }
            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 120px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
                z-index: 1;
                list-style: none;
                padding: 0;
                margin: 0;
            }
            .dropdown-content li {
                padding: 8px 12px;
                cursor: pointer;
            }
            .dropdown-content li:hover {
                background-color: #b9dcff; /* 연한 하늘색 */
            }
            .dropdown:hover .dropdown-content {
                display: block;
            }
        </style>
    </head>
    <body>
        <div id="header">
            <!-- 헤더 -->
            <header class="header">
                <a href="#" class="logo">MyShop</a>
                
                <!-- 검색창 -->
                <div class="search-bar">
                    <input type="text" v-model="keyword" @keyup.enter="fnSearch" placeholder="검색어를 입력하세요">
                    <button @click="fnSearch" >검색</button>
                </div>
                
                <!-- 메뉴 -->
                <nav class="menu">
                    <ul>
                        <li class="dropdown" v-for="item1 in mainList">
                            <button class="dropbtn">{{ item1.menuName }}</button>
                                <ul class="dropdown-content" v-if="item1.subCnt > 0">
                                    <template v-for="item2 in subList"> 
                                        <li v-if="item2.parentId == item1.menuId">
                                            <a :href="item2.menuUrl">{{ item2.menuName }}</a>
                                        </li>
                                    </template>
                                </ul>
                        </li>
                    </ul>
                </nav>
                
                <!-- 로그인 버튼 -->
                <div class="login-button">
                    <button @click="login">로그인</button>
                </div>
            </header>
        </div>
    </body>
    </html>
    
    <script>
    const header = Vue.createApp({
        data() {
            return {
                keyword: "",
                mainList : [],
                subList : []
            };
        },
        methods: {
            fnSearch() {
                // let self = this;
                // app._component.methods.fnProductList(self.keyword);
                if (window.app && typeof window.app.fnProductList === "function") {
                    window.app.keyword = this.keyword; // 검색어 동기화
                    window.app.fnProductList(); // 제품 리스트 갱신
                } else {
                    console.error("window.app이 초기화되지 않았거나 fnProductList()가 없습니다.");
                }
                
            },
            fnMenu(){
                var self = this;
                var nparmap = {};
                $.ajax({
                    url:"/menu.dox",
                    dataType:"json",    
                    type : "POST", 
                    data : nparmap,
                    success : function(data) { 
                        console.log(data);
                        self.mainList = data.mainList;
                        self.subList = data.subList;
                    }
                });
            },
            login() {
                alert("로그인 기능은 구현되지 않았습니다.");
            }
        },
        mounted() {
            var self = this;
            self.fnMenu();
        }
    });
    
    header.mount("#header");
    </script>
