package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.dao.BoardDAO;
import org.springmvc.yolowa.model.dao.MemberDAO;
import org.springmvc.yolowa.model.vo.BoardVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Resource
	private BoardDAO boardDAO;
	
	@Resource
	private MemberDAO memberDAO;

	@Override
	public List<HashMap<String, Object>> getAllBoardList() {
		return boardDAO.getAllBoardList();
	}

	@Override
	public List<HashMap<String, Object>> findBoardListByKeyword(String keyword) {
		return boardDAO.findBoardListByKeyword(keyword);
	}

	@Override
	public void writeFunding(Map<String, Object> map) {
		boardDAO.writeFunding(map);
	}

	// 댓글
	@Override
	public List<ReplyVO> getAllListReply() {
		List<ReplyVO> list=boardDAO.getAllListReply();
		MemberVO mvo=new MemberVO();
		for(int i=0; i<list.size(); i++){
			mvo=memberDAO.getMemberListById(list.get(i).getMemberVO().getId());
			list.get(i).setMemberVO(mvo);
		}
		return list;
	}

	@Override
	public void writeReply(ReplyVO rvo) {
		boardDAO.writeReply(rvo);
	}
	
	@Override
	public void writeChildReply(ReplyVO rvo) {
		ReplyVO replyVO=boardDAO.getReplyByRno(rvo.getParentsNo());
		replyVO.setParentsNo(rvo.getParentsNo());
		replyVO.setrContent(rvo.getrContent());
		replyVO.setMemberVO(rvo.getMemberVO());
		boardDAO.writeChildReply(replyVO);	
	}

	@Override
	public void userWriteContext(Map<String, Object> map) {
		boardDAO.writeContext(map);

	}

	@Override
	public void deleteBoard(String bNo) {
		boardDAO.deleteBoard(bNo);

	}

	@Override
	public HashMap<String, Object> getContenBybNo(int bNo) {
		return boardDAO.getContenBybNo(bNo);
	}

	@Override
	public void modifyContext(Map<String, Object> map) {
		boardDAO.modifyContext(map);
	}
	public List<HashMap<String, Object>> getAllBoardListByCategory(String category) {
		return boardDAO.getAllBoardListByCategory(category);
	}


	@Override
	public List<HashMap<String, Object>> selectLike(Map<String, Object> map) {
		return boardDAO.selectLike(map);
	}

	@Override
	public void insertLike(Map<String, Object> map) {
		boardDAO.insertLike(map);
	}

	@Override
	public void deleteLike(Map<String, Object> map) {
		boardDAO.deleteLike(map);
	}

	@Override
	public int confirmLike(Map<String, Object> map) {
		return boardDAO.confirmLike(map);
	}
}


