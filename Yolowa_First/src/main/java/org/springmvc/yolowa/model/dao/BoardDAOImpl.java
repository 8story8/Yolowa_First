package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springmvc.yolowa.model.vo.BoardVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Resource
	private SqlSessionTemplate template; 
	
	@Override
	public List<HashMap<String, Object>> getAllBoardList(){
		List<HashMap<String, Object>> bList = template.selectList("board.getAllBoardList");
		for(int i = 0; i < bList.size(); i++){
			if(!bList.get(i).containsKey("FTITLE")){
				bList.get(i).put("FTITLE", 0);
			}
			
			if(!bList.get(i).containsKey("countlike")){
		            bList.get(i).put("countlike", 0);
		    }
			
			if(!bList.get(i).containsKey("local")){
				bList.get(i).put("local", 0);
			}
			
			if(!bList.get(i).containsKey("filepath")){
				bList.get(i).put("filepath", 0);
			}
			
			if(!bList.get(i).containsKey("")){
				
			}
		}
		return bList;
	}
	
	@Override
	public List<HashMap<String, Object>> findBoardListByKeyword(String keyword){
		List<HashMap<String, Object>> fbList = template.selectList("board.findBoardListByKeyword", keyword);
		for(int i = 0; i < fbList.size(); i++){
			if(!fbList.get(i).containsKey("FTITLE")){
				fbList.get(i).put("FTITLE", 0);
			}
			
			if(!fbList.get(i).containsKey("local")){
				fbList.get(i).put("local", 0);
			}
			
			if(!fbList.get(i).containsKey("filepath")){
				fbList.get(i).put("filepath", 0);
			}
		}
		return fbList;
	}

	@Override
	public void writeFunding(Map<String, Object> map) {
		template.insert("board.writeFunding",map);
	}
	
	@Override
	public void writeContext(Map<String, Object> map) {
		template.insert("board.writeContext",map);
		
	}
	
	// 댓글
	@Override
	public List<ReplyVO> getAllListReply(){
		return template.selectList("board.getAllListReply");
	}

	@Override
	public void writeReply(ReplyVO rvo) {
		template.insert("board.writeReply", rvo);
	}

	@Override
	public void writeChildReply(ReplyVO rvo) {
		template.insert("board.writeChildReply", rvo);	
	}
	
	@Override
	public ReplyVO getReplyByRno(int rNo){
		return template.selectOne("board.getReplyByRno", rNo);
	}
	
	@Override
	public void deleteBoard(String bNo) {
		template.delete("board.deleteBoard",bNo);
	}

	@Override
	public List<HashMap<String, Object>> getAllBoardListByCategory(String category) {
		List<HashMap<String, Object>> bCList = template.selectList("board.getAllBoardListByCategory", category);
		for(int i = 0; i < bCList.size(); i++){
			if(!bCList.get(i).containsKey("FTITLE")){
				bCList.get(i).put("FTITLE", 0);
			}
			
			if(!bCList.get(i).containsKey("countlike")){
	            bCList.get(i).put("countlike", 0);
			}
			
			if(!bCList.get(i).containsKey("local")){
				bCList.get(i).put("local", 0);
			}
			
			if(!bCList.get(i).containsKey("filepath")){
				bCList.get(i).put("filepath", 0);
			}
		}
		return bCList;
	}

	@Override
	public void insertLike(Map<String, Object> map){
		template.insert("board.insertLike", map);
	}
	
	@Override
	public void deleteLike(Map<String, Object> map){
		template.delete("board.deleteLike", map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectLike(Map<String, Object> map) {
		return template.selectList("board.selectLike", map);
	}

	@Override
	public int confirmLike(Map<String, Object> map) {
		return template.selectOne("board.confirmLike", map);
	}

	@Override
	public HashMap<String, Object> getContenBybNo(int bNo) {
		return template.selectOne("board.getContenBybNo", bNo);
	}

	@Override
	public void modifyContext(Map<String, Object> map) {
		template.update("board.modifyBoard", map);
		template.update("board.modifyBoardopt", map);
	}

}
