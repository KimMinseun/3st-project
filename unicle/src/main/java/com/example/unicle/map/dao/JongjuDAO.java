package com.example.unicle.map.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.example.unicle.map.dto.JongjuDTO;

//SELECT ID=''값은 DAO의 메소드와 같게 설정해야 한다
//class를 만들지 않고 작업 
@Mapper  //알아서 mapper를 찾는다 
@Repository
public interface JongjuDAO {
	public List<JongjuDTO> getJongjuList() throws Exception;

	

}
