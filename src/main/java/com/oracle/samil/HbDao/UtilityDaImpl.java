package com.oracle.samil.HbDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Amodel.Utility;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class UtilityDaImpl implements UtilityDao {
	
				@Autowired
				private final SqlSession session;
				// 유저 데이터 확인 
				@Override
				public List<Utility> getUtilityList() {
					
					List<Utility> getUtiltyList = null;
					try {
						getUtiltyList = session.selectList("hbgetUtilityList");
					} catch (Exception e) {
						System.out.println("UtilityDaImpl error .. : " + e.getMessage());
					}
					return getUtiltyList;
				}
				// 관리자 추가
				@Override
				public Utility utilityPlus(Utility utility) {
					try {
						int utilityPlusResult = session.insert("hbutilityPlus", utility);
				        if (utilityPlusResult > 0) {
				            System.out.println("utilityPlusResult Insertion successful");
				        } else {
				            System.out.println("utilityPlusResult Insertion failed");
				        }
				    } catch (Exception e) {
				        System.out.println("utilityDaoImpl utilityPlus error " + e.getMessage());
				        e.printStackTrace();
					
				    }					
					return utility;
				}
				// 관리자 중복 체크
				public boolean existsByYyyymmAndDetail(int utilityYyyymm, int utilityDetail) {
				    Map<String, Integer> params = new HashMap<>();
				    params.put("utilityYyyymm", utilityYyyymm);
				    params.put("utilityDetail", utilityDetail);
				    Integer count = session.selectOne("hbexistsByYyyymmAndDetail", params);
				    return count != null && count > 0; // 존재 여부를 Boolean으로 반환
			}
}

