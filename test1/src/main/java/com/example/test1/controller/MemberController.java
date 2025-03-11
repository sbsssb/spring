package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.MemberService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@RequestMapping("/member/login.do") 
    public String login(Model model) throws Exception{
		
        return "/member/member-login"; 
    }
	
	@RequestMapping("/member/add.do") 
    public String add(Model model) throws Exception{
		
        return "/member/member-add"; 
    }
	
	@RequestMapping("/addr.do") 
    public String addr(Model model) throws Exception{
		
        return "/jusoPopup"; 
    }
	
	@RequestMapping("/pay.do") 
    public String pay(Model model) throws Exception{
		
        return "/pay"; 
    }
	
	@RequestMapping("/auth.do") 
    public String auth(Model model) throws Exception{
		
        return "/auth"; 
    }
	
	// 로그인
	@RequestMapping(value = "/member/login.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.memberLogin(map);
		return new Gson().toJson(resultMap);
	}
	
	// 회원가입
	@RequestMapping(value = "/member/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String add(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.addMember(map);
		return new Gson().toJson(resultMap);
	}
	
	// 중복체크
	@RequestMapping(value = "/member/check.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String check(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = memberService.checkId(map);
		return new Gson().toJson(resultMap);
	}
	
	// 사용자 정보 조회(pk)
	@RequestMapping(value = "/member/get.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String get(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = memberService.getMember(map); 
		return new Gson().toJson(resultMap);
	}
	
	// 사용자 여러 명 삭제
	@RequestMapping(value = "/member/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberRemoveList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		
		map.put("list", list);
		
		System.out.println(map);
		
		
		resultMap = memberService.memberRemoveList(map);
		return new Gson().toJson(resultMap);
	}
	
}
