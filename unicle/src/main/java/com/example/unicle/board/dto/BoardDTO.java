package com.example.unicle.board.dto;


import java.sql.Date;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.example.unicle.member.dto.MemberDTO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor   //파라미터가 없는 생성자 
@AllArgsConstructor 
@Getter     //getter 메소드
@Setter  

@Component // lombok을 이용해서 할때는 필요없다.
public class BoardDTO extends PageDTO{
	private int num, readcount, ref, re_step, re_level; 
	private String writer, subject, content, ip, memberEmail;
	private Date reg_date;
	private String boardType;
	private String b_userId;
	
	//board테이블에서 writer컬럼을 삭제하고 작성자를 받을 변수
	private MemberDTO memberDTO; 
	//첨부파일 처리를 위해서는 두가지의 변수가 필요한데, 
	//spring은 file을 내보낼 때 MultipartFile을 이용하지만 oracle에는 MultipartFile가 없으므로 String으로 받는다. 
	private String upload; //board 테이블의 파일첨부를 처리해주는 멤버변수
	private MultipartFile filename; //form 페이지에서 파일첨부를 받아 처리해주는 멤버변수 	
	

	public BoardDTO(int currentPage, int totalCount, String searchKey, String searchWord) {
		this.setCurrentPage(currentPage);
		this.setTotalCount(totalCount);
		this.setSearchKey(searchKey);
		this.setSearchKey(searchWord);
	}	

	public MemberDTO getMemberDTO() {
		return memberDTO;
	}

	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}
	
	public String getB_userId() {
		return b_userId;
	}

	public void setB_userId(String b_userId) {
		this.b_userId = b_userId;
	}
	
	public String getWriter() {
		return writer;
	}

	public void getWriter(String writer) {
		this.writer = writer;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public String getUpload() {
		return upload;
	}

	public void setUpload(String upload) {
		this.upload = upload;
	}
	
	public MultipartFile getFilename() {
		return filename;
	}

	public void setFilename(MultipartFile filename) {
		this.filename = filename;
	}	
	

	public String getBoardType() {
		return boardType;
	}

	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	
	
}