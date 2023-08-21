
package com.example.unicle.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.unicle.board.dto.BoardDTO;
import com.example.unicle.board.service.BoardService;
import com.example.unicle.member.dto.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//boardType-002
@Controller
@RequestMapping("/board")
public class BoardController {

	private final BoardService boardService;

	public BoardController(BoardService boardService) {
		this.boardService = boardService;
	}

	// 게시판 목록 페이지 요청 처리
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
			pv.setBoardType("002");
			int totalRecord = boardService.countProcess(pv);
			if (totalRecord >= 1) {
				if (pv.getCurrentPage() == 0)
					pv.setCurrentPage(1);
				pv.setTotalCount(totalRecord);
				pv.setPageProcess(pv.getCurrentPage(), totalRecord);
				mav.addObject("pv", pv);
				if(pv.getWriter() != null ) {
					mav.addObject("isMyBoard", true);
				}
				mav.addObject("boardList", boardService.getAllBoards(pv));
			}
		} else {
			// 로그인되지 않은 사용자라면 로그인 페이지로 리다이렉트
			return new ModelAndView("redirect:/member/login");
		}

		mav.setViewName("board/list" + "");
		return mav;
	}

	@GetMapping("/write")
	public String Boardwrite(Model model) {
		model.addAttribute("boardDTO", new BoardDTO());
		return "board/write";
	}

	@PostMapping("/submit")
	public String submitBoard(BoardDTO boardDTO, HttpServletRequest request, Model model) {
		// 세션에서 로그인된 사용자 정보를 가져와서 boardDTO에 저장
		HttpSession session = request.getSession();
		MemberDTO loggedInUser = (MemberDTO) session.getAttribute("user");

		boardDTO.setBoardType("002");
		boardDTO.setWriter(loggedInUser.getB_userId());

		boardService.insertBoard(boardDTO);
		// System.out.println(boardService);

		request.setAttribute("result", boardDTO.getSubject());
		request.setAttribute("result", boardDTO.getContent());

		// 게시물 등록 후 리다이렉트할 경로를 지정합니다. 여기서는 list 페이지로 리다이렉트합니다.
		return "redirect:/board/list";
	}

	@DeleteMapping("/delete/{num}")
	public void deleteBoard(@PathVariable("num") int num) {
		boardService.deleteBoard(num);
	}

	@GetMapping("/delete/{num}")
	public String boardDelete(@PathVariable("num") int num, Model model) {
		boardService.deleteBoard(num);
		return "redirect:/board/list";
	}
	
	@GetMapping("/update/{num}")
	public String boardUpdateForm(@PathVariable("num") Integer num, Model model) {
		BoardDTO boardDTO = boardService.selectDetail(num);
		
		model.addAttribute("num", num);
		model.addAttribute("subject", boardDTO.getSubject());
		model.addAttribute("content", boardDTO.getContent());
		model.addAttribute("upload", boardDTO.getUpload());
		return "board/update";
	}
	
	@PostMapping("/update")
	public String boardUpdate(BoardDTO boardDTO, HttpServletRequest request,  Model model) {		
		
		boardService.updateBoard(boardDTO);
		
		return "redirect:/board/list";
    }


}
