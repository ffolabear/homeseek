package com.mvc.homeseek.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mvc.homeseek.model.dto.RoomDto;

@Repository
public class RoomListDaoImpl implements RoomListDao {

	private Logger logger = LoggerFactory.getLogger(RoomListDaoImpl.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<RoomDto> selectRoomlist(int beginItemNo, int endItemNo) {
		
		List<RoomDto> list = null;
		Map<String,Object>map = new HashMap<>();
		
		map.put("beginItemNo", beginItemNo);
		map.put("endItemNo", endItemNo);
		
		
		try {
			list = sqlSession.selectList(NAMESPACE + "selectRoomList",map);
		} catch (Exception e) {
			logger.info("[ Error ] selectRoomList");
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int totalCountRoomList() {
		int totalCount = 0;
		
		try {
			totalCount = sqlSession.selectOne(NAMESPACE+"totalCountRoomList");
		}catch(Exception e) {
			logger.info("[Eroor] totalCount");
			e.printStackTrace();
		}
				
		return totalCount;
	}

	@Override
	public List<RoomDto> selectRoomList2() {
		List<RoomDto> list = null;
		
		try {
			list = sqlSession.selectList(NAMESPACE + "selectRoomList2");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<RoomDto> mypageMyRoomList(String room_id) {
		
		logger.info(" [ RoomListDaoImpl ] ");
		
		List<RoomDto> list = null;
		
		try {
			list = sqlSession.selectList(NAMESPACE + "mypageMyRoomList", room_id);
		} catch (Exception e) {
			logger.info(" [ Error ] mypageMyRoomList ");
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int muldeleteMyRoomList(int room_no) {
		
		logger.info(" [ RoomListDaoImpl ] ");
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "muldeleteMyRoomList", room_no);
		} catch (Exception e) {
			logger.info("[ Error ] nuldeleteMyRoomList");
			e.printStackTrace();
		}
		return res;
	}
	
	



}
