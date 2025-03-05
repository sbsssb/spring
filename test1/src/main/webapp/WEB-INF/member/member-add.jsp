<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<title>회원 가입</title>
</head>
<style>
</style>
<body>
	<div id="app">
		<div>
            아이디 : <input v-model="user.userId">
            <button @click="fnCheck(user.userId)">중복체크</button>
        </div>
        <div>
            비밀번호 : <input v-model="user.pwd">
        </div>
        <div>
            이름 : <input v-model="user.userName">
        </div>
        <div>
            주소 : <input v-model="user.address">
            <button @click="fnSearchAddr">주소 검색</button>
        </div>
        <div>
            <input v-model="user.phoneNum" placeholder="번호 입력">
            <button @click="fnSmsAuth">문자 인증</button>
        </div>

        <div v-if="authFlg">
            <div v-if="joinFlg" style="color: red;">
                문자 인증 완료
            </div>
            <div v-else>
                <input v-model="authInputNum" :placeholder="timer">
                <button @click="fnNumAuth">인증</button>
            </div>
        </div>

        <div>
            권한 : 
                <input type="radio" name="status" value="C" v-model="user.status">일반
                <input type="radio" name="status" value="A" v-model="user.status">관리자
        </div>
        <div>
            <button @click="fnJoin">가입</button>
        </div>
	</div>
</body>
</html>
<script>
    function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
        window.vueObj.fnResult(roadFullAddr, roadAddrPart1, addrDetail, engAddr);
    }

    const app = Vue.createApp({
        data() {
            return {
                user : {
                    userId :"",
                    userName: "",
                    pwd : "",
                    address : "",
                    status : "C",
                    phoneNum: ""
                },
                authNum : "", // 서버에서 만든 랜덤 숫자
                authInputNum : "", // 사용자가 문자로 받고 입력한 숫자
                authFlg : false, // 인증 번호 입력 상태
                joinFlg : false,  // 문자 인증 완료 상태
                timer : "",
                count : 180
            };
        },
        methods: {
            fnJoin(){
				var self = this;
				var nparmap = self.user;
				$.ajax({
					url:"/member/add.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("가입추가");
                        location.href="/member/login.do";
					}
				});
            },
            fnCheck(userId) {
                var self = this;
				var nparmap = self.user;
				$.ajax({
					url:"/member/check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(self.user.userId == "") {
                            alert("아이디를 입력하세요.");
                            return;
                        }

                        if (data.count == 1) {
                            alert("이미 존재하는 아이디입니다.");
                        } else {
                            alert("사용 가능합니다.")
                        }
                        
					}
				});
            },
            fnSearchAddr : function() {
                window.open("/addr.do", "addr", "width=500, height=500");
            },
            fnResult : function(roadFullAddr, roadAddrPart1, addrDetail, engAddr) {
                var self = this;
                console.log(roadFullAddr);
                console.log(roadAddrPart1);
                console.log(addrDetail);
                console.log(engAddr);
                self.user.address = roadFullAddr;
            },
            fnSmsAuth : function() {
                var self = this;
				var nparmap = {
                    phoneNum : self.user.phoneNum
                };
				$.ajax({
					url:"/send-one",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.response.statusCode == 2000) {
                            alert("문자 발송 완료");
                            self.authNum = data.ranStr;
                            self.authFlg = true;
                            setInterval(self.fnTimer, 1000);
                        } else {
                            alert("잠시 후 다시 시도해 주세요");
                        }
					}
				});
            },
            fnNumAuth : function() {
                let self = this;
                if(self.authFlg == false) {
                    alert("문자 인증을 먼저 하세요");
                    return;
                }
                if(self.authNum == self.authInputNum) {
                    alert("인증되었습니다");
                    self.joinFlg = true;
                } else {
                    alert("인증 번호 다시 확인 바람");
                }
            },
            fnTimer : function() {
                let self = this;
                let min = "";
                let sec = "";
                min = parseInt(self.count / 60);
                sec = parseInt(self.count % 60);
                
                min = min < 10 ? "0" + min : min;
                sec = sec < 10 ? "0" + sec : sec;

                self.timer = min + ":" + sec;
                
                self.count--;
            }
        },
        mounted() {
            var self = this;
            window.vueObj = this;
        }
    });
    app.mount('#app');
</script>