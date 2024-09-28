package org.myweb.first.notice.model.service;

import java.util.ArrayList;

import org.myweb.first.notice.model.dao.NoticeDao;
import org.myweb.first.notice.model.dto.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public Notice selectLast() {
		return noticeDao.selectLast();
	}
	
	@Override
	public ArrayList<Notice> selectTop3() {
		return noticeDao.selectTop3();
	}

	@Override
	public ArrayList<Notice> selectSearchTitle(String keyword) {
		return noticeDao.selectSearchTitle(keyword);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public Notice selectNotice(int noticeNo) {
		return noticeDao.selectNotice(noticeNo);
	}

	@Override
	public int updateAddReadCount(int noticeNo) {
		return noticeDao.updateAddReadCount(noticeNo);
		
	}

	@Override
	public ArrayList<Notice> selectList() {
		return noticeDao.selectList();
	}
}
