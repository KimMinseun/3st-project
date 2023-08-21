package com.example.unicle.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.unicle.board.dto.BoardDTO;
import com.example.unicle.board.dto.PageDTO;

@Mapper  //알아서 mapper를 찾는다 
@Repository
public interface BoardDAO {
	void insertBoard(BoardDTO boardDTO);
	public List<BoardDTO> getAllBoards(BoardDTO pageDto);
	BoardDTO getBoardById(Long boardId);  
	void reStepCount(BoardDTO boardDTO);
	int count(BoardDTO boardDTO);
	BoardDTO selectDetail(int num);
    void updateBoard(BoardDTO boardDTO);
    
    
    void deleteBoard(int num);
}
