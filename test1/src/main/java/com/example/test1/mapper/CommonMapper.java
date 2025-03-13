package com.example.test1.mapper;

import java.awt.Menu;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommonMapper {

	List<Menu> selectMenuList(HashMap<String, Object> map);

}
