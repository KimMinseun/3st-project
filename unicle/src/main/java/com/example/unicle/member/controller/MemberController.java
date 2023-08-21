package com.example.unicle.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.*;

import com.example.unicle.member.dto.MemberDTO;
import com.example.unicle.member.service.MemberService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @GetMapping("/main")
    public String mainPage() {
        return "main"; // main.jsp 뷰를 렌더링
    }

    @GetMapping("/login")
    public String memberLogin() {
        return "member/login";
    }

    @PostMapping("/loginProcess")
    public String loginProcess(MemberDTO memberDTO, HttpSession session) {
        boolean loginResult = memberService.loginProcess(memberDTO, session);
         if (loginResult) {
          
        
            return "redirect:/member/main"; // 로그인 성공 시 메인 페이지로 리다이렉트
        } else {
            return "redirect:/member/login"; // 로그인 실패 시 로그인 페이지로 리다이렉트
        }
       
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 로그아웃 시 세션에서 사용자 정보를 삭제
        session.invalidate();
        return "redirect:/member/main"; // 로그아웃 후 로그인 페이지로 리다이렉트
    }

    @GetMapping("/signup")
    public String memberSignupForm() {
        return "member/signup"; // signup.html 뷰를 렌더링
    }

    @PostMapping("/signup")
    public String memberSignup(MemberDTO memberDTO) {
        memberService.addMemberProcess(memberDTO);
        return "redirect:/member/login";
    }

    // 회원 수정 페이지 보여주는 요청 처리
    @GetMapping("/update")
    public String memberUpdateForm() {
        return "member/update";
    }
    
    @PostMapping("/update")
    public String updateMember(@ModelAttribute MemberDTO memberDTO) {
        memberService.updateMember(memberDTO);
        System.out.println(memberDTO);
        return "redirect:/member/logout";
    }
    
    @GetMapping("/checkPassword")
    public String showCheckPasswordForm() {
        return "member/checkPassword"; // checkPassword.html 뷰를 렌더링
    }

    @PostMapping("/checkPassword")
    @ResponseBody // 이 주석을 추가하여 반환 값을 응답 본문으로 보내도록 표시
    public ResponseEntity<?> checkPassword(@RequestParam("b_userPass") String b_userPass, HttpSession session) {
        MemberDTO user = (MemberDTO) session.getAttribute("user");
        boolean passwordMatch = memberService.checkPassword(user, b_userPass);
        if (passwordMatch) {
            // 비밀번호가 일치하는 경우
            return ResponseEntity.ok("{\"passwordMatch\": true}");
        } else {
            // 비밀번호가 일치하지 않는 경우
            return ResponseEntity.ok("{\"passwordMatch\": false}");
        }
    }
    
    @PostMapping("/delete")
    public String deleteMember(HttpSession session) {
        // 세션에서 로그인된 사용자 정보 가져오기
        MemberDTO user = (MemberDTO) session.getAttribute("user");

        if (user != null) {
          memberService.deleteMember(user.getB_userId());
          session.invalidate();
        }

        return "redirect:/member/main"; // 탈퇴 후 메인 페이지로 리다이렉트
    }

}