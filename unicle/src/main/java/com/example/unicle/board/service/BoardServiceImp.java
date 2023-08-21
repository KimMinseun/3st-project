package com.example.unicle.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.unicle.board.dao.BoardDAO;
import com.example.unicle.board.dto.BoardDTO;
import com.example.unicle.board.dto.PageDTO;

@Service
public class BoardServiceImp implements BoardService {

	@Autowired
	private BoardDAO boardDAO;

	@Override
	public List<BoardDTO> getAllBoards(BoardDTO boardDTO) {
		return boardDAO.getAllBoards(boardDTO);
	}
	
	

	@Override
	public void insertBoard(BoardDTO boardDTO) {

		// 답변글일 경우
		if (boardDTO.getRef() != 0) {
			boardDAO.reStepCount(boardDTO);
			boardDTO.setRe_step(boardDTO.getRe_step() + 1);
			boardDTO.setRe_level(boardDTO.getRe_level() + 1);
		}
		boardDAO.insertBoard(boardDTO);
	}
	

	@Override
	public int countProcess(BoardDTO boardDTO) {
		return boardDAO.count(boardDTO);
	}

	@Override
	public BoardDTO getBoardById(Long boardId) {
		return boardDAO.getBoardById(boardId);
	}

	@Override
	public void updateBoard(BoardDTO boardDTO) {
		boardDAO.updateBoard(boardDTO);
	}

	@Override
	public BoardDTO selectDetail(int num) {
		return boardDAO.selectDetail(num);
	}

	@Override
	public BoardDTO deleteBoard(int num) {
		boardDAO.deleteBoard(num);
		return null;
	}



//	@Override
//	public BoardDTO deleteBoard(int num) {
//
//		boardDAO.deleteBoard(num);
//	}



}
