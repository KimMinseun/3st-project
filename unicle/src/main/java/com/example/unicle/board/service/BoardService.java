package com.example.unicle.board.service;

import java.util.List;

import com.example.unicle.board.dto.BoardDTO;
import com.example.unicle.board.dto.PageDTO;

public interface BoardService {
	void insertBoard(BoardDTO boardDTO);

	List<BoardDTO> getAllBoards(BoardDTO boardDTO);

	BoardDTO getBoardById(Long boardId);

	BoardDTO selectDetail(int num);

	int countProcess(BoardDTO boardDTO);

	void updateBoard(BoardDTO boardDTO);

	BoardDTO deleteBoard(int num);

}
