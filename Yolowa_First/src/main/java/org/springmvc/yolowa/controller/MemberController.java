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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;

@Controller
public class MemberController {
	private String uploadPath;
	@Resource
	private MemberService service;

	@RequestMapping("loginView")
	public String loginView() {
		return "member/loginView";
	}

	@RequestMapping("error.do")
	public String error() {
		return "member/error";
	}
	
	@RequestMapping("registerView.do")
	public ModelAndView registerView(HttpServletRequest request) {
		request.setAttribute("categoryList",service.searchCategory());
		return new ModelAndView("member/registerView");
	}

	@RequestMapping("forgotIdView.do")
	public String forgotIdView() {
		return "member/forgotId";
	}

	@RequestMapping("forgotPassView.do")
	public String forgotPassView() {
		return "member/forgotPass";
	}

	// 로그인 (ky)
	@RequestMapping("login.do")
	public String memberLogin(MemberVO vo, HttpServletRequest request) {
		MemberVO member = service.userLogin(vo);
		if (member == null) {
			return "member/login_fail";
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("member", member);

			return "redirect:mainAllContent.do?id=" + member.getId();
		}
	}

	// 아이디찾기
	@RequestMapping("forgotId.do")
	public String forgotId(String name, String phone, Model model) {
		Map<String, String> vo;
		vo = new HashMap<String, String>();
		vo.put("name", name);
		vo.put("phone", phone);
		MemberVO member = service.searchId(vo);
		model.addAttribute("id", member);
		return "member/forgot_result";
	}

	// 패스워드찾기
	@RequestMapping("forgotPass.do")
	public String forgotPass(String id, String name, String phone, Model model) {
		Map<String, String> vo;
		vo = new HashMap<String, String>();
		vo.put("id", id);
		vo.put("name", name);
		vo.put("phone", phone);
		MemberVO member = service.searchPass(vo);
		model.addAttribute("pass", member);
		return "member/forgot_result";
	}

	// 로그아웃 (ky)
	@RequestMapping("logout.do")
	public String memberLogout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session.getAttribute("member") != null && session != null) {
			session.invalidate();
		}
		return "redirect:home.do";
	}

	// 친구추천
	@RequestMapping("recommend.do")
	@ResponseBody
	public Object recommend(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		List<MemberVO> mlist = null;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			mlist = service.findInterestById(vo.getId());
		}
		return mlist;
	}

	// 카테고리 로딩
	@RequestMapping("searchCategory.do")
	public List<CategoryVO> searchCategory(HttpServletRequest request) {
		List<CategoryVO> list = service.searchCategory();
		return list;
	}

	// 아이디 중복체크
	@RequestMapping("idcheckAjax.do")
	@ResponseBody
	public String idcheckAjax(String id) {
		int count = service.idcheck(id);
		return (count == 0) ? "ok" : "fail";
	}

	// 회원 정보, 카테고리, 포인트 등록
	@RequestMapping(value = "registerMember.do", method = RequestMethod.POST)
	public String registerMember(MemberVO vo, HttpServletRequest request) throws IOException {
		String category[] = request.getParameterValues("cNo");
		service.registerMember(vo, category);
		return "redirect:registerResultView.do";
	}

	// 회원가입 결과
	@RequestMapping("registerResultView.do")
	public ModelAndView registerResultView() {
		return new ModelAndView("member/register_result");
	}

	// 회원정보 수정화면 전환
	@RequestMapping("modifyView.do")
	public String modifyView(HttpServletRequest request,String id){
	    request.setAttribute("categoryList",service.searchCategory());
		List<CategoryVO> cList=service.getCategoryList(id);
		request.setAttribute("categoryList",service.searchCategory());
		request.setAttribute("cList", cList);
		return "member/modifyView";
	}

	// 회원정보 수정
	@RequestMapping("modifyMember.do")
	public ModelAndView modifyMember(MemberVO vo, HttpServletRequest request) {
		String category[] = request.getParameterValues("cNo");
		MemberVO mvo = service.modifyMember(vo, category);
		HttpSession session = request.getSession(false);
		session.setAttribute("member", mvo);
		return new ModelAndView("board/mypage.tiles");
	}

	// 프로필사진 업로드
	@RequestMapping("multifileupload.do")
	public String fileUpload(FileVO fvo, HttpServletRequest request) {
		// 실제 운영시에 사용할 서버 업로드 경로
		 uploadPath =request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		// System.out.println(uploadPath);
		// 개발시에는 워크스페이스 업로드 경로로 준다
		System.out.println("multifile controller " + fvo.toString());
		//uploadPath = "C:\\Users\\KOSTA\\git\\yolowa\\yolowa\\src\\main\\webapp\\resources\\asset\\upload\\";
		HttpSession session = request.getSession(false);
		if (session == null) {
			return "home.tiles";
		}
		MemberVO mvo = (MemberVO) session.getAttribute("member");
		List<MultipartFile> list = fvo.getFile();
		fvo.setUserInfo(mvo.getId());
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			String fileName = list.get(i).getOriginalFilename();
			if (fileName.equals("") == false) {
				try {
					list.get(i).transferTo(new File(uploadPath + fileName));
					nameList.add(fileName);
					System.out.println("업로드 완료 " + fileName);
					fvo.setPath("resources/asset/upload/" + fileName);
					System.out.println("데이터 확인 : " + fvo.toString());
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		System.out.println("테스트 1");
		MemberVO vo = service.updateProfile(fvo);
		System.out.println("테스트 2 ");
		session.setAttribute("member", vo);
		return "board/mypage.myTiles";
	}

	// aJax 친구 추가된 리스트
	@RequestMapping("friendsList.do")
	@ResponseBody
	public List<MemberVO> friendsList(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO member = (MemberVO) session.getAttribute("member");
		return service.friendsList(member.getId(), "My");
	}

	@RequestMapping("friendsMsgBox.do")
	@ResponseBody
	public Map<String, Object> friendsMsgBox(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		MemberVO member = (MemberVO) session.getAttribute("member");
		// sId = session Id, rId = request Id
		return service.friendsMsgBox(member.getId(), request.getParameter("rId"));
	}

	// 친구 신청
	@RequestMapping("friendAdd.do")
	@ResponseBody
	public String friendAdd(String id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		int success = 0;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			String sendId = vo.getId();
			String receiveId = id;
			success = service.friendAdd(sendId, receiveId);
		}
		return (success == 0) ? "fail" : "ok";
	}

	// SendMessage
	@RequestMapping("sendMessage.do")
	@ResponseBody
	public String sendMessage(MessageVO msg) {
		System.out.println(msg.toString());
		int success = service.sendMessage(msg);
		return (success == 0) ? "fail" : "ok";
	}

	// Friend Request List
	@RequestMapping("requestList.do")
	@ResponseBody
	public Object requestList(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		List<MemberVO> relist = null;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			relist = service.requestList(vo.getId());
		}
		return relist;
	}

	// Friend Request Check
	@RequestMapping("friendCheck.do")
	@ResponseBody
	public String friendCheck(String id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		int success = 0;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			success = service.userRequestAccept(id, vo.getId());
		}
		return (success == 0) ? "fail" : "ok";
	}

	// Friend Delete
	@RequestMapping("friendDelete.do")
	@ResponseBody
	public String friendDelete(String id, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		int success = 0;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			String sendId = id;
			String receiveId = vo.getId();
			success = service.friendDelete(sendId, receiveId);
		}
		return (success == 0) ? "fail" : "ok";
	}

	// Friend List Page
	@RequestMapping("MyListPage.do")
	public String friendListPage(String id, Model model) {
		System.out.println(id);
		model.addAttribute("flist", service.friendsList(id, "My"));
		model.addAttribute("plist", service.getPointList(id));
		return "member/MyListPage.myTiles";
	}

	@RequestMapping("requestMsg.do")
	@ResponseBody
	public int requestMsg(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		int newMsg = 0;
		if (session.getAttribute("member") != null && session != null) {
			MemberVO vo = (MemberVO) session.getAttribute("member");
			newMsg = service.requestMsg(vo.getId());
		}
		return newMsg;
	}
	
}
