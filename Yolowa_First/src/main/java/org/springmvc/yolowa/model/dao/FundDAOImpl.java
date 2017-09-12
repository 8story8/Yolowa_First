package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FundDAOImpl implements FundDAO {
	@Resource
	private SqlSessionTemplate template;

	@Override
	public HashMap<String, Object> getFundingBybNo(int bNo) {
		return template.selectOne("fund.getFundingBybNo",bNo);
	}
	@Override
	public void modifyFunding(Map<String, Object> map) {
		template.update("fund.modifyBoard", map);
		template.update("fund.modifyBoardopt", map);
		template.update("fund.modifyFunding", map);
	}
	@Override
	public int selectCountFunding(Map<String, Object> map) {
		int count=template.selectOne("fund.selectCountFunding",map);
		return count;
	}
	@Override
	public void applyFunding(Map<String, Object> map) {
		template.insert("fund.applyFunding",map);
	}
	@Override
	public List<HashMap<String, Object>> getPaticipantInfo() {
		return template.selectList("fund.getPaticipantInfo");
	}
}
