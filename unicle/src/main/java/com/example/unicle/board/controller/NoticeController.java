package com.example.unicle.board.controller;

import java.io.File;
import java.io.IOException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.unicle.board.dto.BoardDTO;
import com.example.unicle.member.dto.MemberDTO;
import com.example.unicle.board.service.BoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//니가 보드타입 001하자 
@Controller
@RequestMapping("/notice")
public class NoticeController {

	private final BoardService boardService;

	public NoticeController(BoardService boardService) {
		this.boardService = boardService;
	}

	@RequestMapping("/list")
	public ModelAndView listExecute(@ModelAttribute("pv") BoardDTO pv, ModelAndView mav, HttpSession session) {
		// 세션에서 로그인된 사용자 정보를 가져옴
		MemberDTO loggedInUser = (MemberDTO) session.getAttribute("user");
		System.out.println(loggedInUser);
		// 세션에서 가져온 로그인된 사용자 정보를 활용하여 필요한 작업 수행
		if (loggedInUser != null) {
			// loggedInUser를 활용하여 필요한 정보를 사용할 수 있습니다.
			String loggedInUserId = loggedInUser.getB_userId();
			// 나머지 페이지 처리 코드는 그대로 유지
			pv.setBoardType("001");
			int totalRecord = boardService.countProcess(pv);
			if (totalRecord >= 1) {
				if (pv.getCurrentPage() == 0)
					pv.setCurrentPage(1);
				pv.setTotalCount(totalRecord);
				pv.setPageProcess(pv.getCurrentPage(), totalRecord);
				mav.addObject("pv", pv);
				mav.addObject("noticeList", boardService.getAllBoards(pv));
			}
		} else {
			// 로그인되지 않은 사용자라면 로그인 페이지로 리다이렉트
			return new ModelAndView("redirect:/member/login");
		}

		mav.setViewName("notice/list" + "");
		return mav;
	}

	@GetMapping("/write")
	public String noticeWriteForm(Model model) {
		model.addAttribute("boardDTO", new BoardDTO());
		System.out.println(model);
		return "/notice/write";

	}

	@PostMapping("/submit")
	public String submitnotice(BoardDTO boardDTO, HttpServletRequest request, Model model) {
		// 세션에서 로그인된 사용자 정보를 가져와서 boardDTO에 저장
		HttpSession session = request.getSession();
		MemberDTO loggedInUser = (MemberDTO) session.getAttribute("user");
		// System.out.println(session);
		boardDTO.setBoardType("001");
		boardDTO.setWriter(loggedInUser.getB_userId());
		boardDTO.setB_userId(loggedInUser.getB_userId());
		boardDTO.setMemberEmail(loggedInUser.getMemberemail());

		boardService.insertBoard(boardDTO);

		request.setAttribute("result", boardDTO.getSubject());
		request.setAttribute("result", boardDTO.getContent());

		// 게시물 등록 후 리다이렉트할 경로를 지정합니다. 여기서는 list 페이지로 리다이렉트합니다.
		return "redirect:/notice/list";
	}

	@GetMapping("/view")
	public String boardView(int num, Model model) {
		BoardDTO boardDTO = boardService.selectDetail(num);
		model.addAttribute("boardDTO", boardDTO);
		return "notice/detail";
	}



	@DeleteMapping("/delete/{num}")
	public void deleteBoard(@PathVariable("num") Integer num) {
		boardService.deleteBoard(num);
	}

	@GetMapping("/delete/{num}")
	public String boardDelete(@PathVariable("num") Integer num, Model model) {
		boardService.deleteBoard(num);
		return "redirect:/notice/list";
	}

	@GetMapping("/update/{num}")
	public String boardUpdateForm(@PathVariable("num") Integer num, Model model) {
		BoardDTO boardDTO = boardService.selectDetail(num);
		
		model.addAttribute("num", num);
		model.addAttribute("subject", boardDTO.getSubject());
		model.addAttribute("content", boardDTO.getContent());
		return "notice/update";
	}
	
	@PostMapping("/update")
	public String boardUpdate(BoardDTO boardDTO, HttpServletRequest request,  Model model) {		
		
		boardService.updateBoard(boardDTO);
		
		return "redirect:/notice/view?num=" + boardDTO.getNum();
    }
}
	
//	// 게시물 수정 처리
//	@PostMapping("/edit")
//	public String editBoard(@RequestParam("boardId") Long boardId, @RequestParam("subject") String subject,
//			@RequestParam("content") String content) {
//		// 게시물 수정 로직 수행 (boardId는 수정할 게시물의 고유한 식별자, title과 content는 수정할 내용)
//		// ... 게시물 수정 로직 ...
//
//		// 수정한 게시물의 상세 페이지로 리다이렉트
//		return "redirect:/notice/view?boardId=" + boardId;
//	}



//	@RequestMapping("/list")
//	public ModelAndView listExecute(@ModelAttribute("pv") PageDTO pv, ModelAndView mav, HttpServletRequest request) {
//	    // Retrieve user information from the session (hypothetical example)
//	    String loggedInUserId = (String) request.getSession().getAttribute("loggedInUserId");
//	    String loggedInUserName = (String) request.getSession().getAttribute("loggedInUserName");
//
//	    System.out.println(loggedInUserId);
//	    System.out.println(loggedInUserName);
//	    
//	    PageDTO pdto = new PageDTO();
//	    
//	    // Retrieve the total number of records from the board service
//	    int totalRecord = boardService.countProcess();
//	   
//	    if (totalRecord >= 1) {
//	        if (pv.getCurrentPage() == 0)
//	            pv.setCurrentPage(1);
//	        pdto = new PageDTO(pv.getCurrentPage(), totalRecord);
//	        mav.addObject("pv", pdto);
//	        mav.addObject("boardList", boardService.getAllBoards(pdto));
//	    }
//	  
//
//	    
//
//	    mav.addObject("loggedInUserId", loggedInUserId);
//	    mav.addObject("loggedInUserName", loggedInUserName);
//	    
//	    
//	    mav.setViewName("board/notice");
//	    return mav;
//	}

//	@RequestMapping("/list")
//	public ModelAndView listExecute(@ModelAttribute("pv")  PageDTO pv, ModelAndView mav) {
//		System.out.println("pv:" + pv.getCurrentPage());
//		PageDTO pdto = new PageDTO();
//		
//		//int totalRecord = boardService.countProcess();
//		int totalRecord = 100;
//		if(totalRecord>=1) {
//		   if(pv.getCurrentPage()==0)
//			   pv.setCurrentPage(1);
//		   pdto = new PageDTO(pv.getCurrentPage(), totalRecord);
//		   mav.addObject("pv", pdto);
//		   mav.addObject("boardList",boardService.getAllBoards(pdto));
//		}
//		System.out.println(mav);
//		mav.setViewName("board/notice");
//		return mav;
//	} 

//	
//	@PostMapping("/submit")
//    public String submitBoard(BoardDTO boardDTO, HttpServletRequest request, Model model) {
//        // 세션에서 로그인된 사용자 정보를 가져와서 boardDTO에 저장
//        HttpSession session = request.getSession();
//        String loggedInUserId = (String) session.getAttribute("loggedInUserId");
//        boardDTO.setB_userId(loggedInUserId);
//       
//        System.out.println(loggedInUserId);
//        System.out.println(session);
//        boardService.insertBoard(boardDTO);
//
//        // 게시물 등록 후 리다이렉트할 경로를 지정합니다. 여기서는 list 페이지로 리다이렉트합니다.
//        return "redirect:/board/list";
//    }
//	

//	@PostMapping("/submit")
//	public String submitBoard(BoardDTO boardDTO, HttpServletRequest request) {
////	    MultipartFile filename = boardDTO.getFilename();
////	    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/");
////	    if (!filename.isEmpty()) {
////	        String originalFilename = filename.getOriginalFilename();
////	        String saveFilename = System.currentTimeMillis() + "_" + originalFilename;
////	        try {
////	            filename.transferTo(new File(uploadPath, saveFilename));
////	            boardDTO.setUpload(saveFilename);
////	        } catch (IOException e) {
////	            e.printStackTrace();
////	        }
////	    }
//		 
//	    boardService.insertBoard(boardDTO);
//	    
//	    request.setAttribute("result", boardDTO.getSubject()); 
//	    request.setAttribute("result", boardDTO.getContent()); 
//	  
//	  
//	    // 게시물 등록 후 리다이렉트할 경로를 지정합니다. 여기서는 list 페이지로 리다이렉트합니다.
//	    return "redirect:/board/list";
//	}

//  // 게시물 삭제를 위한 DELETE 요청 처리
//  @DeleteMapping("/delete/{num}")
//  public void deleteExecute(@PathVariable int num, @RequestParam("filePath") String filePath) {
//      boardService.deleteBoard(num, filePath);
//  }

	/*
	 * 
	 * @RequestMapping("/view") public String boardView(Model model) { BoardDTO
	 * boardDTO = boardService.getBoardById(Long.parseLong("0"));
	 * model.addAttribute("boardDTO", boardDTO); return "board/detail"; }
	 */

