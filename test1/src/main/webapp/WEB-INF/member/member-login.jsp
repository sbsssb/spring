<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>첫번째 페이지</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
			아이디 : <input v-model="userId">  
		</div>
		<div>
			비밀번호 : <input v-model="pwd">  
		</div>
		<button @click="fnLogin">로그인</button>
		<button @click="fnSearchPass">비밀번호 찾기</button>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
                userId : "",
				pwd : ""				
            };
        },
        methods: {
            fnLogin(){
				var self = this;
				var nparmap = {
					userId : self.userId,
					pwd : self.pwd
				};
				$.ajax({
					url:"/member/login.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
						if(data.result == "success"){
							alert(data.member.userName + "님 환영합니다!");
							location.href="/board/list.do";
						} else {
							alert("아이디/패스워드 확인하세요.");
						}
					}
				});
            }
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>
​