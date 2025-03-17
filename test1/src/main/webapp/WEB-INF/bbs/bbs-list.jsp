<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="/js/page-change.js"></script>
	<title>첫번째 페이지</title>
    <style>
		table, tr, td, th{
			border : 1px solid black;
			border-collapse : collapse;
			padding : 5px 10px;
			text-align : center;		
		}
        .color-black {
            color: black;
        }

        .color-blue {
            color: blue;
        }

        .bgcolor-gray {
            background-color: #ddd;
        }

        #container {
            width: 500px;
            margin: 20px auto;
        }

        a {
            text-decoration: none;
            color: black;

        }
	</style>
</head>
<style>
</style>
<body>
	<div id="app">
        <div>
            <select v-model="searchOption">
                <option value="all">:: 전체 ::</option>
                <option value="title">제목</option>
                <option value="name">작성자</option>
            </select>
            <input v-model="keyword" @keyup.enter="fnBbsList" placeholder="검색어">
            <button @click="fnBbsList">검색</button>
        </div>
        <div>
            <select v-model="pageSize" @change="fnBbsList">
                <option value="5">5개씩</option>
                <option value="10">10개씩</option>
                <option value="15">15개씩</option>
                <option value="20">20개씩</option>
            </select>
        </div>
		<table>
            <tr>
                <th></th>
                <th>번호</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일</th> 
            </tr>
            <tr v-for="item in list">
                <td><input type="radio" :value="item.bbsNum" name="selectBbs" v-model="selectBbs"></td>
                <td>{{item.bbsNum}}</td>
                <td v-if="item.hit >= 30">
                    <a href="javascript:;" @click="fnView(item.bbsNum)" style="color: red;">{{item.title}}</a>
                </td>
                <td v-else>
                    <a href="javascript:;" @click="fnView(item.bbsNum)" style="color: black;">{{item.title}}</a>
                </td>
                <td>{{item.contents}}</td>
                <td>{{item.userId}}</td>
                <td>{{item.hit}}</td>
                <td>{{item.cdateTime}}</td>
            </tr>
        </table>
        <div style="width: 450px; text-align: center; margin-top : 10px;">

            <a v-if="page != 1" id="index" href="javascript:;" class="color-black" @click="fnPageMove('prev')">
            < </a>

            <a id="index" href="javascript:;" v-for="num in index" @click="fnPage(num)">
                <span v-if="page == num" class="bgcolor-gray color-blue">{{num}}
                </span>
                <span v-else class="color-black">{{num}}
                </span>
            </a>

            <a v-if="page != index" id="index" href="javascript:;" class="color-black"
                @click="fnPageMove('next')"> >
            </a>

        </div>
        <button @click="fnAdd">글쓰기</button>
        <button @click="fnRemove">삭제</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                list : [],
                keyword : "",
                searchOption : "all",
                sessionId : "${sessionId}",
                sessionStatus : "${sessionStatus}",
                selectBbs: "",
                index: 0,
                pageSize: 5,
                page: 1
            };
        },
        methods: {
            fnBbsList(){
				var self = this;
				var nparmap = {
                    keyword : self.keyword,
                    searchOption : self.searchOption,
                    pageSize: self.pageSize,
                    page: (self.page - 1) * self.pageSize
                };
				$.ajax({
					url:"/bbs/list.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.list = data.list;
                        self.index = Math.ceil(data.count / self.pageSize);
					}
				});
            },
            fnAdd : function(){
                location.href = "/bbs/add.do";
            },
            fnView : function(bbsNum){
                pageChange("/bbs/view.do", {bbsNum : bbsNum});
            },
            fnRemove : function() {
                var self = this;
                var param = {bbsNum : self.selectBbs};
                $.ajax({
					url:"/bbs/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : param,
					success : function(data) { 
						console.log(data);
                        self.fnBbsList();
					}
				});
            },
            fnPage: function (num) {
                let self = this;
                self.page = num;
                self.fnBbsList();
            },
            fnPageMove: function (direction) {
                let self = this;
                if (direction == "next") {
                    self.page++;
                } else {
                    self.page--;
                }
                self.fnBbsList();
            }
        },
        mounted() {
            var self = this;
            self.fnBbsList();
        }
    });
    app.mount('#app');
</script>