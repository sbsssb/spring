<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<script src="https://unpkg.com/@vuepic/vue-datepicker@latest"></script>
	<link rel="stylesheet" href="https://unpkg.com/@vuepic/vue-datepicker@latest/dist/main.css">
	<title>view 기본 세팅 파일</title>	
</head>
<style>
</style>
<body>
	<div id="app">
		<div style="width : 300px;">
			<vue-date-picker v-model="date" locale="ko"></vue-date-picker>
			<div>선택한 날짜 : {{ date }}</div>
		</div>
	</div>
</body>
</html>
<script>
    const app = Vue.createApp({
        data() {
            return {
				date : new Date()
            };
        },
	    components: { 
			VueDatePicker 
		},
        methods: {
			
        },
        mounted() {
			
        }
    });
    app.mount('#app');
</script>