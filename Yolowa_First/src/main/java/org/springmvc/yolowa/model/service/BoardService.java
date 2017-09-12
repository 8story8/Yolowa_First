package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.vo.BoardVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Service

public interface BoardService {
	List<HashMap<String, Object>> getAllBoardList();

	List<HashMap<String, Object>> findBoardListByKeyword(String keyword);
	
	void writeFunding(Map<String, Object> map);
	
	List<ReplyVO> getAllListReply();
	
	void writeReply(ReplyVO rvo);

	void userWriteContext(Map<String, Object> map);

	void deleteBoard(String bNo);

	HashMap<String, Object> getContenBybNo(int bNo);

	void modifyContext(Map<String, Object> map);

	List<HashMap<String, Object>> getAllBoardListByCategory(String category);
	
	List<HashMap<String, Object>> selectLike(Map<String, Object> map);
	
	 void insertLike(Map<String, Object> map);
	 
	 void deleteLike(Map<String, Object> map);
	 
	 int confirmLike(Map<String, Object> map);

	void writeChildReply(ReplyVO rvo);
}
