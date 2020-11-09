package com.mvc.homeseek.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.mvc.homeseek.model.dto.MemberDto;

public class MessageHandler extends TextWebSocketHandler {

	private Logger logger = LoggerFactory.getLogger(MessageHandler.class);

	// 로그인 한 전체를 담는 list를 선언해준다.
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();

	// 로그인 중인 개별 유저를 담는 map을 선언해준다.
	private Map<String, WebSocketSession> userSessionMap = new HashMap<String, WebSocketSession>();
	
	
	// 클라이언트가 서버로 연결 시 들어오는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// 접속되어 있는 모든 유저들을 위에서 선언한 sessions에 담아준다.
		sessions.add(session);

		logger.info("\n 1. 현재 접속되어있는 sessions의 아이디는?(얘는 list야) : " + session.getId());

		// userId는 맨 아래 선언되어있는 메소드인데 현재 session에 담긴(로그인한)
		// 아이디를 가져오기 위해서 선언해주었다.
		// String userId = UserId(session);

		//logger.info("\n 6. userId의 값은 뭐니? : " + userId);

		logger.info(" \n [ " + session.getId() + " ] 연결됨 ");
		// 방금 로그인에 성공한 애를 담아준다.
		userSessionMap.put(session.getId(), session);

		for (int i = 0; i < userSessionMap.size(); i++) {
			logger.info("\n 7. userSessionMap에 담겨있는 key값은? : " + userSessionMap.keySet());
			logger.info("\n 7. userSessionMap에 담겨있는 values값은? : " + userSessionMap.values());
		}
	}

	// 클라이언트가 Data 전송 시 실행되는 메소드
	// 클라이언트가 서버로 메세지를 전송했을 때 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		// WebSocket Id = 8 << 이런식으로 뜸

		// session.getId는 접속한 애의 아이디(임의로 부여한듯?)
		logger.info(" \n [ messageHandler ]에서 " + session.getId() + "로부터 message 받음 : " + message);

		// getPayload는 message에 붙여준다?는 느낌인 것 같다.
		String msg = message.getPayload();

		if (StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");

			if (strs != null && strs.length == 3) {
				String cmd = strs[0];
				String message_senid = strs[1];
				String message_reid = strs[2];

				// 작성자가 로그인해있다면

				WebSocketSession boardWriterSession = userSessionMap.get(message_reid);
				logger.info("boardWriterSession? : " + boardWriterSession.toString());
				logger.info("message? : " + cmd);

				if ("message".equals(cmd) && boardWriterSession != null) {

					TextMessage tmpMsg = new TextMessage(message_senid + "님이 " + message_reid + "님에게 쪽지를 보냈습니다.");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}

	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		userSessionMap.remove(session.getId());
		sessions.remove(session);
		logger.info(" \n [ " + session.getId() + " ] 연결 끊김");

	}

	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {

		logger.info(session.getId() + " Exception 발생 : " + exception.getMessage());

	}

	// 웹소켓 id가져오기
	/*
	 * @SuppressWarnings("unused") private String UserId(WebSocketSession session) {
	 * logger.info("\n 2. UserId메소드를 통해서 들어온 session의 id는? : " + session.getId());
	 * 
	 * Map<String, Object> httpSession = session.getAttributes();
	 * logger.info("\n 3. session에 담겨있는 getAttribute를 통해 가져온 Map의 key값은 ? : " +
	 * httpSession.keySet());
	 * logger.info("\n 3. session에 담겨있는 getAttribute를 통해 가져온 Map의 value값은 ? : " +
	 * httpSession.values()); MemberDto loginUser =
	 * (MemberDto)httpSession.get("login");
	 * 
	 * MemberDto loginUser = (MemberDto) session.getAttributes();
	 * logger.info("\n 4. loginUser이라는 MemberDto에 담겨있는 값은? : " +
	 * loginUser.toString());
	 * 
	 * if(loginUser != null) { logger.info("\n 5. 현재 loginUser이 null이 아니니???");
	 * return loginUser.getMember_id(); } else {
	 * logger.info("\n 5. 현재 loginUser이 null이니???"); return session.getId(); } }
	 */
}