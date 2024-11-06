package com.oracle.samil.HsDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.Facility;
import com.oracle.samil.Amodel.Reservation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HsFacilDaoImpl implements HsFacilDao {
	
	@Autowired
	private final SqlSession session;
	
	// 시설종류 불러오는 List
	@Override
	public List<ResTotal> facilSortList() {
		List<ResTotal> facilSort = null;
		System.out.println("HsFacilDaoImpl facilSortList Start...");
		
		try {
			facilSort = session.selectList("hsFacilSort");
		} catch (Exception e) {
			System.out.println("HsFacilDaoImpl facilSortList e.getMessage()-> "+e.getMessage());
		}
		return facilSort;
	}

	//시설종류 상세정보 (updateForm에) (관리자)
	@Override
	public Facility detailfacil(int facilId) {
		Facility facil = new Facility();
		System.out.println("HsFacilDaoImpl detailfacil Start...");
		try {
			facil = session.selectOne("hsFacSelOne", facilId);
			System.out.println("HsFacilDaoImpl detailfacil facil-> "+facil);
			
		} catch (Exception e) {
			System.out.println("HsFacilDaoImpl detailfacil e.getMessage()-> "+e.getMessage());
		}
		System.out.println("HsFacilDaoImpl detailfacil End...");
		return facil;
	}

	// 관리자 시설예약 시설종류 수정완료된 폼 logic (모달창) (관리자)
	@Override
	public int updateFac(Facility facil) {
		int updateCount = 0;
		System.out.println("HsFacilDaoImpl updateFac Start...");
		
		
		try {
			updateCount = session.update("hsupdateFacil", facil);
			System.out.println("HsFacilDaoImpl updateFac updateCount-> "+updateCount);
		} catch (Exception e) {
			System.out.println("HsFacilDaoImpl updateFac e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}
	
	// 관리자 시설예약 추가 작성 완료된 폼 logic (모달창에서)
	@Override
	public int insertFacil(Facility facil) {
		int result = 0;
		System.out.println("HsFacilDaoImpl insertFacil Start...");
		
		try {
			result = session.insert("hsFacilInsert", facil);
			System.out.println("HsFacilDaoImpl insertFacil facil-> "+facil);
		} catch (Exception e) {
			System.out.println("HsFacilDaoImpl insertFacil e.getMessage()-> "+e.getMessage());
		}
		return result;
	}
	
	//관리자 시설예약 시설종류 삭제 logic
	@Override
	public int deleteFacil(int facilId) {
		int result = 0;
		System.out.println("HsFacilDaoImpl deleteFacil Start...");
		System.out.println("HsFacilDaoImpl deleteFacil facilId->" +facilId);
		try {
			result = session.delete("hsFacilDelete", facilId);
			System.out.println("HsFacilDaoImpl deleteFacil result-> "+result);
		} catch (Exception e) {
			System.out.println("HsFacilDaoImpl deleteFacil e.getMessage()-> "+e.getMessage());
		}
		return result;
	}

}
