package com.example.unicle.map.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.unicle.map.dto.JongjuDTO;
import com.example.unicle.map.service.JongjuService;

@CrossOrigin("*")
@RestController
public class JongjuController {
	
	//국토종주 인증센터 위치 
	@Autowired
	private JongjuService jongjuService;
	
	public JongjuController() {
		
	}
	
	@GetMapping("/jongju")
	public List<JongjuDTO> getList() throws Exception{
		return jongjuService.search();
	}

}
