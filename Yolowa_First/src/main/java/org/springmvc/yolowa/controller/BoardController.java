package org.springmvc.yolowa.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Controller
public class BoardController {
	@Resource
	private FundService fundService;

	@Resource
	private RankService rankService;

	@Resource
	private MemberService service;

	@Resource
	private BoardService boardService;

	@RequestMapping("searchListByKeyword.do")
	public String searchListByKeyword(String keyword, HttpServletRequest request, HttpSession session) {
		MemberVO vo = (MemberVO) session.getAttribute("member");
		List<HashMap<String, Object>> sList = (List<HashMap<String, Object>>) boardService.findBoardListByKeyword(keyword);
		for(int i = 0; i < sList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", sList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					sList.get(i).put("countlike", "");
			}
			else{
				sList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
			}
		}
		else{
			if((boardService.selectLike(map).size()-1) == 0){
				sList.get(i).put("countlike", vo.getId() + "님");
			}
			else{
				sList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
			}
		}
	}
	
		request.setAttribute("searchList", sList);
		request.setAttribute("searchMemberList", service.findMemberListByKeyword(keyword));
		request.setAttribute("bList", boardService.getAllBoardList());
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		return "board/searchResult.tiles";
	}

	@RequestMapping("mypage.do")
	public String mypage(HttpServletRequest request, Model model, HttpSession session, String id) {
		session = request.getSession(false);
		MemberVO vo = (MemberVO) session.getAttribute("member");
		request.setAttribute("bList", boardService.getAllBoardList());
		String url = "";
		if (id.equals(vo.getId())) {
			request.setAttribute("ID", vo.getId());
			List<MemberVO> List = service.friendsList(vo.getId(), "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			url = "board/mypage.myTiles";
		} else {
			request.setAttribute("ID", id);
			model.addAttribute("fvo", service.findFriendById(id));
			List<MemberVO> List = service.friendsList(id, "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			url = "board/mypage.myTiles";
		}
		return url;
	}

	@RequestMapping("myMessagePage.do")
	public String myMessagePage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO vo = null;
		if (session != null) {
			vo = (MemberVO) session.getAttribute("member");
			String curPage = request.getParameter("curPage");
			System.out.println(curPage);
			if (curPage == null) {
				curPage = "1";
			}
			request.setAttribute("myReceiveMsg", service.myAllReceiveMsg(vo.getId(), curPage));
		}
		return "board/messagePage.myTiles";
	}

	@RequestMapping("sendMessagePage.do")
	public String sendMessagePage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO vo = null;
		if (session != null) {
			vo = (MemberVO) session.getAttribute("member");
			String curPage = request.getParameter("curPage");
			System.out.println(curPage);
			if (curPage == null) {
				curPage = "1";
			}
			request.setAttribute("mySendMsg", service.myAllSendMsg(vo.getId(), curPage));
		}
		return "board/sendMessage.myTiles";
	}

	// 댓글작성
	@RequestMapping("writeReply.do")
	@ResponseBody
	public Object writeReply(ReplyVO rvo) {
		boardService.writeReply(rvo);
		return boardService.getAllListReply();
	}

	// 대댓글 작성
	@RequestMapping("writeChildReply.do")
	@ResponseBody
	public Object writeChildReply(ReplyVO rvo) {
		boardService.writeChildReply(rvo);
		return boardService.getAllListReply();
	}

	@RequestMapping("writeContentView.do")
	public String writeContentView(HttpSession session, HttpServletRequest request) {
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("bList", boardService.getAllBoardList());
		String keyword = request.getParameter("keyword");

		// 검색
		if (keyword != null)
			request.setAttribute("searchList", boardService.findBoardListByKeyword(keyword));

		// 친구 리스트 & 메세지 박스
		if (session != null && session.getAttribute("member") != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			request.setAttribute("bList", boardService.getAllBoardList());

		}
		return "board/writeContentView.contentTiles";
	}

	// 일반글 넘기기
	private String uploadPath;

	@RequestMapping(value = "writeContext.do", method = RequestMethod.POST)
	public String writeContent(@RequestPart(required = false, value = "file") List<MultipartFile> imageFile,
			HttpServletRequest request, HttpSession session) {
		uploadPath = "C:\\Users\\KOSTA\\git\\yolowa\\yolowa\\src\\main\\webapp\\resources\\asset\\upload\\";
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
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		boardService.userWriteContext(map);
		return "redirect:mainAllContent.do?id=" + vo.getId();
	}

	// 게시글 삭제
	@RequestMapping("deleteBoard.do")
	public String deleteBoard(String bNo, String type, HttpSession session) {
		boardService.deleteBoard(bNo);
		MemberVO vo = (MemberVO) session.getAttribute("member");

		return "redirect:mainAllContent.do?id=" + vo.getId() + "&type=" + type;
	}
	@RequestMapping("deleteMypage.do")
	public String deleteMypage(String bNo,HttpSession session) {
		boardService.deleteBoard(bNo);
		MemberVO vo = (MemberVO) session.getAttribute("member");

		return "redirect:mypage.do?id=" + vo.getId();
	}

	// content 수정
	@RequestMapping("modifyContentView.do")
	public String modifyContentView(HttpServletRequest request, HttpSession session) {
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		request.setAttribute("mList", boardService.getContenBybNo(bNo));
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
		return "board/modifyContentView.contentTiles";
	}

	@RequestMapping(value = "modifyContext.do", method = RequestMethod.POST)
	public String modifyContext(@RequestPart(required = false, value = "imageFile") List<MultipartFile> imageFile,
			HttpServletRequest request, HttpSession session, String type) {

		int bNo = Integer.parseInt(request.getParameter("bNo"));

		 uploadPath =request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		String filepath = "";
		System.out.println("들어옴? 2");
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

		System.out.println("두번째 포문");
		for (int i = 0; i < imageFile.size(); i++) {
			String fileName = imageFile.get(i).getOriginalFilename();
			System.out.println("펭긴 :" + fileName);
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
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		map.put("bNo", bNo);
		boardService.modifyContext(map);
		return "redirect:mainAllContent.do?type=board&id=" + vo.getId();
	}

	@RequestMapping("writeFormMessage.do")
	public String writeMessage(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO vo = null;
		if (session != null) {
			vo = (MemberVO) session.getAttribute("member");
			request.setAttribute("friends", service.friendsList(vo.getId(), "My"));
		}
		return "board/writeFormMessage.myTiles";
	}

	@RequestMapping("adminLike.do")
	@ResponseBody
	public List<HashMap<String, Object>> adminLike(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", request.getParameter("id"));
		map.put("bNo", request.getParameter("bNo"));
		int count = (int) boardService.confirmLike(map);
		if (count == 0) {
			boardService.insertLike(map);
		} else {
			boardService.deleteLike(map);
		}
		return boardService.selectLike(map);
	}

	@RequestMapping("deleteMessage.do")
	public String deleteMessage(String[] deleteMsg, String type, String myId) {
		if (type.equals("receive")) {
			service.deleteReceiveMsg(deleteMsg, myId);
			return "redirect:myMessagePage.do";
		} else {
			service.deleteSendMsg(deleteMsg, myId);
			return "redirect:sendMessagePage.do";
		}
	}

	@RequestMapping("readMsg.do")
	@ResponseBody
	public void readMsg(String mNo) {
		service.readMsg(mNo);
	}
}
