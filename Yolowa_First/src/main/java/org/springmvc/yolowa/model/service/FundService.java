package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface FundService {


	HashMap<String, Object> getFundingBybNo(int bNo);

	void modifyFunding(Map<String, Object> map);

	int selectCountFunding(Map<String, Object> map);
	
	void applyFunding(Map<String, Object> map);

	List<HashMap<String, Object>> getPaticipantInfo();



}
