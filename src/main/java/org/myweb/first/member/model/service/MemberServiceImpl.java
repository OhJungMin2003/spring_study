package org.myweb.first.member.model.service;

import java.util.ArrayList;

import org.myweb.first.member.model.dao.MemberDao;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.member.model.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//스프링에서는 서비스 인터페이스를 상속받은 후손클래스를 작성하도록 정해놓음
@Service("memberService")
public class MemberServiceImpl implements MemberService {
	//dao 와 연결 처리 : DI (Dependency Injection : 의존성 주입)
	@Autowired  //자동 객체 생성되면서 연결됨
	private MemberDao memberDao;
	
	@Override
	public User selectLogin(User user) {		
		return memberDao.selectLogin(user);	
	}

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectMember(String userId) {
		return memberDao.selectMember(userId);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}

	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(userId);
	}

	@Override
	public ArrayList<Member> selectList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectCheckId(String userid) {
		return memberDao.selectCheckId(userid);
	}

}
