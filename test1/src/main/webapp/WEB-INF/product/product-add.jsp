<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3QOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <title>제품 등록 페이지</title>
    <link rel="stylesheet" href="../css/product-style.css"> <!-- 기존 스타일 연결 -->
    <style>
        /* 추가된 스타일 */
        .form-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px); /* 헤더 제외 화면 중앙 정렬 */
            background-color: #f8f8f8;
        }

        .form-box {
            background-color: #ffffff;
            border-radius: 15px; /* 모서리 둥글게 */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
            padding: 30px 40px;
            width: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .form-box span {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }

        .form-box div {
            margin-bottom: 15px;
            width: 100%;
        }

        .form-box input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-box input:focus {
            border-color: #007bff;
            outline: none;
        }

        .form-box button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-box button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div id="app" class="form-container">
        <div class="form-box">
            <span>제품 등록</span>
            <div>
                제품명: <input type="text" placeholder="제품명을 입력하세요" v-model="itemName">
            </div>
            <div>
                가격: <input type="text" placeholder="가격을 입력하세요" v-model="price">
            </div>
            <div>
                설명: <input type="text" placeholder="제품 설명을 입력하세요" v-model="itemInfo">
            </div>
            <div>
                썸네일: <input type="file" id="thumbFile" name="thumbFile" accept=".jpg, .png">
            </div>
            <div>
                제품 설명: <input type="file" id="file1" name="file1" accept=".jpg, .png" multiple>
            </div>
            <div>
                <button @click="fnInsertProduct">등록</button>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
        data() {
            return {
                itemName: "",
                price: "",
                itemInfo: ""
            };
        },
        methods: {
            fnInsertProduct() {
                var self = this;
                var nparmap = {
                    itemName: self.itemName,
                    price: self.price,
                    itemInfo: self.itemInfo
                };
                $.ajax({
                    url: "/product/add.dox",
                    dataType: "json",
                    type: "POST",
                    data: nparmap,
                    success: function(data) {
                        console.log(data.itemNo);

                        if(data.result == "success") {
                            if($("#file1")[0].files.length > 0) {
                                var form = new FormData();
                                for(let i = 0; i < $("#file1")[0].files.length; i++) {
                                    if(i == 0) {
                                        form.append("file1", $("#thumbFile")[0].files[i]);
                                    }
                                    form.append("file1", $("#file1")[0].files[i]);
                                }
                                form.append( "itemNo",  data.itemNo); // 임시 pk
                                self.upload(form); 
                            }
                        }
                    }
                });
            },
            upload : function(form){
                var self = this;
                $.ajax({
                    url : "/product/fileUpload.dox"
                    , type : "POST"
                    , processData : false
                    , contentType : false
                    , data : form
                    , success:function(response) { 
                        alert("저장되었습니다");
                        location.href ="/product/list.do";
                    }	           
                });
            }
        },
        mounted() {
            console.log("등록 페이지 마운트 완료");
        }
    });

    app.mount('#app');
</script>

    