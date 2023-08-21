package com.example.unicle.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @GetMapping("/index")
    public String indexPage() {
        return "index"; // index.jsp 또는 index.html 뷰를 렌더링
    }
}
