package org.myweb.first.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.member.model.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("memberDao")
public class MemberDao {
	//쿼리문은 마이바티스 매퍼 파일에 쿼리문 별도 작성하
	//root-context.xml 에 설정된 마이바티스 객체를 연결 사용함
	@Autowired  //root-context.xml 에서 생성한 객체를 자동 연결함
	private SqlSessionTemplate sqlSessionTemplate;  
	
	//로그인 처리용
	public User selectLogin(User user) {
		//마이바티스가 제공하는 selectOne("매퍼의 앨리먼트 id명", 전달할 객체) : Object => 객체 하나 반환됨
		return sqlSessionTemplate.selectOne("memberMapper.selectLogin", user);		
	}
	
	//회원가입시 아이디 중복 검사용
	public int selectCheckId(String userid) {
		return sqlSessionTemplate.selectOne("memberMapper.selectCheckId", userid);
	}
	
	//회원가입 처리용
	public int insertMember(Member member) {
		return sqlSessionTemplate.insert("memberMapper.insertMember", member);
	}
	
	//내 정보 보기 요청 처리용
	public Member selectMember(String userId) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMember", userId);
	}
	
	//회원 정보 수정 요청 처리용
	public int updateMember(Member member) {
		return sqlSessionTemplate.update("memberMapper.updateMember", member);
	}
	
	//회원 삭제 처리용
	public int deleteMember(String userId) {
		return sqlSessionTemplate.delete("memberMapper.deleteMember", userId);
	}
}









