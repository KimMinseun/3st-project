package com.example.unicle.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.example.unicle.map.dao.JongjuDAO;
import com.example.unicle.map.dto.JongjuDTO;

@Service
public class JongjuServiceImp implements JongjuService{
	
	@Autowired
	private JongjuDAO jongjuDAO;
	
	
	public JongjuServiceImp() {
		
	}

	@Override
	public List<JongjuDTO> search() throws Exception {
		
		return jongjuDAO.getJongjuList();
	}
	

}
