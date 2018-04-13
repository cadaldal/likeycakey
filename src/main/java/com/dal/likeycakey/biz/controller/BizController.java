package com.dal.likeycakey.biz.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.multipart.MultipartFile;

import org.springframework.web.servlet.ModelAndView;

import com.dal.likeycakey.biz.model.service.BizService;
import com.dal.likeycakey.biz.model.vo.BizMember;
import com.dal.likeycakey.detailView.model.vo.CustomBoard;
import com.dal.likeycakey.detailView.model.vo.ProductBoard;
import com.dal.likeycakey.member.model.vo.Member;

@Controller
public class BizController {

	@Autowired
	private BizService bizService; // = new BizServiceImpl();

	// 사업자 로그인
	@RequestMapping(value = "bizLogin.ca", method = RequestMethod.GET)
	public String bizLogin() {

		return "biz/bizLogin";
	}

	// 로그인 체크

	@RequestMapping(value = "loginCheck2.ca", method = RequestMethod.POST)
	public void loginCheck(ModelAndView mv, HttpSession session, Member member, HttpServletResponse response) {

		try {

			PrintWriter out = response.getWriter();
			// 데이터베이스에 저장된 아이디와 비밀번호를 입력된 아이디와 비밀번호를 비교하여 결과값을 result에 저장
			member = bizService.loginCheck(member.getId(), member.getPasswd());
			
			session.setAttribute("member", member);
			int result = 0;
			if (member != null) {
				result = 1;
			}

			// 결과가 0보다 크면 ok출력
			if (result > 0) {
				out.print("ok");
			} else {
				out.print("no");
			}
			out.flush();
			out.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 로그아웃
	@RequestMapping(value = "logout.ca", method = RequestMethod.GET)
	public ModelAndView memberLogout(HttpSession session, ModelAndView mv) {

		if (session.getAttribute("member") != null) {
			session.invalidate();
		}
		mv.setViewName("home");

		return mv;
	}

	// 아이디 중복검사
	@RequestMapping(value = "dupid.ca", method = RequestMethod.POST)
	public void dupid(ModelAndView mv, @RequestParam("id") String id, HttpServletResponse response) throws IOException {

		PrintWriter out = response.getWriter();
		int result = bizService.dupid(id);
		if (result > 0)
			out.print("no");
		else
			out.print("ok");
		out.flush();
		out.close();
	}

	// 사업자 회원가입 페이지로 간다
	@RequestMapping(value = "bizJoin.ca", method = RequestMethod.GET)
	public String bizJoin() {

		return "biz/bizJoin";
	}

	// 회원가입한 멤버 등록
	@RequestMapping(value = "bizInsert.ca", method = RequestMethod.POST)
	public ModelAndView bizInsert(Member m, @RequestParam("bizName") String bizName,
			@RequestParam("bizPn") String bizPn, @RequestParam("bizNum") String bizNum,
			@RequestParam("bizDelivery") int bizDelivery, @RequestParam("masterName") String masterName,
			@RequestParam("bizDeliveryYn") String bizDeliveryYn, @RequestParam("bizCustomYn") String bizCustomYn,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
			ModelAndView mv) {

		BizMember bm = new BizMember();
		bm.setId(m.getId());
		bm.setBizName(bizName);
		bm.setBizPn(bizPn);
		bm.setBizNum(bizNum);
		bm.setBizDelivery(bizDelivery);
		bm.setMasterName(masterName);
		bm.setBizDeliveryYn(bizDeliveryYn);
		bm.setBizCustomYn(bizCustomYn);

		try {

			// 해당 컨테이너의 구동중인 웹 애플리케이션의 루트 경로 알아냄
			String root = request.getSession().getServletContext().getRealPath("resources");
			// 업로드되는 파일이 저장될 폴더명과 경로 연결 처리
			String savePath = root + "\\img\\member";
			System.out.println("이미지가 저장되는 곳은 " + savePath);

			if (file != null && !file.isEmpty()) {
				if (!new File(savePath).exists()) {
					new File(savePath).mkdir();
				}

				String originFileName = file.getOriginalFilename();
				File fileupload = new File(savePath + "\\" + originFileName);
				file.transferTo(fileupload);
				System.out.println("이미지 저장 완료");
				m.setPhoto(originFileName.substring(0, originFileName.lastIndexOf('.')));
			}
			int result = bizService.insertBiz(m);
			int result2 = bizService.insertBiz2(bm);
			mv.setViewName("redirect:home.ca");
			System.out.println("비즈멤버등록성공");
		} catch (Exception e) {
			mv.setViewName("redirect:home.ca");
			System.out.println(e);
			System.out.println("비즈멤버등록실패");
		}

		return mv;
	}

	// 사업자 회원정보, 매장정보 수정 페이지 이동
	@RequestMapping(value = "bizMypageModify.ca", method = RequestMethod.GET)
	public String bizMypageModify(Model model, HttpSession session) {
		Member m = ((Member)session.getAttribute("member"));
		String bm2 = bizService.getBiz(new BizMember(m.getId()));
		model.addAttribute("mastername",bm2);
		
		return "biz/bizMypageModify";
	}

	// 사업자 회원정보, 매장정보 수정
	@RequestMapping(value = "bizModify.ca", method = RequestMethod.POST)
	public ModelAndView bizModify(@RequestParam(value = "file", required = false) MultipartFile file,
			HttpServletRequest request, @RequestParam("masterName") String masterName,
			@RequestParam("passwd") String passwd, @RequestParam("phone") String phone,
			ModelAndView mv, HttpSession session) {
		
		Member m = (Member)session.getAttribute("member");
		m.setPasswd(passwd);
		m.setPhone(phone);
		
		BizMember bm = new BizMember(m.getId(), masterName);

		
		try {
			if (file != null && !file.isEmpty()) {
			// 해당 컨테이너의 구동중인 웹 애플리케이션의 루트 경로 알아냄
			String root = request.getSession().getServletContext().getRealPath("resources");
			// 업로드되는 파일이 저장될 폴더명과 경로 연결 처리
			String savePath = root + "\\img\\member";
		
			System.out.println("이미지가 저장되는 곳은 " + savePath);
			
			if (!new File(savePath).exists()) {
				new File(savePath).mkdir();
			}
			
			String originFileName = file.getOriginalFilename();
			File fileupload = new File(savePath + "\\" + originFileName);
			file.transferTo(fileupload);
			new File(savePath + "\\" +m.getPhoto()).delete();
			m.setPhoto(originFileName);
			}
			
			int result = bizService.bizModify(m);
			int result2 = bizService.bizModify2(bm);
			session.setAttribute("member", m);
			mv.setViewName("redirect:home.ca");
			System.out.println("비즈 마이페이지 수정 성공");

		} catch (Exception e) {
			System.out.println("비즈 마이페이지 수정 실패" + e);
		}
		return mv;
	}

	// 등록된 케이크가 하나도 없는 상태에서 케이크 등록하는 페이지
	@RequestMapping(value = "nocakeUpload.ca", method = RequestMethod.GET)
	public String nocakeUpload() {

		return "biz/nocakeUpload";
	}

	// 등록한 케이크가 있는 상태에서 케이크 등록하는 페이지
	@RequestMapping(value = "yescakeUpload.ca", method = RequestMethod.GET)
	public String yescakeUpload() {

		return "biz/yescakeUpload";
	}

	// 완제품 케이크 등록 페이지
	@RequestMapping(value = "productCakeUpload.ca", method = RequestMethod.GET)
	public String productCakeUpload() {

		return "biz/productCakeUpload";
	}

	// productCakeUpload 페이지에서 등록하기를 누르면 실제로 데이터베이스에 값을 저장
	@RequestMapping(value = "cakeInsert.ca", method = RequestMethod.POST)
	public ModelAndView cakeInsert(HttpSession session, HttpServletRequest request,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam(name = "inputtag1", required = false) String inputtag1,
			@RequestParam(name = "inputtag2", required = false) String inputtag2,
			@RequestParam(name = "inputtag3", required = false) String inputtag3,
			@RequestParam(name = "inputtag4", required = false) String inputtag4,
			@RequestParam(name = "inputtag5", required = false) String inputtag5, ModelAndView mv,
			ProductBoard productBoard) throws IOException {

		System.out.println("cakeInsert.ca입니다(배송비 꼭 숫자 넣어주세요!!!!)");
		// 해당 컨테이너의 구동중인 웹 애플리케이션의 루트 경로 알아냄
		String root = request.getSession().getServletContext().getRealPath("resources");
		// 업로드되는 파일이 저장될 폴더명과 경로 연결 처리
		String savePath = root + "\\img\\product";
		System.out.println("이미지가 저장되는 곳은 " + savePath);

		if (file != null && !file.isEmpty()) {
			if (!new File(savePath).exists()) {
				new File(savePath).mkdir();
			}

			// 업로도된 파일명을 "년월일시분초.확장자" 로 변경함
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String originFileName = file.getOriginalFilename();
			String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
					+ originFileName.substring(originFileName.lastIndexOf(".") + 1);

			File renameFile = new File(savePath + "\\" + renameFileName);
			file.transferTo(renameFile);
			productBoard.setpImg(renameFileName.substring(0, renameFileName.lastIndexOf('.')));
		}

		// productBoard에 이미지 넣기
		String inputtag = "";
		if (inputtag1 != "") {
			inputtag = inputtag + "#" + inputtag1;
			if (inputtag2 != "") {
				inputtag = inputtag + ", #" + inputtag2;
				if (inputtag3 != "") {
					inputtag = inputtag + ", #" + inputtag3;
					if (inputtag4 != "") {
						inputtag = inputtag + ", #" + inputtag4;
						if (inputtag5 != "") {
							inputtag = inputtag + ", #" + inputtag5;
						}
					}
				}
			}
		}

		productBoard.setPbTag(inputtag);

		// 상품정보
		System.out.println(" 상품정보 : " + productBoard);

		if (bizService.insertProductBoard(productBoard) > 0) {
			System.out.println("프로덕트 케이크 넣기 성공");
			mv.setViewName("biz/productCakeUpload");
		} else {
			System.out.println("프로덕트 케이크 넣기 실패");
			mv.addObject("error", "게시 원글 등록 서비스 실패!");
			mv.setViewName("biz/productCakeUpload");
		}
		return mv;
	}

	// 커스텀 케이크 등록 페이지로 이동
	@RequestMapping(value = "customCakeUpload.ca", method = RequestMethod.GET)
	public String customCakeUpload(HttpSession session) {

		return "biz/customCakeUpload";
	}

	@RequestMapping(value = "customCakeInsert.ca", method = RequestMethod.POST)
	public ModelAndView customCakeInsert(ModelAndView mv, 
			CustomBoard customboard,
			@RequestParam(name = "inputtag1", required = false) String inputtag1,
			@RequestParam(name = "inputtag2", required = false) String inputtag2,
			@RequestParam(name = "inputtag3", required = false) String inputtag3,
			@RequestParam(name = "inputtag4", required = false) String inputtag4,
			@RequestParam(name = "inputtag5", required = false) String inputtag5) {
		
			
			try {
				String inputtag = "";
				if (inputtag1 != "") {
					inputtag = inputtag + "#" + inputtag1;
					if (inputtag2 != "") {
						inputtag = inputtag + ", #" + inputtag2;
						if (inputtag3 != "") {
							inputtag = inputtag + ", #" + inputtag3;
							if (inputtag4 != "") {
								inputtag = inputtag + ", #" + inputtag4;
								if (inputtag5 != "") {
									inputtag = inputtag + ", #" + inputtag5;
								}
							}
						}
					}
				}

				customboard.setCbTag(inputtag);
				bizService.customInsert(customboard);
				mv.setViewName("redirect:home.ca");
				System.out.println("커스텀 케이크 보드 insert 성공!");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("커스텀 케이크 보드 insert 실패...   " + e);
			}
		
		return mv;
	}

	// 케이크 등록하기 버튼 클릭 후 완제품케이크를 등록할건지 커스텀 케이크를 등록할건지 선택하는 페이지
	@RequestMapping(value = "pcSelect.ca", method = RequestMethod.GET)
	public String pcSelect() {

		return "biz/pcSelect";
	}

	// 사업자에게 들어온 문의글 모아보는 페이지
	@RequestMapping(value = "bizQNA.ca", method = RequestMethod.GET)
	public String bizQNA() {

		return "biz/bizQNA";
	}

	// "등록이 완료되었습니다"페이지
	@RequestMapping(value = "uploadComplete.ca", method = RequestMethod.GET)
	public String uploadOK() {

		return "biz/uploadComplete";
	}

	// 사업자 아이디 패스워드 찾는 페이지
	@RequestMapping(value = "findIdPw.ca", method = RequestMethod.GET)
	public String findIdPw() {

		return "biz/findIdPw";
	}

}
