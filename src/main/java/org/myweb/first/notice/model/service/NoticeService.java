package org.myweb.first.notice.model.service;

import java.util.ArrayList;

import org.myweb.first.notice.model.dto.Notice;

public interface NoticeService {
	Notice selectLast();
	ArrayList<Notice> selectTop3();
	Notice selectNotice(int noticeNo);
	ArrayList<Notice> selectSearchTitle(String keyword);
	int insertNotice(Notice notice);
	int updateAddReadCount(int noticeNo);
	ArrayList<Notice> selectList();
}
