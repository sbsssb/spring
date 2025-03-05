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
        <div>
            내용 : {{info.contents}}
        </div>
        <div>
            조회수 : {{info.cnt}}
        </div>
        <div v-if="sessionId == info.userId || sessionStatus == 'A'">
            <button @click="fnEdit">수정</button>
            <button @click="fnRemove()">삭제</button>
        </div>

        <div class="t-margin">
            <table id="comment-table">
                <tr>
                    <th>작성자</th>
                    <th>댓글 내용</th>
                    
                </tr>
                <tr v-for="item in commentList">
                    <th>{{item.userId}}</th>
                    <td class="comment-pad">
                        <label v-if="editCommentNo == item.COMMENTNO">
                            <input v-model="editContents"></label>
                        <label>{{item.contents}}</label>
                    </td>
                    <td style="width: 90px" v-if="sessionId == info.userId || sessionStatus == 'A'">
                        <template v-if="editCommentNo == item.COMMENTNO">
                            <button @click="fnCommentUpdate(item.COMMENTNO)">저장</button>
                            <button @click="editCommentNo = ''">취소</button>
                        </template>
                        <template v-else>
                            <button @click="fnCommentEdit(item)">수정</button>
                            <button @click="fnCommentRemove(item.COMMENTNO)">삭제</button>
                        </template>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <textarea v-model="comment" cols="40" rows="5"></textarea>
            <button @click="fnCommentSave">등록</button>
        </div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                boardNo : "${map.boardNo}",
                info : {},
                sessionId : "${sessionId}",
                sessionStatus : "${sessionStatus}",
                commentList : [],
                editCommentNo : "",
                editContents : "",
                comment : ""
            };
        },
        methods: {
            fnGetBoard(){
				var self = this;
				var nparmap = {
                    boardNo : self.boardNo,
                    option : "SELECT"
                };
				$.ajax({
					url:"/board/info.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        self.info = data.info;
                        self.commentList = data.commentList;
                        console.log(data.commentList);
					}
				});
            },
            fnEdit : function(){
                pageChange("/board/edit.do", {boardNo : this.boardNo});
            },
            fnRemove : function(){
                var self = this;
				var nparmap = {
                    boardNo : self.boardNo
                };
				$.ajax({
					url:"/board/remove.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						alert("삭제되었습니다.");
                        location.href = "/board/list.do";
					}
				});
            },
            fnCommentEdit : function(item) {
                let self = this;
                self.editCommentNo = item.COMMENTNO;
                self.editContents = item.CONTENTS;
            },
            fnCommentUpdate : function(COMMENTNO) {
                let self = this;
                let nparmap = {
                    COMMENTNO : COMMENTNO,
                    CONTENTS : self.editContents
                }

                $.ajax({
                    url: "http://localhost:3000/comment/update",  // 서버 주소 수정 (http:// 포함)
                    dataType: "json",
                    type: "POST", // GET, POST
                    data: JSON.stringify(nparmap),   // 서버로 보낼 데이터
                    contentType: "application/json",
                    success: function(data) {
                       
                        if(data.msg=="success") {
                            alert("수정되었습니다.");
                            self.editCommentNo = '';
                            self.fnInfo();
                        } else {
                            alert("오류발생!");
                       }
                        
                    }
                });
            },
            fnCommentSave : function (){
                let self = this;
                let nparmap = {
                    comment : self.comment,
                    boardNo : self.boardNo,
                    userId : "${sessionId}"
                };
                $.ajax({
					url:"/board/comment-add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						if(data.msg=="success"){
                        alert("댓글이 등록되었습니다.");
                        self.fnGetBoard();
                       } else {
                        alert("오류발생!");
                       }
					}
				});
            }

        },
        mounted() {
            var self = this;
            self.fnGetBoard();
        }
    });
    app.mount('#app');
</script>