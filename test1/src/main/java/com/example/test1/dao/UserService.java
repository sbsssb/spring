package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.UserMapper;
import com.example.test1.model.Member;
import com.example.test1.model.User;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	public HashMap<String, Object> userLogin(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		User user = userMapper.userMapperLogin(map);
		String result = user != null ? "success" : "fail";
		
		resultMap.put("result", result);
		resultMap.put("info", user); 
		
		return resultMap;
	}

	public HashMap<String, Object> memberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Member> list = userMapper.getUserList(map);
		resultMap.put("list", list); 
		// resultMap : { list : [ {},{},{}] }
		return resultMap;
	}

	public HashMap<String, Object> memberRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userMapper.memberDelete(map);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> testRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		userMapper.testDelete(map);
		
		resultMap.put("result", "success");
		return resultMap;
	}
}




