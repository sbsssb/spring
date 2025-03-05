package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {

	List<Board> selectBoardList(HashMap<String, Object> map);

	void insertBoard(HashMap<String, Object> map);

	Board selectBoard(HashMap<String, Object> map);

	void updateBoard(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	void deleteBoard(HashMap<String, Object> map);

	void deleteBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<Comment> selectCommentList(HashMap<String, Object> map);

	void insertComment(HashMap<String, Object> map);

}
