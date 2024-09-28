package org.myweb.first.test.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.test.model.dto.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("testDao")
public class TestDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int selectTest(Test test) {
		return sqlSessionTemplate.selectOne("testMapper.selectTest", test);
	}
}
