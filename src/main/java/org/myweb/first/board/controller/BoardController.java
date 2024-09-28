package org.myweb.first.board.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.myweb.first.board.model.dto.Board;
import org.myweb.first.board.model.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "btop3.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardTop3Method(HttpServletResponse response) throws UnsupportedEncodingException {
		ArrayList<Board> list = boardService.selectTop3();
		
		response.setContentType("application/json; charset=utf-8");
		JSONArray jarr = new JSONArray();

		for (Board board : list) {
			JSONObject job = new JSONObject();

			job.put("no", board.getBoardNum());
			job.put("title", URLEncoder.encode(board.getBoardTitle(), "utf-8"));
			job.put("date", board.getBoardDate().toString());

			jarr.add(job);
		}
		JSONObject sendJson = new JSONObject();
		sendJson.put("blist", jarr);
		return sendJson.toJSONString();
	}
	
}
