package com.example.unicle.member.service;

import com.example.unicle.member.dao.MemberDAO;
import com.example.unicle.member.dto.MemberDTO;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImp implements MemberService {

    private final MemberDAO memberDAO;

    @Autowired
    public MemberServiceImp(MemberDAO memberDAO) {
        this.memberDAO = memberDAO;
    }

    @Override
    public void addMemberProcess(MemberDTO memberDTO) {
        memberDAO.addMemberProcess(memberDTO);
    }

    @Override
    public boolean loginProcess(MemberDTO memberDTO, HttpSession session) {
        MemberDTO member = memberDAO.selectById(memberDTO.getB_userId());   
        if (member == null || !member.getB_userPass().equals(memberDTO.getB_userPass())) {
            // 사용자가 입력한 아이디에 해당하는 사용자가 없거나 비밀번호가 일치하지 않음
            return false;
        }
        session.setAttribute("user", member);
        // 로그인 성공 시 HttpSession을 사용하여 세션을 설정하거나 필요한 작업 수행
        return true;
        
    }

    @Override
    public void updateMember(MemberDTO memberDTO) {
        memberDAO.updateMember(memberDTO);
    }

    @Override
    public boolean checkPassword(MemberDTO user, String b_userPass) {
        // 사용자가 입력한 비밀번호와 DB에 저장된 사용자의 비밀번호를 비교하여 일치하는지 확인
        String hashedPassword = user.getB_userPass(); // DB에 저장된 사용자의 비밀번호 (해시값으로 가정)
        // 여기서는 해시값으로 저장된 비밀번호를 평문으로 비교하고 있지만, 실제로는 보안을 위해 별도의 비밀번호 암호화/복호화 작업이 필요합니다.
        if (b_userPass.equals(hashedPassword)) {
            // 비밀번호가 일치하는 경우
            return true;
        } else {
            // 비밀번호가 일치하지 않는 경우
            return false;
        }
    }

    @Override
    public void deleteMember(String b_userId) {
        memberDAO.deleteMember(b_userId);
    }



	

}

