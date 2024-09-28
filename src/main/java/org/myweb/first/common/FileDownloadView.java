package org.myweb.first.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

//만들 뷰클래스를 servlet-context.xml 에 자동 등록 처리함
//mvc 에 해당되지 않는 일반 클래스 등록은 @Component("등록할 id명") 사용함
@Component("filedown")
public class FileDownloadView extends AbstractView {
	//파일 다운로드 처리용 뷰클래스임
	//스프링에서는 뷰리졸버에 의해 자동 연결 실행될 뷰클래스를 만들 때,
	//반드시 스프링이 제공하는 AbstractView 를 상속받아서 만들도록 정해 두었음
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 파일 다운로드 처리용 코드 작성함
		// 컨트롤러의 메소드에서 리턴해서 보낸 Model 의 값(File 객체)을 추출해서,
		// 저장된 폴더의 파일을 읽어서 요청한 클라이언트 브라우저로 파일을 출력 전송 처리함
		
		//컨트롤러에서 뷰리졸버(BeanNameViewResolver)를 거쳐 전달된 model 의 정보 추출
		File readFile = (File)model.get("renameFile");
		File downFile = (File)model.get("originFile");
		
		//한글 파일명은 깨지지 않게 인코딩 처리를 하기 위해서 파일명만 추출함
		String fileName = downFile.getName();
		
		//파일 다운을 위한 response 에 설정 처리 (클라이언트로 전송하기 위한 설정임)
		response.setContentType("text/plain; charset=utf-8");
		//한글 파일명은 다운되는 클라이언트 컴퓨터의 os(windows) 문자셋과 맞추기함
		response.addHeader("Content-Disposition", "attachment; filename=\"" 
					+ new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
		response.setContentLength((int)readFile.length());
		
		//파일 입출력에 대한 스트림 생성함
		FileInputStream fin = new FileInputStream(readFile);
		OutputStream out = response.getOutputStream();
		
		//저장 폴더에서 readFile 을 read() 해서, response 로 write() | print() 함
		//스프링이 제공함
		FileCopyUtils.copy(fin, out);
		
		fin.close();
	}
	
}





