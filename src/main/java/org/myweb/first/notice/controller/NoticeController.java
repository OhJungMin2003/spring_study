package org.myweb.first.notice.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.myweb.first.common.FileNameChange;
import org.myweb.first.member.model.dto.Member;
import org.myweb.first.notice.model.dto.Notice;
import org.myweb.first.notice.model.service.NoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class NoticeController {
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	@Autowired
	private NoticeService noticeService;
	
	// 뷰 페이지 이동 처리용 메소드 --------------------------
	// 새 공지글 등록 페이지로 이동 처리용
	@RequestMapping("moveWrite.do")
	public String moveWritePage() {
		return "notice/noticeWriteForm";
	}
	
	// �슂泥� 泥섎━�슜 硫붿냼�뱶 ----------------------------
	@RequestMapping(value = "ntop3.do", method = RequestMethod.POST)
	@ResponseBody
	public String noticeNewTop3Method(HttpServletResponse response) throws UnsupportedEncodingException {
		// ajax �슂泥��떆 由ы꽩諛⑸쾿�� �뿬�윭媛�吏�媛� �엳�쓬 (臾몄옄�뿴, json 媛앹껜 �벑)
		// json 媛앹껜瑜� response 媛앹껜 �씠�슜�떆 2媛�吏� 以묒뿉�꽌 �꽑�깮 媛��뒫
		// 諛⑸쾿1 : 異쒕젰�뒪�듃由쇱쓣 �뵲濡� �깮�꽦�빐�꽌 �쓳�떟�븯�뒗 諛⑸쾿 => public void濡� 吏��젙
		// 諛⑸쾿2 : 酉곕━議몃쾭濡� 由ы꽩�빐�꽌 �벑濡앸맂 JSONView 媛� �궡蹂대궡�뒗 諛⑸쾿 (servlet-context.xml �뿉 �벑濡�)
		// public String �쑝濡� 吏��젙

		// 理쒓렐 �벑濡앸맂 怨듭�湲� 3媛� 議고쉶 �슂泥�
		ArrayList<Notice> list = noticeService.selectTop3();

		// �궡蹂대궪 媛믪뿉 ���빐 response �뿉 mimiType �꽕�젙
		response.setContentType("application/json; charset=utf-8");

		// 由ы꽩�맂 list 瑜� json 諛곗뿴�뿉 �삷寃� 湲곕줉�븯湲�
		JSONArray jarr = new JSONArray();

		for (Notice notice : list) {
			// notice 媛믩뱾�쓣 ���옣�븷 json 媛앹껜 �깮�꽦
			JSONObject job = new JSONObject(); // org.json.simple.JSONObject �엫�룷�듃�븿

			job.put("no", notice.getNoticeNo());
			// 臾몄옄�뿴媛믪뿉 �븳湲��씠 �룷�븿�릺�뼱 �엳�떎硫�, 諛섎뱶�떆 �씤肄붾뵫�빐�꽌 ���옣�빐�빞 �븿
			// java.net.URLEncoder �쓽 static 硫붿냼�뱶�씤 encode('�븳湲��씠�엳�뒗臾몄옄�뿴媛�', '臾몄옄�뀑') �궗�슜�븿
			job.put("title", URLEncoder.encode(notice.getNoticeTitle(), "utf-8"));
			// �궇吏쒕뜲�씠�꽣�뒗 諛섎뱶�떆 臾몄옄�뿴濡� 諛붽퓭�꽌 ���옣�븷 寃� : �궇吏� 洹몃�濡� ���옣�븯硫� 酉곗뿉�꽌 json �쟾泥� 異쒕젰 �븞 �맖
			job.put("date", notice.getNoticeDate().toString());

			jarr.add(job); // 諛곗뿴�뿉 異붽�
		} // for each

		// �쟾�넚�슜 json 媛앹껜 �깮�꽦�븿
		JSONObject sendJson = new JSONObject();
		// �쟾�넚�슜 json �뿉 jarr �쓣 ���옣�븿
		sendJson.put("nlist", jarr);

		return sendJson.toJSONString();
	}
	
	@RequestMapping("ndetail.do")
	public ModelAndView noticeDetailMethod(@RequestParam("no") int noticeNo,ModelAndView mv, HttpSession session) {
		//관리자용 상세보기 페이지와 일반회원 상세보기 페이지를 구분해서 응답 처리함
		//관리자인지 확인하기 위해 session 매개변수 추가
		
		logger.info("ndetail.do : " + noticeNo);
		Notice notice = noticeService.selectNotice(noticeNo);
		
		//조회수 1증가처리
		noticeService.updateAddReadCount(noticeNo);
		
		if(notice != null) {
			mv.addObject("notice", notice);
			
			Member loginUser = (Member)session.getAttribute("loginUser");
			if(loginUser != null && loginUser.getAdminYN().equals("Y")) {
				mv.setViewName("notice/noticeAdminDetail");
			} else {
				mv.setViewName("notice/noticeDetailView");
			}
		} else {
			mv.addObject("message", noticeNo + "번 공지글 상세보기 요청 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	// 공지사항 전체 목록보기 요청 처리용 (페이징 처리 : 한 페이지에 10개씩 출력 처리)
	@RequestMapping("nlist.do")
	public ModelAndView noticeListMethod(ModelAndView mv) {
		
		ArrayList<Notice> list = noticeService.selectList();
		
		if(list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.setViewName("notice/noticeListView");
		} else {
			mv.addObject("message", "목록 조회 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	// 새 공지글 등록 요청 처리용 (파일 업로드 기능 추가)
	@RequestMapping(value="ninsert.do", method=RequestMethod.POST)
	public String noticeInsertMethod(Notice notice, Model model,
			@RequestParam(name="ofile", required=false) MultipartFile mfile,
			HttpServletRequest request) {
		logger.info("ninsert.do : " + notice);
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		if(!mfile.isEmpty()) {
			// 전송온 파일이름 추출함
			String fileName = mfile.getOriginalFilename();
			String renameFileName = null;
			
			// 저장폴더에는 변경된 이름을 저장 처리함
			// 파일 이름바꾸기함 : 년월일시분초.확장자
			
			if(fileName != null && fileName.length() > 0) {
				// 바꿀 파일명에 대한 문자열 만들기
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
				
				// 바뀐 파일명 확인
				logger.info("첨부파일명 확인 : " + renameFileName);
				
				try {
					// 저장 폴더에 파일명 바꾸어 저장하기
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 저장 실패");
					return "common/error";
				}
			} // 파일명 바꾸기
			
			// notice 객체에 첨부파일 정보 저장 처리
			notice.setOriginalFilePath(fileName);
			notice.setRenameFilePath(renameFileName);
		} else {
			
		}
		
		if(noticeService.insertNotice(notice) > 0) {
			//새 공지글 등록 성공시 목록 페이지 내보내기 요청
			return "redirect:nlist.do";
		} else {
			model.addAttribute("message", "새 공지글 등록 실패");
			return "common/error";
		}
	}
	
	// 첨부파일 다운로드 요청 처리용 메소드
	// 공통모듈로 작성된 FileDownloadView 클래스를 이용함 => 반드시 리턴타입이 ModelAndView 이어야 한다
	@RequestMapping("nfdown.do")
	public ModelAndView filedownMethod(
			HttpServletRequest request, ModelAndView mv,
			@RequestParam("ofile") String originalFileName,
			@RequestParam("rfile") String renameFileName) {
		
		// 공지사항 첨부파일 저장 폴더 경로 지정
		String savePath = request.getSession().getServletContext().getRealPath("resources/notice_upfiles");
		
		// 저장 폴더에서 읽을 파일에 대한 File 객체 생성
		File downFile = new File(savePath + "\\" + renameFileName);
		
		// 파일 다운시 브라우저로 내보낼 원래 파일에 대한 File 객체 생성함
		File originFile = new File(originalFileName);
		
		//파일 다운 처리용 뷰클래스 id 명과 다운로드할 File 객체를 ModelAndView 에 담아서 리턴함
		mv.setViewName("filedown");  //뷰클래스의 id명 기입
		mv.addObject("originFile", originFile);
		mv.addObject("renameFile", downFile);
		
		return mv;
	}
}
