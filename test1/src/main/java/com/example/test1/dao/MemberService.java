package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

	public HashMap<String, Object> memberLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Member member = memberMapper.getMember(map);
		
		if(member != null) {
			System.out.println("성공");
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getUserName());
			session.setAttribute("sessionStatus", member.getStatus());
			
			resultMap.put("member", member);
			resultMap.put("result", "success");
		} else {
			System.out.println("실패");
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
}