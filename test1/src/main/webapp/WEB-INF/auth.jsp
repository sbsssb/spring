<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>view 기본 세팅 파일</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<button @click="fnAuth()">인증</button>
	</div>
</body>
</html>
<script>
	const userCode = "imp21475352"; 
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
				
            };
        },
        methods: {
			fnAuth(){
				IMP.certification({
                    channelKey: "channel-key-2b2f3d0a-f5ac-43e5-b1de-f45866edc945",
                    merchant_uid: "merchant_" + new Date().getDate(),
                }, function(rsp){
                    if (rsp.success) {
						alert("인증 성공");
						console.log(rsp);
			   	      } else {
						alert(rsp.error_msg);
			   	      }
                });
			}
        },
        mounted() {
			
        }
    });
    app.mount('#app');
</script>