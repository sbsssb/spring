package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;
import com.example.test1.model.Board;

@Mapper
public interface BbsMapper {

	List<Board> selectBbsList(HashMap<String, Object> map);

	int selectBbsCnt(HashMap<String, Object> map);

	void insertBbs(HashMap<String, Object> map);

	void insertBbsFile(HashMap<String, Object> map);

	Bbs selectBbs(HashMap<String, Object> map);

	List<Bbs> selectImg(HashMap<String, Object> map);

	void deleteBbs(HashMap<String, Object> map);

	void updateBbs(HashMap<String, Object> map);

}
