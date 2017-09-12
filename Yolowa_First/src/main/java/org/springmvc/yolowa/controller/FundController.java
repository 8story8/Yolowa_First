package org.springmvc.yolowa.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.MemberVO;

@Controller
public class FundController {
	private String uploadPath;
	@Resource
	private FundService fundService;
	@Resource
	private MemberService service;
	@Resource
	private BoardService boardService;

	@Resource
	private RankService rankService;

	
	@RequestMapping("fundFileUpload.do")
	public String fundFileUpload() {
		return uploadPath;
		// 실제 운영시에 사용할 서버 업로드 경로
		// uploadPath =
		// request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		// System.out.println(uploadPath);
		// 개발시에는 워크스페이스 업로드 경로로 준다
	}

	@RequestMapping("writeFundingView.do")
	public String writeFundingView(HttpServletRequest request, HttpSession session) {
		List<CategoryVO> list = service.searchCategory();
		request.setAttribute("categoryList", list);
		String keyword = request.getParameter("keyword");
		request.setAttribute("rankList", rankService.selectRank());// rankList
		// 검색
		if (keyword != null)
			request.setAttribute("searchList", boardService.findBoardListByKeyword(keyword));

		// 친구 리스트 & 메세지 박스
		if (session != null && session.getAttribute("member") != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			request.setAttribute("bList", boardService.getAllBoardList());

		}
		return "board/writeFundingView.contentTiles";
	}

	@RequestMapping(value = "writeFunding.do", method = RequestMethod.POST)
	public String writeFunding(@RequestPart(required = false, value = "imageFile") List<MultipartFile> imageFile,
			HttpServletRequest request, HttpSession session) {
		 uploadPath =request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		String filepath = "";
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < imageFile.size(); i++) {
			String fileName = imageFile.get(i).getOriginalFilename();
			try {
				imageFile.get(i).transferTo(new File(uploadPath + fileName));
				if (i == (imageFile.size() - 1)) {
					nameList.add(fileName);

				} else {
					nameList.add(fileName + "/");
				}
				System.out.println("업로드 완료 " + fileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < nameList.size(); i++) {
			filepath += nameList.get(i);
		}
		MemberVO vo = (MemberVO) session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("bType", request.getParameter("bType"));
		map.put("fTitle", request.getParameter("fTitle"));
		map.put("fPeople", request.getParameter("fPeople"));
		map.put("fPoint", request.getParameter("fPoint"));
		map.put("fDeadLine", request.getParameter("fDeadLine"));
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		boardService.writeFunding(map);
		return "redirect:mainAllContent.do?type=funding&id=" + vo.getId();
	}

	@RequestMapping("modifyFundingView.do")
	public String modifyFundingView(HttpServletRequest request,HttpSession session) {
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		request.setAttribute("mList", fundService.getFundingBybNo(bNo));
		request.setAttribute("categoryList", service.searchCategory());
		String keyword = request.getParameter("keyword");
		request.setAttribute("rankList", rankService.selectRank());// rankList
		// 검색
		if (keyword != null)
			request.setAttribute("searchList", boardService.findBoardListByKeyword(keyword));

		// 친구 리스트 & 메세지 박스
		if (session != null && session.getAttribute("member") != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			request.setAttribute("bList", boardService.getAllBoardList());

		}
		return "board/modifyFundingView.contentTiles";
	}

	@RequestMapping(value = "modifyFunding.do", method = RequestMethod.POST)
	public String modifyFunding(@RequestPart(required = false, value = "imageFile") List<MultipartFile> imageFile,
			HttpServletRequest request, HttpSession session, String type) {
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		 uploadPath =request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		String filepath = "";
		ArrayList<String> nameList = new ArrayList<String>();
		String[] photo = null;
		System.out.println("들어옴? 1");
		photo = request.getParameterValues("file");
		System.out.println("포토 사진 :" + photo.length);

		if (photo != null) {
			for (int i = 1; i < photo.length; i++) {
				System.out.println(photo[i]);
				nameList.add(photo[i] + "/");
			}
		}
		for (int i = 0; i < imageFile.size(); i++) {
			String fileName = imageFile.get(i).getOriginalFilename();
			try {
				imageFile.get(i).transferTo(new File(uploadPath + fileName));
				if (i == (imageFile.size() - 1)) {
					nameList.add(fileName);

				} else {
					nameList.add(fileName + "/");
				}
				System.out.println("업로드 완료 " + fileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < nameList.size(); i++) {
			filepath += nameList.get(i);
		}
		MemberVO vo = (MemberVO) session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("bType", request.getParameter("bType"));
		map.put("fTitle", request.getParameter("fTitle"));
		map.put("fPeople", request.getParameter("fPeople"));
		map.put("fPoint", request.getParameter("fPoint"));
		map.put("fDeadLine", request.getParameter("fDeadLine"));
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		map.put("bNo", bNo);

		fundService.modifyFunding(map);
		return "redirect:mainAllContent.do?type=funding&id=" + vo.getId();
	}
	
	@RequestMapping(value="applyFunding.do", method = RequestMethod.POST)
	@ResponseBody
	public int applyFunding(HttpServletRequest request,HttpSession session) {
		String type =request.getParameter("type");
		MemberVO vo= (MemberVO) session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("bNo", request.getParameter("bNo"));
		int count = fundService.selectCountFunding(map);
		if(type.equals("apply")){
			if(count==0){
				fundService.applyFunding(map);
			}else{
				
			}
		}else if(type.equals("delete")){
			//fundService.deleteFunding(map);
		}
		return count;
	}
	
}