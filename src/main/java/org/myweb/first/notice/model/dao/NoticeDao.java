package org.myweb.first.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.myweb.first.notice.model.dto.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("noticeDao")
public class NoticeDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//ajax �뀒�뒪�듃�슜 : 留덉�留� �벑濡앸맂 理쒓렐 怨듭�湲� �븳 媛� 議고쉶�슜 硫붿냼�뱶
	public Notice selectLast() {
		return sqlSessionTemplate.selectOne("noticeMapper.selectLast");
	}
	
	//ajax : 理쒓렐 �벑濡� 怨듭�湲� 3媛� 議고쉶�슜
	public ArrayList<Notice> selectTop3(){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectTop3");
		return (ArrayList<Notice>)list;
	}
	
	// 상세보기 처리를 위한 공지글 1개 조회용
	public Notice selectNotice(int noticeno) {
		return sqlSessionTemplate.selectOne("noticeMapper.selectNotice", noticeno);
	}
	
	//怨듭� �젣紐� 寃��깋
	public ArrayList<Notice> selectSearchTitle(String keyword){
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectSearchTitleKeyword", keyword);
		return (ArrayList<Notice>)list;
	}
	
	//�깉 怨듭�湲� �벑濡�
	public int insertNotice(Notice notice) {
		return sqlSessionTemplate.insert("noticeMapper.insertNotice", notice);
	}
	
	//조회수 증가처리
	public int updateAddReadCount(int noticeNo) {
		return sqlSessionTemplate.update("noticeMapper.updateAddReadCount", noticeNo);
	}

	public ArrayList<Notice> selectList() {
		List<Notice> list = sqlSessionTemplate.selectList("noticeMapper.selectList");
		return (ArrayList<Notice>)list;
	}
}






