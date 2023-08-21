package com.example.unicle.member.dto;

import lombok.Data;

@Data
public class MemberDTO {

	private String b_userId;
	private String b_userPass;
	private String b_nickname;
	private String b_userPhone;
	private String b_userAdd;
	private String b_userGender;
	private String memberemail; 
	private String b_admin;

	public MemberDTO() {

	}

	
	public String getB_userId() {
		return b_userId;
	}

	public void setB_userId(String b_userId) {
		this.b_userId = b_userId;
	}

	public String getB_userPass() {
		return b_userPass;
	}

	public void setB_userPass(String b_userPass) {
		this.b_userPass = b_userPass;
	}

	public String getB_nickname() {
		return b_nickname;
	}

	public void setB_nickname(String b_nickname) {
		this.b_nickname = b_nickname;
	}

	public String getB_userPhone() {
		return b_userPhone;
	}

	public void setB_userPhone(String b_userPhone) {
		this.b_userPhone = b_userPhone;
	}

	public String getB_userAdd() {
		return b_userAdd;
	}

	public void setB_userAdd(String b_userAdd) {
		this.b_userAdd = b_userAdd;
	}

	public String getB_userGender() {
		return b_userGender;
	}

	public void setB_userGender(String b_userGender) {
		this.b_userGender = b_userGender;
	}

	public String getMemberemail() {
        return memberemail;
    }

    public void setMemberemail(String memberemail) {
        this.memberemail = memberemail;
    }
    
    public String getB_admin() {
        return b_admin;
    }

    public void setB_admin(String b_admin) {
        this.b_admin = b_admin;
    }
	
	public boolean matchPassword(String b_userPass) {
		return this.b_userPass.equals(b_userPass);
	}
	
	

}
