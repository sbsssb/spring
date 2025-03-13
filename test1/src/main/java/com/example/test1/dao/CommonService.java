package com.example.test1.dao;

import java.awt.Menu;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.CommonMapper;

@Service
public class CommonService {
	
	@Autowired
	CommonMapper commonMapper;

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		map.put("depth", 1);
		List<Menu> mainList = commonMapper.selectMenuList(map);
		map.put("depth", 2);
		List<Menu> subList = commonMapper.selectMenuList(map);
		
		resultMap.put("mainList", mainList);
		resultMap.put("subList", subList);
		
		return resultMap;
	}

}
