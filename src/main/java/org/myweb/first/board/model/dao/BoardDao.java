package org.myweb.first.board.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.board.model.dto.Board;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public ArrayList<Board> selectTop3() {
		List<Board> list = sqlSessionTemplate.selectList("boardMapper.selectTop3");
		return (ArrayList<Board>)list;
	}
	
	
	
}
