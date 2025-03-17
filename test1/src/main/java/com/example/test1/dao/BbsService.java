package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.Board;
import com.example.test1.model.File;
import com.google.gson.Gson;

@Service
public class BbsService {
	
	@Autowired
	BbsMapper bbsMapper;

	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list =  bbsMapper.selectBbsList(map);
			
			int count = bbsMapper.selectBbsCnt(map);
			
			resultMap.put("count", count); 
			
			resultMap.put("list", list); 
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		bbsMapper.insertBbs(map);
		
		
		
		resultMap.put("bbsNum", map.get("bbsNum"));
		
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public void addBbsFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		bbsMapper.insertBbsFile(map);
	}

	public HashMap<String, Object> getBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Bbs info = bbsMapper.selectBbs(map);
		System.out.println("조회된 Bbs 정보: " + info);
		
		List<Bbs> file = bbsMapper.selectImg(map);
		System.out.println("조회된 이미지 리스트: " + file);
		
		resultMap.put("info", info);
		resultMap.put("file", file);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> bbsRemove(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		bbsMapper.deleteBbs(map);
		System.out.println(map.get("bbsNum"));
		resultMap.put("result", "success");

		return resultMap;
	}

	public HashMap<String, Object> editBbs(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		bbsMapper.updateBbs(map);
		resultMap.put("result", "success");
		return resultMap;
	}

}
