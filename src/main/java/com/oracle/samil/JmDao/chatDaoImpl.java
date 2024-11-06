package com.oracle.samil.JmDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.samil.Amodel.Chatroom;
import com.oracle.samil.Amodel.Emp;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class chatDaoImpl implements chatDao {

	private final SqlSession session;
	
	// 채팅방 목록 가져오기
	@Override
	public List<Chatroom> listChatRoom(Chatroom chatroom) {
		List<Chatroom> chatRoomList = null;
		System.out.println("chatDaoImpl listChatRoom Start...");
		try {
			//                                      Map ID      parameter
			chatRoomList = session.selectList("chatRoomList", chatroom);
			
		} catch (Exception e) {
			System.out.println("chatDaoImpl listChatRoom e.getMessage() -> " + e.getMessage());		
		}	
		return chatRoomList;
	}
	
	// Ajax 채팅방 이름 가져오기
	@Override
	public String getRoomName(int roomId) {
		System.out.println("chatDaoImpl getRoomName start..");
		String resultStr = "";
			
		try {
			resultStr  = session.selectOne("tkRoomName",roomId);
		} catch (Exception e) {
				System.out.println("chatDaoImpl getRoomName Exception->"+e.getMessage());
		}
			
		return resultStr;
	}
	
	@Override
	public List<Emp> listChatMember(Emp emp) {
		List<Emp> chatMemberList = null;
		System.out.println("chatDaoImpl listChatMember Start...");
		try {
			//                                      Map ID      parameter
			chatMemberList = session.selectList("chatMemberList", emp);
			
		} catch (Exception e) {
			System.out.println("chatDaoImpl listChatMember e.getMessage() -> " + e.getMessage());		
		}	
		return chatMemberList;

	}

	@Override
	public int insertRoom(Chatroom chatroom) {
		System.out.println("chatDaoImpl insertRoom Start...");
		int insertResult = 0;
		
		try {
			insertResult = session.insert("insertRoom", chatroom);

		} catch (Exception e) {
			System.out.println("chatDaoImpl insertRoom e.getMessage() -> " + e.getMessage());	
		}
		return insertResult;
	}

}
