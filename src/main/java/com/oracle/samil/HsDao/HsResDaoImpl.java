package com.oracle.samil.HsDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Adto.ResTotal;
import com.oracle.samil.Amodel.Event;
import com.oracle.samil.Amodel.FacilApprove;
import com.oracle.samil.Amodel.Reservation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class HsResDaoImpl implements HsResDao {
	
	@Autowired
	private final SqlSession session;
	
	//시설예약 대기 조회 List (사용자)
	@Override
	public List<ResTotal> listload(ResTotal res) {
		List<ResTotal> listload = null;
		System.out.println("HsResDaoImpl listload Start...");

		try {
			listload = session.selectList("hsResListLoad",res);
			System.out.println("HsResDaoImpl listload listload.size()-> "+listload.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsResDaoImpl listload e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsResDaoImpl listload End...");
		return listload;
	}
	
	//시설예약 완료 조회 List (사용자)
	@Override
	public List<ResTotal> listFacilAcc(ResTotal faAp) {
		List<ResTotal> listFacilAcc = null;
		System.out.println("HsResDaoImpl listFacilAcc Start...");
		
		try {
			listFacilAcc = session.selectList("hsResListAcc",faAp);
			System.out.println("HsResDaoImpl listFacilAcc listload.size()-> "+listFacilAcc.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsResDaoImpl listFacilAcc e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsResDaoImpl listFacilAcc End...");
		return listFacilAcc;
	}
	
	//시설예약 반려 조회 List (사용자)
	@Override
	public List<ResTotal> listFacilRej(ResTotal faAp) {
		List<ResTotal> listFacilRej = null;
		System.out.println("HsResDaoImpl listFacilRej Start...");

		try {
			listFacilRej = session.selectList("hsResListRej",faAp);
			System.out.println("HsResDaoImpl listFacilRej listFacilRej.size()-> "+listFacilRej.size());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("HsResDaoImpl listFacilRej e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsResDaoImpl listFacilRej End...");
		return listFacilRej;
	}
	
	//시설예약 예약 작성 insert (사용자)
	@Override
	public int insertReserv(ResTotal res) {
		int result = 0;
		System.out.println("HsResDaoImpl insertReserv Start...");
		
		try {
			result = session.insert("hsReserInsert", res);
			System.out.println("HsResDaoImpl insertReserv result-> "+result);
		} catch (Exception e) {
			System.out.println("HsResDaoImpl insertReserv e.getMessage()-> "+e.getMessage());
		}
		return result;
	}

	@Override
	public Reservation detailRes(int resCode) {
		Reservation resT = new Reservation();
		System.out.println("HsResDaoImpl detailRes Start...");
		try {
			resT = session.selectOne("hsResSelOne", resCode);
			System.out.println("HsResDaoImpl detailRes resT-> "+resT);
			
		} catch (Exception e) {
			System.out.println("HsResDaoImpl detailRes e.getMessage()-> "+e.getMessage());
		}
		System.out.println("HsResDaoImpl detailRes End...");
		return resT;
	}
	
	@Override
	public int updateReserv(ResTotal res) {
		int updateCount = 0;
		System.out.println("HsResDaoImpl updateReserv Start...");

		try {
			updateCount = session.update("hsupdateReserv", res);
			System.out.println("HsResDaoImpl updateReserv updateCount-> "+updateCount);
		} catch (Exception e) {
			System.out.println("HsResDaoImpl updateReserv e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}


	@Override
	public int deleteRes(int resCode) {
		int result = 0;
		System.out.println("HsResDaoImpl deleteRes Start...");
		System.out.println("HsResDaoImpl deleteRes resCode->" +resCode);
		try {
			result = session.delete("hsResDelete", resCode);
			System.out.println("HsResDaoImpl deleteRes result-> "+result);
		} catch (Exception e) {
			System.out.println("HsResDaoImpl deleteRes e.getMessage()-> "+e.getMessage());
		}
		return result;
	}
	
	// 관리자 시설에약 요청 list (관리자)
	@Override
	public List<ResTotal> listfacil(ResTotal resT) {
		List<ResTotal> reserList = null;
		System.out.println("HsResDaoImpl listfacil Start...");
		try {
			reserList = session.selectList("hsResListAppr",resT);
			System.out.println("HsResDaoImpl listfacil reserList.size()-> "+reserList.size());
		} catch (Exception e) {
			System.out.println("HsResDaoImpl listfacil e.getMessage()-> "+e.getMessage());
		}
		
		System.out.println("HsResDaoImpl listfacil End...");
		return reserList;
	}
	
	// 관리자 시설예약 승인/반려 사유 insert
	@Override
	public int insertFacil(ResTotal facAp) {
		int result = 0;
		System.out.println("HsResDaoImpl insertFacil Start...");
		try {
			result = session.insert("hsResAppInsert", facAp);
			System.out.println("HsResDaoImpl insertFacil result-> "+result);
		} catch (Exception e) {
			System.out.println("HsResDaoImpl insertFacil e.getMessage()-> "+e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	// 관리자 시설예약 승인/반려 상태 update
	@Override
	public int updateFac(ResTotal facAp) {
		int updateCount = 0;
		System.out.println("HsResDaoImpl updateFac Start...");
		
		try {
			updateCount = session.update("hsupdateResApp", facAp);
			System.out.println("HsResDaoImpl updateFac updateCount-> "+updateCount);
		} catch (Exception e) {
			System.out.println("HsResDaoImpl updateFac e.getMessage()-> "+e.getMessage());
		}
		return updateCount;
	}


}
