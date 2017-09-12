package org.springmvc.yolowa.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.MemberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Resource
	private FundService fundService;

	@Resource
	private RankService rankService;

	@Resource
	private MemberService service;

	@Resource
	private BoardService boardService;

	@RequestMapping("{viewName}.do")
	public String showView1(@PathVariable String viewName, HttpServletRequest request) {
		System.out.println("@PathVariable : " + viewName);
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		return viewName + ".tiles";
	}

	@RequestMapping("{dirName}/{viewName}.do")
	public String showView2(@PathVariable String dirName, @PathVariable String viewName) {
		System.out.println("@PathVariable : " + dirName + "/" + viewName);
		return dirName + "/" + viewName + ".tiles";
	}

	@RequestMapping("mainAllContent.do")
	public String home(HttpServletRequest request, String id, String type) {
		HttpSession session = request.getSession(false);
		request.setAttribute("pList", fundService.getPaticipantInfo());
		request.setAttribute("cList", service.getCategoryList(id));
		request.setAttribute("bList", boardService.getAllBoardList());
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록

		// 친구 리스트 & 메세지 박스
		if (session != null && session.getAttribute("member") != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			List<HashMap<String, Object>> bList = (List<HashMap<String, Object>>) boardService.getAllBoardList();
			for(int i = 0; i < bList.size(); i++){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", vo.getId());
				map.put("bNo", bList.get(i).get("bNo"));
				int count = (int) boardService.confirmLike(map);
				if(count == 0){
					if(boardService.selectLike(map).size() == 0){
						bList.get(i).put("countlike", "");
					}
					else{
						bList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
					}
				}
				else{
					if((boardService.selectLike(map).size()-1) == 0){
						bList.get(i).put("countlike", vo.getId() + "님");
					}
					else{
						bList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
					}
				}
			}
			
			request.setAttribute("bList", bList);
		}
		
		if(type!=null){
			if(type.equals("funding")){
				return "board/mainAllFunding.contentTiles";
			}else{
				return "board/mainAllContent.contentTiles";
			}
		}
		return "board/mainAllContent.contentTiles";
	}
	

	@RequestMapping("mainAllCategory.do")
	public String mainAllCategory(HttpServletRequest request){
		HttpSession session = request.getSession(false);
		MemberVO vo = (MemberVO) session.getAttribute("member");
		String category = (String)request.getParameter("category");
		List<HashMap<String, Object>> bCList = (List<HashMap<String, Object>>) boardService.getAllBoardListByCategory(category);
		for(int i = 0; i < bCList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", bCList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					bCList.get(i).put("countlike", "");
				}
				else{
					bCList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
			}
			else{
				if((boardService.selectLike(map).size()-1) == 0){
					bCList.get(i).put("countlike", vo.getId() + "님");
				}
				else{
					bCList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
				}
			}
		}
		
		request.setAttribute("bCList", bCList);
		
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("bList", boardService.getAllBoardList());
		return "board/mainAllCategory.contentTiles";
	}
}
