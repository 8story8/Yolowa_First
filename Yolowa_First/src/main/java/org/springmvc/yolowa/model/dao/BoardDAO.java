package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springmvc.yolowa.model.vo.BoardVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

public interface BoardDAO {
	List<HashMap<String, Object>> getAllBoardList();
	
	List<HashMap<String, Object>> findBoardListByKeyword(String keyword);
	
	void writeFunding(Map<String, Object> map);
	
	List<ReplyVO> getAllListReply();
	
	ReplyVO getReplyByRno(int rNo);
	
	void writeReply(ReplyVO rvo);
	
	void writeChildReply(ReplyVO rvo);

	void writeContext(Map<String, Object> map);

	void deleteBoard(String bNo);


	HashMap<String, Object> getContenBybNo(int bNo);

	void modifyContext(Map<String, Object> map);

	List<HashMap<String, Object>> getAllBoardListByCategory(String category);
	
	int confirmLike(Map<String, Object> map);
	
	List<HashMap<String, Object>> selectLike(Map<String, Object> map);
	
	 void insertLike(Map<String, Object> map);
	 
	 void deleteLike(Map<String, Object> map);

}
