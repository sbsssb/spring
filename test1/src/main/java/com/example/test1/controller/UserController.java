package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.UserService;
import com.google.gson.Gson;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@RequestMapping("/login.do") 
    public String login(Model model) throws Exception{

        return "/login"; // login.jsp 파일을 실행
    }
	
	@RequestMapping("/member/list.do") 
    public String list(Model model) throws Exception{

        return "/member-list"; // login.jsp 파일을 실행
    }
		
	@RequestMapping("/test.do") 
    public String test(Model model) throws Exception{

        return "/test1"; // login.jsp 파일을 실행
    }
	
	
	@RequestMapping(value = "/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		System.out.println(map); 
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.userLogin(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.memberList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/member/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.memberRemove(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/test/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String testRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = userService.testRemove(map);
		return new Gson().toJson(resultMap);
	}
	
}// UserController
