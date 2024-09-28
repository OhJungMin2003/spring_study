package org.myweb.first.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.myweb.first.member.model.dto.Member;
import org.myweb.first.member.model.dto.User;
import org.myweb.first.member.model.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

@Controller // 설정 xml 에 해당 클래스를 Controller 로 자동 등록해 줌
public class MemberController {
	// 이 클래스 안의 메소드들이 잘 동작하는지 확인용 또는 전달값이나 반환된 값 확인용 로그 객체를 생성함
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 뷰페이지 내보내기용 메소드 -------------------------------------

	// 로그인 페이지 내보내기용
	@RequestMapping(value = "loginPage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String moveLoginPage() {
		return "member/loginPage";
	}

	// 회원가입 페이지 내보내기용
	@RequestMapping("enrollPage.do") // 전송방식 생략되면 기본이 get 임
	public String moveEnrollPage() {
		return "member/enrollPage";
	}

	// 요청 받아서 모델쪽 서비스로 넘기고 결과받는 메소드 ----------------------

	// 로그인 처리용 메소드 : Servlet 방식으로 처리
//	@RequestMapping(value = "login.do", method = RequestMethod.POST)
//	public String loginMethod(HttpServletRequest request, HttpServletResponse response) {
//		// 객체에 저장한다면
//		User user = new User();
//		user.setUserId(request.getParameter("userid"));
//		user.setUserPwd(request.getParameter("userpwd"));
//
//		System.out.println("login : " + user);  //전송온 값 확인
//		
//		return "common/main";
//	}

	// 로그인 처리용 메소드 : command 객체 사용
	// 서버로 전송온 parameter 값을 저장하는 객체를 command 객체라고 함
	// input 태그의 name 속성의 이름과 dto(vo) 객체의 필드명이 같으면 command 객체가 값을 자동으로 받음
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String loginMethod(User user, HttpSession session, SessionStatus status, Model model) {
		logger.info("login : " + user); // 전송온 값 확인

		// 서비스 메소드롤 받은 로그인 객체 정보 보내고 결과받기
		// User loginUser = memberService.selectLogin(user);
		// logger.info("loginUser : " + loginUser);

		// 암호화 처리된 패스워드 일치한지 조회는 select 해 온 값으로 비교함
		// 로그인 요청온 회원의 아이디로 먼저 회원 정보를 조회해 옴 >> 조회해 온 정보에서 암호 일치 확인함
		Member loginUser = memberService.selectMember(user.getUserId());

		// 조회해온 회원 정보가 있고, 암호화된 패스워드와 로그인 요청시 전달받은 패스워드가 일치하는지 비교함
		// matches(전달받은 암호글자, 암호화된 패스워드) == true 이면 로그인 성공 처리함
		if (loginUser != null && this.bcryptPasswordEncoder.matches(user.getUserPwd(), loginUser.getUserPwd())) {
			session.setAttribute("loginUser", loginUser);
			status.setComplete(); // 로그인 성공 결과를 보냄 (HttpStatus code 200 보냄)
			return "common/main";
		} else { // 로그인 실패시
			// 스프링에서는 request 에 저장 처리하는 객체정보를 제공함 : Model 클래스임
			// 포워딩 못 함 => 뷰리졸버로 뷰파일명과 뷰로 내보낼 정보가 같이 전달되는 구조임
			// 뷰로 전달되어 출력될 객체 정보는 Model 에 저장하면 뷰와 함께 자동 전달됨
			model.addAttribute("message", "로그인 실패! 아이디나 암호를 다시 확인하세요. 또는 로그인 제한된 회원입니다. 관리자에게 문의하세요.");
			return "common/error";
		}

	} // loginMethod

	// 로그아웃 처리용 메소드
	// 요청에 대한 전송방식이 get 이면, method 속성 생략해도 됨.
	// method 속성 생략하면, value 속성도 표기 생략해도 됨
	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		// request 에 기록된 세션ID를 가지고, sessionScope (세션저장소)에 가서
		// 해당 ID와 일치하는 세션객체를 찾아서 반환받음
		// false 이면 세션객체가 있으면 해당 객체를 리턴받고, 없으면 null 리턴

		if (session != null) { // 세션객체가 있다면
			session.invalidate(); // 세션객체 없앰
			return "common/main";
		} else { // 세션객체가 없다면
			model.addAttribute("message", "로그인 세션이 존재하지 않습니다.");
			return "common/error";
		}
	}
	
	//ajax 통신으로 가입할 회원의 아이디 중복 검사 요청 처리용 메소드
	@RequestMapping(value="idchk.do", method=RequestMethod.POST)
	@ResponseBody  //문자열 하나 내보낼 때는 생략해도 됨
	public void dupCheckIdMethod(@RequestParam("userid") String userId, 
			HttpServletResponse response) throws IOException {
		
		int userIdCount = memberService.selectCheckId(userId);
		String returnStr = null;
		if(userIdCount == 0) {
			returnStr = "ok";
		}else {
			returnStr = "dup";
		}
		
		//response 를 이용해서 클라이언트와 출력스트림을 열어서 문자열값 내보냄
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.append(returnStr);
		out.flush();
		out.close();
	}

//	//회원 가입 요청 처리용 메소드 (파일 첨부 기능이 없는 경우 처리 방식)
//	@RequestMapping(value="enroll.do", method=RequestMethod.POST)
//	public String memberInsertMethod(Member member, Model model) {
//		logger.info("enroll.do : " + member);  //전송온 값 확인
//		
//		//패스워드 암호화 처리
////		String encodePwd = bcryptPasswordEncoder.encode(member.getUserPwd());
////		member.setUserPwd(encodePwd);
//		member.setUserPwd(bcryptPasswordEncoder.encode(member.getUserPwd()));
//		logger.info("after encode : " + member.getUserPwd() + ", length : " + member.getUserPwd().length());		
//		
//		if(memberService.insertMember(member) > 0) {  //회원가입 성공시
//			return "member/loginPage";
//		}else {  //회원가입 실패시
//			model.addAttribute("message", "회원 가입 실패! 확인하고 다시 가입해 주세요.");
//			return "common/error";
//		}
//	}

	// 회원 가입 요청 처리용 메소드 (파일 첨부 기능이 있는 경우 처리 방식) => 첨부된 파일은 별도로 전송받도록 처리함
	// 서버상의 파일 저장 폴더 지정을 위해서 request 객체가 사용됨
	// 업로드되는 파일은 따로 전송받음 => multipart 방식으로 전송옴 => spring 이 제공하는 MultipartFile 사용함
	@RequestMapping(value = "enroll.do", method = RequestMethod.POST)
	public String memberInsertMethod(Member member, Model model, HttpServletRequest request,
			@RequestParam("photofile") MultipartFile mfile) {
		logger.info("enroll.do : " + member); // 전송온 값 확인

		// 패스워드 암호화 처리
//			String encodePwd = bcryptPasswordEncoder.encode(member.getUserPwd());
//			member.setUserPwd(encodePwd);
		member.setUserPwd(bcryptPasswordEncoder.encode(member.getUserPwd()));
		logger.info("after encode : " + member.getUserPwd() + ", length : " + member.getUserPwd().length());

		// 회원가입시 사진 파일첨부가 있을 경우, 저장 폴더 경로 지정 -----------------------------------
		String savePath = request.getSession().getServletContext().getRealPath("resources/photo_files");
		// 서버 엔진이 구동하는 웹에플리케이션(Context)의 루트(webapp) 아래의 "resources/photo_files" 까지의
		// 경로 정보를 조회함
		logger.info("savePath : " + savePath);

		// 첨부파일이 있다면
		if (!mfile.isEmpty()) {
			// 전송온 파일 이름 추출함
			String fileName = mfile.getOriginalFilename();
			// 여러 회원이 업로드한 사진파일명이 중복될 경우를 대비해서 저장파일명 이름바꾸기함
			// 바꿀 파일이름은 개발자가 정함
			// userId 가 기본키이므로 중복이 안됨 => userId_filename 저장형태로 정해봄
			String renameFileName = member.getUserId() + "_" + fileName;

			// 저장 폴더에 저장 처리
			if (fileName != null && fileName.length() > 0) {
				try {
					// mfile.transferTo(new File(savePath + "\\" + fileName));
					// 저장시 바뀐 이름으로 저장 처리함
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					// 첨부파일 저장시 에러 발생
					e.printStackTrace();
					model.addAttribute("message", "첨부파일 업로드 실패!");
					return "common/error";
				}
			}

			// 파일 업로드 정상 처리되었다면
			// member.setPhotoFileName(fileName); //db 저장시에는 원래 이름으로 기록함
			member.setPhotoFileName(renameFileName); // db 저장시에는 변경된 이름으로 기록함
		} // 첨부파일이 있을 때

		if (memberService.insertMember(member) > 0) { // 회원가입 성공시
			return "member/loginPage";
		} else { // 회원가입 실패시
			model.addAttribute("message", "회원 가입 실패! 확인하고 다시 가입해 주세요.");
			return "common/error";
		}
	}

	// '내 정보 보기' 클릭시 회원 정보 조회 요청 처리용 메소드
	// 컨트롤러에서 뷰리졸버로 리턴하는 타입은 String(뷰파일명), ModelAndView 를 사용할 수 있음
	// 클라이언트가 보낸 데이터 추출은 String 변수명 = request.getParameter("전송이름");
	// 스프링에서는 전송값 추출을 위한 위의 구문과 같은 동작을 수행하는 어노테이션이 제공되고 있음
	// @RequestParam("전송이름") == request.getParameter("전송이름") 과 같음
	// @RequestParam("전송이름") 자료형 변수명 => 메소드 () 안에서 사용하는 어노테이션임
	@RequestMapping("myinfo.do")
	public String memberDetailMethod(@RequestParam("userId") String userId, Model model) {
		logger.info("myinfo.do : " + userId);

		// 서비스 메소드로 아이디 전달하고, 해당 회원 정보 받기
		Member member = memberService.selectMember(userId);

		if (member != null) { // 전송온 아이디로 회원 조회 성공시
			// 첨부된 사진파일이 있다면, 원래 파일명으로 변경해서 뷰로 전달함
			String originalFilename = null;
			if (member.getPhotoFileName() != null) {
				originalFilename = member.getPhotoFileName().substring(member.getPhotoFileName().indexOf('_') + 1);
			}
			model.addAttribute("member", member);
			model.addAttribute("ofile", originalFilename);

			return "member/infoPage";
		} else { // 조회 실패시
			model.addAttribute("message", userId + "에 대한 회원 정보 조회 실패!");
			return "common/error";
		}

	}

	@RequestMapping(value = "mupdate.do", method = RequestMethod.POST)
	public String memberUpdateMethod(Member member, Model model, HttpServletRequest request,
			@RequestParam("photofile") MultipartFile mfile, @RequestParam("originalUserPwd") String originalUserPwd,
			@RequestParam("ofile") String originalFileName) {
		logger.info("mupdate.do : " + member); // 전송온 값 확인

		if (member.getUserPwd() != null && member.getUserPwd().length() > 0) { // 암호가 변경되었다면
			// 패스워드 암호화 처리
			member.setUserPwd(bcryptPasswordEncoder.encode(member.getUserPwd()));
			logger.info("after encode : " + member.getUserPwd() + ", length : " + member.getUserPwd().length());

		} else { // 암호가 변경되지 않았다면 userPwd == null
			member.setUserPwd(originalUserPwd); // 원래 패스워드로 기록 저장
		}

		// 회원가입시 사진 파일첨부가 있을 경우, 저장 폴더 경로 지정 -----------------------------------
		String savePath = request.getSession().getServletContext().getRealPath("resources/photo_files");
		// 서버 엔진이 구동하는 웹에플리케이션(Context)의 루트(webapp) 아래의 "resources/photo_files" 까지의
		// 경로 정보를 조회함
		logger.info("savePath : " + savePath);

		// 수정된 첨부파일이 있다면
		if (!mfile.isEmpty()) {
			// 전송온 파일 이름 추출함
			String fileName = mfile.getOriginalFilename();

			// 이전 파일명과 새로 첨부된 파일명이 다른지 확인
			if (!fileName.equals(originalFileName)) {

				// 여러 회원이 업로드한 사진파일명이 중복될 경우를 대비해서 저장파일명 이름바꾸기함
				// 바꿀 파일이름은 개발자가 정함
				// userId 가 기본키이므로 중복이 안됨 => userId_filename 저장형태로 정해봄
				String renameFileName = member.getUserId() + "_" + fileName;

				// 저장 폴더에 저장 처리
				if (fileName != null && fileName.length() > 0) {
					try {
						// mfile.transferTo(new File(savePath + "\\" + fileName));
						// 저장시 바뀐 이름으로 저장 처리함
						mfile.transferTo(new File(savePath + "\\" + renameFileName));
					} catch (Exception e) {
						// 첨부파일 저장시 에러 발생
						e.printStackTrace();
						model.addAttribute("message", "첨부파일 업로드 실패!");
						return "common/error";
					}
				}

				// 파일 업로드 정상 처리되었다면
				// member.setPhotoFileName(fileName); //db 저장시에는 원래 이름으로 기록함
				member.setPhotoFileName(renameFileName); // db 저장시에는 변경된 이름으로 기록함
			} // 첨부파일이 있을 때
		} else { // 수정된 첨부파일과 원래 첨부파일명이 같은 경우 (폴더에 저장된 상태임)
			member.setPhotoFileName(member.getUserId() + "_" + originalFileName);
		} 

		if (memberService.updateMember(member) > 0) { // 회원정보 수정 성공시
			return "redirect:main.do";
		} else { // 회원정보 수정 실패시
			model.addAttribute("message", "회원 정보 수정 실패! 확인하고 다시 수정해 주세요.");
			return "common/error";
		}
	}

	// 회원 탈퇴(삭제) 요청 처리용
	@RequestMapping("mdelete.do")
	public String memberDeleteMethod(@RequestParam("userid") String userId, Model model) {
		// 회원 탈퇴 요청시 자동 로그아웃 처리해야 함
		if (memberService.deleteMember(userId) > 0) {
			// 컨트롤러 내의 메소드 또는 다른 컨트롤러의 메소드를 직접 호출할 경우
			return "redirect:logout.do";
		} else {
			model.addAttribute("message", userId + "님의 회원 탈퇴 실패! 관리자에게 문의하세요.");
			return "common/error";
		}
	}

} // MemberController.class
