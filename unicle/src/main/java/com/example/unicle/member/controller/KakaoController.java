//package com.example.unicle.member.controller;
//
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.example.unicle.member.service.KakaoService;
//
//public class KakaoController {
//
//	    private final KakaoService kakaoService;
//
//	    @RequestMapping(value="/", method= RequestMethod.GET)
//	    public String login(Model model) {
//	   
//	        model.addAttribute("kakaoUrl", kakaoService.getKakaoLogin());
//
//	        return "index";
//	    }
//
//}
