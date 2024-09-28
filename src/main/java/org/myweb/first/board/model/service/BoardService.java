package org.myweb.first.board.model.service;

import java.util.ArrayList;

import org.myweb.first.board.model.dto.Board;

public interface BoardService {
	ArrayList<Board> selectTop3();
}
