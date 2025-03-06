package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BoardMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
import com.example.test1.model.File;

@Service
public class BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	// get, select
	// add, insert
	// edit, update
	// remove, delete
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Board> list =  boardMapper.selectBoardList(map);
			
			int count = boardMapper.selectBoardCnt(map);
			
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

	public HashMap<String, Object> addBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertBoard(map);
		System.out.println(map.get("boardNo"));
		
		resultMap.put("boardNo", map.get("boardNo"));
		resultMap.put("result", "success");
		
		return resultMap;
	}

	public HashMap<String, Object> getBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(map.get("option").equals("SELECT")) {
			boardMapper.updateCnt(map);
		}
		Board info = boardMapper.selectBoard(map);
		
		List<Comment> commentList =  boardMapper.selectCommentList(map);
		
		List<File> file = boardMapper.selectFile(map);
		
		resultMap.put("file", file);
		
		resultMap.put("commentList", commentList);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> editBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateBoard(map);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> boardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.deleteBoard(map);
		resultMap.put("result", "success");

		return resultMap;
	}

	public HashMap<String, Object> boardRemoveList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.deleteBoardList(map);
		resultMap.put("result", "success");

		return resultMap;
	}

	
	// 댓글 추가
	public HashMap<String, Object> addComment(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertComment(map);
		resultMap.put("result", "success");
		
		return resultMap;
	}

	public void addBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.insertBoardFile(map);
	}


}
