package com.oracle.samil.HbDao;

import java.util.List;

import com.oracle.samil.Amodel.Utility;

public interface UtilityDao {
	// 유저 데이터
	List<Utility> getUtilityList();
	// 관리자 추가
	Utility utilityPlus(Utility utility);
	// 추가 전 중복체크
	boolean existsByYyyymmAndDetail(int utilityYyyymm, int utilityDetail);

}
