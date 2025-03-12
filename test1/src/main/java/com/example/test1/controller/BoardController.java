package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.common.Common;
import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board/list.do") 
    public String login(Model model) throws Exception{
        return "/board/board-list"; 
    }
	
	@RequestMapping("/board/add.do") 
    public String add(Model model) throws Exception{

        return "/board/board-add"; 
    }
	
	@RequestMapping("/board/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/board/board-view"; 
    }
	
	@RequestMapping("/board/edit.do") 
    public String edit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/board/board-edit"; 
    }
	
	// 게시글 목록
	@RequestMapping(value = "/board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.getBoardList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 추가
	@RequestMapping(value = "/board/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.addBoard(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 상세보기
	@RequestMapping(value = "/board/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.getBoard(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 수정
	@RequestMapping(value = "/board/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.editBoard(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 삭제
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.boardRemove(map);
		return new Gson().toJson(resultMap);
	}

	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/board/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemoveList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		
		map.put("list", list);
		
		System.out.println(map);
		
		
		resultMap = boardService.boardRemoveList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 댓글 추가
	@RequestMapping(value = "/board/comment-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.addComment(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/board/file.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String fileInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.addComment(map);
		return new Gson().toJson(resultMap);
	}
	
	
	
	// 파일 업로드
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> files, 
	                     @RequestParam("boardNo") int boardNo, 
	                     HttpServletRequest request, HttpServletResponse response, 
	                     Model model) {
		String url = null;
	    String path = "c:\\img";

	    try {
	        String uploadpath = path;

	        for (MultipartFile multi : files) {
	            if (!multi.isEmpty()) {
	                String originFilename = multi.getOriginalFilename();
	                String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
	                long size = multi.getSize();
	                String saveFileName = Common.genSaveFileName(extName);

	                System.out.println("uploadpath : " + uploadpath);
	                System.out.println("originFilename : " + originFilename);
	                System.out.println("extensionName : " + extName);
	                System.out.println("size : " + size);
	                System.out.println("saveFileName : " + saveFileName);

	                // 현재 디렉토리 경로 가져오기
	                String path2 = System.getProperty("user.dir");
	                System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");

	                // 파일 저장 경로 설정
	                File saveFile = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
	                multi.transferTo(saveFile);

	                // 데이터 저장 준비
	                HashMap<String, Object> map = new HashMap<>();
	                map.put("filename", saveFileName);
	                map.put("path", "../img/" + saveFileName);
	                map.put("originFilename", originFilename);
	                map.put("extName", extName);
	                map.put("size", size);
	                map.put("boardNo", boardNo);

	                // 서비스 호출
	                boardService.addBoardFile(map);

	                // 모델에 데이터 추가
	                model.addAttribute("filename", originFilename);
	                model.addAttribute("uploadPath", saveFile.getAbsolutePath());
	            }
	        }
	        return "redirect:board/list.do";
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "파일 업로드 중 에러가 발생했습니다.");
	        return "errorPage"; // 에러 페이지로 리다이렉트하도록 변경
	    }
	}

}
