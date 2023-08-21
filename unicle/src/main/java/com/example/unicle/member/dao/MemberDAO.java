package com.example.unicle.member.dao;

import org.apache.ibatis.annotations.Mapper;


import com.example.unicle.member.dto.MemberDTO;

@Mapper
public interface MemberDAO {

	public void addMemberProcess(MemberDTO memberDTO);
    public MemberDTO selectById(String b_userid);
    
    void updateMember(MemberDTO memberDTO);    
    public boolean checkPassword(MemberDTO user, String b_userPass);
    
	public void deleteMember(String b_userId);
	
	
	
	

}
