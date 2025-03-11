package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Product;

@Service
public class ProductService {
	
	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list =  productMapper.selectProductList(map);
			resultMap.put("list", list); 
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		Product info = productMapper.selectProduct(map);
		
		if (info == null) {
	        System.out.println("DB 조회 결과: null");
	    } else {
	        System.out.println("DB 조회 결과: " + info.toString()); // 조회된 객체 출력
	    }
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}

}
