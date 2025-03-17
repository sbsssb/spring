package com.example.test1.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.common.Common;
import com.example.test1.dao.BbsService;
import com.google.gson.Gson;

@Controller
public class BbsController {
	
	@Autowired
	BbsService bbsService;
	
	@RequestMapping("/bbs/list.do") 
    public String bbsList(Model model) throws Exception{
        return "/bbs/bbs-list"; 
    }
	
	@RequestMapping("/bbs/add.do") 
    public String add(Model model) throws Exception{
        return "/bbs/bbs-add"; 
    }
	
	@RequestMapping("/bbs/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/bbs/bbs-view"; 
    }
	
	@RequestMapping("/bbs/edit.do") 
    public String edit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		request.setAttribute("map", map);
        return "/bbs/bbs-edit"; 
    }
	
	@RequestMapping(value = "/bbs/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = bbsService.getBbsList(map);
		return new Gson().toJson(resultMap);
	}
    
	@RequestMapping(value = "/bbs/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("map 데이터: " + map);

		resultMap = bbsService.addBbs(map);
		return new Gson().toJson(resultMap);
	}
	
	//상세보기
	@RequestMapping(value = "/bbs/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = bbsService.getBbs(map);
		return new Gson().toJson(resultMap);
	}
	   
	//삭제
	@RequestMapping(value = "/bbs/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = bbsService.bbsRemove(map);
		return new Gson().toJson(resultMap);
	}
	
	//수정
	@RequestMapping(value = "/bbs/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String edit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = bbsService.editBbs(map);
		return new Gson().toJson(resultMap);
	}
	
	// 파일 업로드
	@RequestMapping("/bbs/fileUpload.dox")

	public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("bbsNum") int bbsNum, HttpServletRequest request,HttpServletResponse response, Model model)

	{
		String url = null;
		String path="c:\\img";

		try {
			
			boolean thumbFlg = true;

			for(MultipartFile multi : files) {

				System.out.println(multi.getOriginalFilename());

				//String uploadpath = request.getServletContext().getRealPath(path);

				String uploadpath = path;
				String originFilename = multi.getOriginalFilename();
				String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
				long size = multi.getSize();
				String saveFileName = Common.genSaveFileName(extName);
				

				System.out.println("uploadpath : " + uploadpath);
				System.out.println("originFilename : " + originFilename);
				System.out.println("extensionName : " + extName);
				System.out.println("size : " + size);
				System.out.println("saveFileName : " + saveFileName);

				String path2 = System.getProperty("user.dir");

				System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");

				if(!multi.isEmpty())

				{

					File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);

					multi.transferTo(file);
					
					HashMap<String, Object> map = new HashMap<String, Object>();

					map.put("filename", saveFileName);
					map.put("filepath", "../img/" + saveFileName);
					map.put("bbsNum", bbsNum);

					String thumbNail = thumbFlg ? "Y" : "N";

					map.put("thumbNail", thumbNail);
					
					bbsService.addBbsFile(map);

					thumbFlg = false;
	
					// insert 쿼리 실행

					model.addAttribute("filename", multi.getOriginalFilename());
					model.addAttribute("uploadPath", file.getAbsolutePath());


				}

			}
				return "redirect:/bbs/list.do";

		}catch(Exception e) {

			System.out.println(e);

		}

		return "redirect:/bbs/list.do";

	}
	
}
