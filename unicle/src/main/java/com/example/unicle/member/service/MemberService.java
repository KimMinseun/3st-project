package com.example.unicle.member.service;

import com.example.unicle.member.dto.MemberDTO;

import jakarta.servlet.http.HttpSession;



public interface MemberService {
//	public void insertMember(MemberDTO memberDTO);
	public void addMemberProcess(MemberDTO memberDTO);
	boolean loginProcess(MemberDTO memberDTO, HttpSession session);
	
	void updateMember(MemberDTO memberDTO);
	public boolean checkPassword(MemberDTO user, String b_userPass);
	
	public void deleteMember(String b_userId);


	
	
	
	
	


}
