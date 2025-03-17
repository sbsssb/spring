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
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
            제목 : {{info.title}}
        </div>
        <div v-for="item in file">
            <img :src="item.filePath">
        </div>
        <div>
            내용 : {{info.contents}}
        </div>
        <div>
            조회수 : {{info.hit}}
        </div>
        <div>
            작성일 : {{info.cdateTime}}
        </div>
        <div>
            <button @click="fnEdit">수정</button>
            <button @click="fnRemove()">삭제</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                bbsNum : "${map.bbsNum}",
                info : {},
                sessionId : "${sessionId}",
                sessionStatus : "${sessionStatus}",
                commentList : [],
                editCommentNo : "",
                editContents : "",
                comment : "",
                fileList : []
            };
        },
        methods: {
            fnGetBbs(){
				var self = this;
				var nparmap = {
                    bbsNum : self.bbsNum
                };
				$.ajax({
					url:"/bbs/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.info);
                        self.info = data.info;
                        self.file = data.file;
					}
				});
            },
            fnEdit : function(){
                pageChange("/bbs/edit.do", {bbsNum : this.bbsNum});
            }
        },
        mounted() {
            var self = this;
            self.fnGetBbs();
        }
    });
    app.mount('#app');
</script>